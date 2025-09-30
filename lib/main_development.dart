import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/core/di/dependancy_injection.dart';
import 'package:flutter_advance_bloc_course/doc_app.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'core/routing/app_router.dart';

void main() async {
  setupGetIt();
  // To fix texts being hidden bug in flutter_screenutil in relase mode
  await ScreenUtil.ensureScreenSize();
  runApp(DocApp(appRouter: AppRouter()));
}
