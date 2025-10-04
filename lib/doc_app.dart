import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/core/helpers/constants.dart';
import 'package:flutter_advance_bloc_course/core/helpers/shared_pref_helper.dart';
import 'package:flutter_advance_bloc_course/core/routing/app_router.dart';
import 'package:flutter_advance_bloc_course/core/routing/routes.dart';
import 'package:flutter_advance_bloc_course/core/theming/app_colors.dart';
import 'package:flutter_advance_bloc_course/main_development.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class DocApp extends StatelessWidget {
  final AppRouter appRouter;
  const DocApp({super.key, required this.appRouter});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Doc App',
        // You can use the library anywhere in the app even in theme
        theme: ThemeData(
          primaryColor: AppColors.mainBlue,
          scaffoldBackgroundColor: Colors.white,
        ),
        initialRoute: getInitialRoute(),
        onGenerateRoute: appRouter.generateRoute,
      ),
    );
  }

  String getInitialRoute() {
    if (Constants.isShowedOnBoarding) {
      if (Constants.isLoggedInUser) {
        return Routes.homeScreen;
      } else {
        return Routes.loginScreen;
      }
    }
    return Routes.onBoardingScreen;
  }
}
