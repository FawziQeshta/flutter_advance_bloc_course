import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_advance_bloc_course/core/routing/routes.dart';
import 'package:flutter_advance_bloc_course/firebase_options.dart';

class Constants {
  static bool isLoggedInUser = false;
  static bool isShowedOnBoarding = false;
}

setupFirebase() async {
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  // await FirebaseNotifications.initNotifications();
}
