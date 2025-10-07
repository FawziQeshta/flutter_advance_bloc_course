import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/core/helpers/extensions.dart';
import 'package:flutter_advance_bloc_course/core/helpers/firebase_helper.dart';
import 'package:flutter_advance_bloc_course/core/helpers/spacing.dart';
import 'package:flutter_advance_bloc_course/core/routing/routes.dart';

class NotificationsScreen extends StatefulWidget {
  final RemoteMessage remoteMessage;
  const NotificationsScreen({super.key, required this.remoteMessage});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  //   final FirebaseHelper _firebaseHelper = FirebaseHelper();
  //   final List<Map<String, dynamic>> _messages = [];
  //   bool _isInitialized = false;
  //   bool _notificationsEnabled = false;

  //   @override
  //   void initState() {
  //     super.initState();
  //     _initializeFirebase();
  //   }

  //   Future<void> _initializeFirebase() async {
  //     await _firebaseHelper.initialize(
  //       onMessageReceived: (RemoteMessage message) {
  //         setState(() {
  //           _messages.insert(0, {
  //             'title': message.notification?.title ?? 'No Title',
  //             'body': message.notification?.body ?? 'No Body',
  //             'data': message.data,
  //             'time': DateTime.now(),
  //             'type': 'foreground',
  //           });
  //         });
  //       },
  //       onMessageOpenedApp: (RemoteMessage message) {
  //         setState(() {
  //           _messages.insert(0, {
  //             'title': message.notification?.title ?? 'No Title',
  //             'body': message.notification?.body ?? 'No Body',
  //             'data': message.data,
  //             'time': DateTime.now(),
  //             'type': 'opened',
  //           });
  //         });

  //         _showMessageDialog(message);
  //       },
  //       onTokenRefresh: (String token) {
  //         print('New token: $token');
  //         _showSnackBar('Token refreshed');
  //       },
  //     );

  //     final enabled = await _firebaseHelper.areNotificationsEnabled();
  //     setState(() {
  //       _isInitialized = true;
  //       _notificationsEnabled = enabled;
  //     });
  //   }

  //   void _showMessageDialog(RemoteMessage message) {
  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: Text(message.notification?.title ?? 'Notification'),
  //         content: Text(message.notification?.body ?? ''),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('OK'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }

  //   void _showSnackBar(String message) {
  //     ScaffoldMessenger.of(
  //       context,
  //     ).showSnackBar(SnackBar(content: Text(message)));
  //   }

  //   Future<void> _subscribeToTopic(String topic) async {
  //     try {
  //       await _firebaseHelper.subscribeToTopic(topic);
  //       _showSnackBar('Subscribed to $topic');
  //     } catch (e) {
  //       _showSnackBar('Error: $e');
  //     }
  //   }

  //   Future<void> _unsubscribeFromTopic(String topic) async {
  //     try {
  //       await _firebaseHelper.unsubscribeFromTopic(topic);
  //       _showSnackBar('Unsubscribed from $topic');
  //     } catch (e) {
  //       _showSnackBar('Error: $e');
  //     }
  //   }

  //   Future<void> _requestPermission() async {
  //     final granted = await _firebaseHelper.requestPermissionAgain();
  //     setState(() {
  //       _notificationsEnabled = granted;
  //     });
  //     _showSnackBar(granted ? 'Permission granted' : 'Permission denied');
  //   }

  //   @override
  //   Widget build(BuildContext context) {
  //     if (!_isInitialized) {
  //       return const Scaffold(body: Center(child: CircularProgressIndicator()));
  //     }

  //     return Scaffold(
  //       appBar: AppBar(title: const Text('FCM Helper Demo'), elevation: 2),
  //       body: Column(
  //         children: [
  //           // Status Card
  //           Card(
  //             margin: const EdgeInsets.all(16),
  //             child: Padding(
  //               padding: const EdgeInsets.all(16),
  //               child: Column(
  //                 crossAxisAlignment: CrossAxisAlignment.start,
  //                 children: [
  //                   Row(
  //                     children: [
  //                       Icon(
  //                         _notificationsEnabled
  //                             ? Icons.notifications_active
  //                             : Icons.notifications_off,
  //                         color: _notificationsEnabled
  //                             ? Colors.green
  //                             : Colors.red,
  //                       ),
  //                       const SizedBox(width: 8),
  //                       Text(
  //                         _notificationsEnabled
  //                             ? 'Notifications Enabled'
  //                             : 'Notifications Disabled',
  //                         style: const TextStyle(
  //                           fontSize: 16,
  //                           fontWeight: FontWeight.bold,
  //                         ),
  //                       ),
  //                     ],
  //                   ),
  //                   const SizedBox(height: 16),
  //                   const Text(
  //                     'FCM Token:',
  //                     style: TextStyle(fontWeight: FontWeight.bold),
  //                   ),
  //                   const SizedBox(height: 8),
  //                   Container(
  //                     padding: const EdgeInsets.all(12),
  //                     decoration: BoxDecoration(
  //                       color: Colors.grey[200],
  //                       borderRadius: BorderRadius.circular(8),
  //                     ),
  //                     child: SelectableText(
  //                       _firebaseHelper.fcmToken ?? 'No token',
  //                       style: const TextStyle(fontSize: 12),
  //                     ),
  //                   ),
  //                 ],
  //               ),
  //             ),
  //           ),

  //           // Action Buttons
  //           Padding(
  //             padding: const EdgeInsets.symmetric(horizontal: 16),
  //             child: Column(
  //               children: [
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: ElevatedButton.icon(
  //                         onPressed: () => _subscribeToTopic('news'),
  //                         icon: const Icon(Icons.add),
  //                         label: const Text('Subscribe News'),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 8),
  //                     Expanded(
  //                       child: ElevatedButton.icon(
  //                         onPressed: () => _unsubscribeFromTopic('news'),
  //                         icon: const Icon(Icons.remove),
  //                         label: const Text('Unsubscribe'),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 const SizedBox(height: 8),
  //                 Row(
  //                   children: [
  //                     Expanded(
  //                       child: ElevatedButton.icon(
  //                         onPressed: () => _subscribeToTopic('sports'),
  //                         icon: const Icon(Icons.add),
  //                         label: const Text('Subscribe Sports'),
  //                       ),
  //                     ),
  //                     const SizedBox(width: 8),
  //                     Expanded(
  //                       child: ElevatedButton.icon(
  //                         onPressed: () => _unsubscribeFromTopic('sports'),
  //                         icon: const Icon(Icons.remove),
  //                         label: const Text('Unsubscribe'),
  //                       ),
  //                     ),
  //                   ],
  //                 ),
  //                 if (!_notificationsEnabled) ...[
  //                   const SizedBox(height: 8),
  //                   SizedBox(
  //                     width: double.infinity,
  //                     child: ElevatedButton.icon(
  //                       onPressed: _requestPermission,
  //                       icon: const Icon(Icons.notifications_active),
  //                       label: const Text('Request Permission'),
  //                       style: ElevatedButton.styleFrom(
  //                         backgroundColor: Colors.orange,
  //                         foregroundColor: Colors.white,
  //                       ),
  //                     ),
  //                   ),
  //                 ],
  //               ],
  //             ),
  //           ),

  //           const SizedBox(height: 16),
  //           const Divider(),

  //           // Messages List
  //           Padding(
  //             padding: const EdgeInsets.all(16),
  //             child: Row(
  //               mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //               children: [
  //                 Text(
  //                   'Messages (${_messages.length})',
  //                   style: const TextStyle(
  //                     fontSize: 18,
  //                     fontWeight: FontWeight.bold,
  //                   ),
  //                 ),
  //                 if (_messages.isNotEmpty)
  //                   TextButton.icon(
  //                     onPressed: () => setState(() => _messages.clear()),
  //                     icon: const Icon(Icons.clear_all),
  //                     label: const Text('Clear'),
  //                   ),
  //               ],
  //             ),
  //           ),

  //           Expanded(
  //             child: _messages.isEmpty
  //                 ? const Center(
  //                     child: Column(
  //                       mainAxisAlignment: MainAxisAlignment.center,
  //                       children: [
  //                         Icon(Icons.inbox, size: 64, color: Colors.grey),
  //                         SizedBox(height: 16),
  //                         Text(
  //                           'No messages yet',
  //                           style: TextStyle(color: Colors.grey),
  //                         ),
  //                       ],
  //                     ),
  //                   )
  //                 : ListView.builder(
  //                     padding: const EdgeInsets.symmetric(horizontal: 16),
  //                     itemCount: _messages.length,
  //                     itemBuilder: (context, index) {
  //                       final msg = _messages[index];
  //                       return Card(
  //                         margin: const EdgeInsets.only(bottom: 8),
  //                         child: ListTile(
  //                           leading: CircleAvatar(
  //                             backgroundColor: msg['type'] == 'opened'
  //                                 ? Colors.blue
  //                                 : Colors.green,
  //                             child: Icon(
  //                               msg['type'] == 'opened'
  //                                   ? Icons.open_in_new
  //                                   : Icons.notifications,
  //                               color: Colors.white,
  //                               size: 20,
  //                             ),
  //                           ),
  //                           title: Text(
  //                             msg['title'],
  //                             style: const TextStyle(fontWeight: FontWeight.bold),
  //                           ),
  //                           subtitle: Column(
  //                             crossAxisAlignment: CrossAxisAlignment.start,
  //                             children: [
  //                               Text(msg['body']),
  //                               const SizedBox(height: 4),
  //                               Text(
  //                                 _formatTime(msg['time']),
  //                                 style: TextStyle(
  //                                   fontSize: 12,
  //                                   color: Colors.grey[600],
  //                                 ),
  //                               ),
  //                             ],
  //                           ),
  //                           isThreeLine: true,
  //                         ),
  //                       );
  //                     },
  //                   ),
  //           ),
  //         ],
  //       ),
  //     );
  //   }

  //   String _formatTime(DateTime time) {
  //     final now = DateTime.now();
  //     final diff = now.difference(time);

  //     if (diff.inSeconds < 60) {
  //       return 'Just now';
  //     } else if (diff.inMinutes < 60) {
  //       return '${diff.inMinutes}m ago';
  //     } else if (diff.inHours < 24) {
  //       return '${diff.inHours}h ago';
  //     } else {
  //       return '${time.day}/${time.month} ${time.hour}:${time.minute}';
  //     }
  //   }
  // }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Notifications')),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${widget.remoteMessage.notification!.title}',
                textAlign: TextAlign.start,
              ),
              verticalSpace(15),
              Text(
                '${widget.remoteMessage.notification!.body}',
                textAlign: TextAlign.start,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
