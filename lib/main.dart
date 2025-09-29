import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/core/di/dependancy_injection.dart';
import 'package:flutter_advance_bloc_course/doc_app.dart';

import 'core/routing/app_router.dart';

void main() {
  setupGetIt();
  runApp(DocApp(appRouter: AppRouter(),));
}


