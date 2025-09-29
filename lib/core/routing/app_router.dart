import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/core/di/dependancy_injection.dart';
import 'package:flutter_advance_bloc_course/core/routing/routes.dart';
import 'package:flutter_advance_bloc_course/features/home/ui/home_screen.dart';
import 'package:flutter_advance_bloc_course/features/login/logic/cubit/login_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../features/login/ui/login_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/sign_up/sign_up_screen.dart';

class AppRouter {
  Route generateRoute(RouteSettings settings) {
    // this arrguments to be passed in any screen like this {arrguments as ClassName}
    final arrguments = settings.arguments;

    switch (settings.name) {
      case Routes.onBoardingScreen:
        return MaterialPageRoute(builder: (_) => OnboardingScreen());
      case Routes.loginScreen:
        return MaterialPageRoute(
          builder: (_) => BlocProvider(
            create: (context) => getIt<LoginCubit>(),
            child: LoginScreen(),
          ),
        );
      case Routes.signUpScreen:
        return MaterialPageRoute(builder: (_) => SignUpScreen());
      case Routes.homeScreen:
        return MaterialPageRoute(builder: (_) => HomeScreen());
      default:
        return MaterialPageRoute(
          builder: (_) => Scaffold(
            body: Center(child: Text('No route defined for ${settings.name}')),
          ),
        );
    }
  }
}
