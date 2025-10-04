import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/core/di/dependancy_injection.dart';
import 'package:flutter_advance_bloc_course/core/helpers/constants.dart';
import 'package:flutter_advance_bloc_course/core/helpers/extensions.dart';
import 'package:flutter_advance_bloc_course/core/helpers/shared_pref_helper.dart';
import 'package:flutter_advance_bloc_course/core/helpers/shared_pref_keys.dart';
import 'package:flutter_advance_bloc_course/doc_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await checkIfUserLoggedIn();
  setupGetIt();
  // To fix texts being hidden bug in flutter_screenutil in relase mode
  await ScreenUtil.ensureScreenSize();
  runApp(DocApp(appRouter: AppRouter()));
}

checkIfUserLoggedIn() async {
  String? token = await SharedPrefHelper.getSecuredString(
    SharedPrefKeys.userToken,
  );
  Constants.isShowedOnBoarding =
      await SharedPrefHelper.getBool(SharedPrefKeys.showedOnBoardingScreen) ??
      false;
  if (!token.isNullOrEmpty()) {
    Constants.isLoggedInUser = true;
  } else {
    Constants.isLoggedInUser = false;
  }
}

/*
 To upload apk from the app to Firebase App Distribution, run the following command in the terminal:
  cd android
  fastalane firebase_distribution

  do not forget to update the version in pubspec.yaml before running the command
*/
/**- --no-tree-shake-icons **/
