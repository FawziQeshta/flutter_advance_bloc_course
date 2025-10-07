import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_advance_bloc_course/core/helpers/extensions.dart';
import 'package:flutter_advance_bloc_course/core/networking/api_error_model.dart';
import 'package:flutter_advance_bloc_course/core/routing/routes.dart';
import 'package:flutter_advance_bloc_course/core/theming/app_colors.dart';
import 'package:flutter_advance_bloc_course/features/login/logic/cubit/login_cubit.dart';
import 'package:flutter_advance_bloc_course/features/login/logic/cubit/login_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theming/styles.dart';

class LoginBlocListener extends StatelessWidget {
  const LoginBlocListener({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginCubit, LoginState>(
      listenWhen: (previous, current) =>
          current is LoginLoading ||
          current is LoginSuccess ||
          current is LoginError,
      listener: (context, state) {
        state.whenOrNull(
          loginLoading: () {
            showDialog(
              context: context,
              builder: (context) => const Center(
                child: CircularProgressIndicator(color: AppColors.mainBlue),
              ),
            );
          },
          loginSuccess: (loginResponse) {
            context.pop();
            context.pushNamedAndRemoveUntil(
              Routes.homeScreen,
              predicate: (Route<dynamic> route) => false,
            );
          },
          loginError: (error) {
            setupErrorState(context, error);
          },
        );
      },
      child: const SizedBox.shrink(),
    );
  }

  void setupErrorState(BuildContext context, ApiErrorModel error) {
    context.pop();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        icon: const Icon(Icons.error, color: Colors.red, size: 32),
        content: Text(
          error.getAllErrorMessages(),
          style: TextStyles.font15DarkBlueMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              context.pop();
            },
            child: Text('Got it', style: TextStyles.font14BlueSemiBold),
          ),
        ],
      ),
    );
  }
}
