import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/core/routing/routes.dart';
import 'package:flutter_advance_bloc_course/features/home/ui/widgets/home_top_bar.dart';
import 'package:flutter_advance_bloc_course/main_production.dart';

import '../../../core/helpers/firebase_helper.dart';
import '../../../core/helpers/spacing.dart';
import 'widgets/doctors_blue_container.dart';
import 'widgets/doctors_list/doctros_bloc_builder.dart';
import 'widgets/doctors_speciality_see_all.dart';
import 'widgets/specializations_list/specializations_bloc_builder.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final FirebaseHelper _firebaseHelper = FirebaseHelper();

  @override
  void initState() {
    super.initState();
    _initializeFirebase();
  }

  Future<void> _initializeFirebase() async {
    await _firebaseHelper.initialize(
      onMessageReceived: (RemoteMessage message) {
        print('onMessageReceived: ${message.notification!.title}');
        // setState(() {
        //   _messages.insert(0, {
        //     'title': message.notification?.title ?? 'No Title',
        //     'body': message.notification?.body ?? 'No Body',
        //     'data': message.data,
        //     'time': DateTime.now(),
        //     'type': 'foreground',
        //   });
        // });
      },
      onMessageOpenedApp: (RemoteMessage message) {
        print('onMessageOpenedApp: ${message.notification!.title}');
        navigatorKey.currentState!.pushNamed(
          Routes.notificationsScreen,
          arguments: message,
        );
        // setState(() {
        //   _messages.insert(0, {
        //     'title': message.notification?.title ?? 'No Title',
        //     'body': message.notification?.body ?? 'No Body',
        //     'data': message.data,
        //     'time': DateTime.now(),
        //     'type': 'opened',
        //   });
        // });

        // _showMessageDialog(message);
      },
      onTokenRefresh: (String token) {
        print('New token: $token');
        // _showSnackBar('Token refreshed');
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Container(
          width: double.infinity,
          margin: EdgeInsets.fromLTRB(20, 16, 20, 28),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              HomeTopBar(),
              DoctorsBlueContainer(),
              verticalSpace(24),
              const DoctorsSpecialitySeeAll(),
              verticalSpace(18),
              const SpecializationsBlocBuilder(),
              verticalSpace(8),
              const DoctorsBlocBuilder(),
            ],
          ),
        ),
      ),
    );
  }
}
