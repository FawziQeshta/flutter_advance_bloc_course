import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_advance_bloc_course/core/routing/routes.dart';
import 'package:flutter_advance_bloc_course/main_production.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

class FirebaseHelper {
  static final FirebaseHelper _instance = FirebaseHelper._internal();
  factory FirebaseHelper() => _instance;
  FirebaseHelper._internal();

  final FirebaseMessaging _fcm = FirebaseMessaging.instance;
  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  String? _fcmToken;
  Function(RemoteMessage)? _onMessageReceived;
  Function(RemoteMessage)? _onMessageOpenedApp;
  Function(String)? _onTokenRefresh;

  String? get fcmToken => _fcmToken;

  late RemoteMessage remoteMessage;

  // Initialize FCM
  Future<void> initialize({
    Function(RemoteMessage)? onMessageReceived,
    Function(RemoteMessage)? onMessageOpenedApp,
    Function(String)? onTokenRefresh,
  }) async {
    _onMessageReceived = onMessageReceived;
    _onMessageOpenedApp = onMessageOpenedApp;
    _onTokenRefresh = onTokenRefresh;

    // Request permissions
    await _requestPermission();

    // Initialize local notifications
    await _initializeLocalNotifications();

    // Get and save FCM token
    await _getFCMToken();

    // Setup message handlers
    _setupMessageHandlers();

    // Handle initial message (app opened from terminated state)
    _handleInitialMessage();
  }

  // Request notification permissions
  Future<NotificationSettings> _requestPermission() async {
    NotificationSettings settings = await _fcm.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    print('Permission status: ${settings.authorizationStatus}');
    return settings;
  }

  // Initialize local notifications
  Future<void> _initializeLocalNotifications() async {
    const androidSettings = AndroidInitializationSettings(
      '@mipmap/ic_launcher',
    );
    const iosSettings = DarwinInitializationSettings(
      requestAlertPermission: true,
      requestBadgePermission: true,
      requestSoundPermission: true,
    );

    const initSettings = InitializationSettings(
      android: androidSettings,
      iOS: iosSettings,
    );

    await _localNotifications.initialize(
      initSettings,
      onDidReceiveNotificationResponse: _onNotificationTapped,
    );

    // Create Android notification channel
    const channel = AndroidNotificationChannel(
      'high_importance_channel',
      'High Importance Notifications',
      description: 'This channel is used for important notifications.',
      importance: Importance.max,
      playSound: true,
    );

    await _localNotifications
        .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin
        >()
        ?.createNotificationChannel(channel);
  }

  // Get FCM token
  Future<String?> _getFCMToken() async {
    try {
      _fcmToken = await _fcm.getToken();
      print('FCM Token: $_fcmToken');
      return _fcmToken;
    } catch (e) {
      print('Error getting FCM token: $e');
      return null;
    }
  }

  // Setup message handlers
  void _setupMessageHandlers() {
    // Foreground messages
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print('Foreground message received');

      _showLocalNotification(message);
      this.remoteMessage = message;
      _onMessageReceived?.call(message);
    });

    // Background/terminated - app opened by tapping notification
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      print('Message opened app');
      this.remoteMessage = message;
      _onMessageOpenedApp?.call(message);
    });

    // Token refresh
    _fcm.onTokenRefresh.listen((String token) {
      _fcmToken = token;
      print('Token refreshed: $token');
      _onTokenRefresh?.call(token);
    });
  }

  // Handle initial message when app is opened from terminated state
  Future<void> _handleInitialMessage() async {
    RemoteMessage? initialMessage = await _fcm.getInitialMessage();
    if (initialMessage != null) {
      print('App opened from notification (terminated state)');
      _onMessageOpenedApp?.call(initialMessage);
    }
  }

  // Show local notification
  Future<void> _showLocalNotification(RemoteMessage message) async {
    const androidDetails = AndroidNotificationDetails(
      'high_importance_channel',
      'High Importance Notifications',
      channelDescription: 'This channel is used for important notifications.',
      importance: Importance.max,
      priority: Priority.high,
      playSound: true,
      icon: '@mipmap/ic_launcher',
    );

    const iosDetails = DarwinNotificationDetails(
      presentAlert: true,
      presentBadge: true,
      presentSound: true,
    );

    const details = NotificationDetails(
      android: androidDetails,
      iOS: iosDetails,
    );

    await _localNotifications.show(
      message.hashCode,
      message.notification?.title ?? 'New Notification',
      message.notification?.body ?? '',
      details,
      payload: message.data.toString(),
    );
  }

  // Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    print('`Notification tapped with payload:` ${response.payload}');
    navigatorKey.currentState!.pushNamed(
      Routes.notificationsScreen,
      arguments: remoteMessage,
    );
  }

  // Subscribe to topic
  Future<void> subscribeToTopic(String topic) async {
    try {
      await _fcm.subscribeToTopic(topic);
      print('Subscribed to topic: $topic');
    } catch (e) {
      print('Error subscribing to topic: $e');
      rethrow;
    }
  }

  // Unsubscribe from topic
  Future<void> unsubscribeFromTopic(String topic) async {
    try {
      await _fcm.unsubscribeFromTopic(topic);
      print('Unsubscribed from topic: $topic');
    } catch (e) {
      print('Error unsubscribing from topic: $e');
      rethrow;
    }
  }

  // Delete FCM token
  Future<void> deleteToken() async {
    try {
      await _fcm.deleteToken();
      _fcmToken = null;
      print('FCM token deleted');
    } catch (e) {
      print('Error deleting token: $e');
      rethrow;
    }
  }

  // Get notification settings
  Future<NotificationSettings> getNotificationSettings() async {
    return await _fcm.getNotificationSettings();
  }

  // Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    final settings = await getNotificationSettings();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }

  // Request permission again (useful for iOS)
  Future<bool> requestPermissionAgain() async {
    final settings = await _requestPermission();
    return settings.authorizationStatus == AuthorizationStatus.authorized;
  }
}
