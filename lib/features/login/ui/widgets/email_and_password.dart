import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/core/helpers/app_regex.dart';
import 'package:flutter_advance_bloc_course/features/login/logic/cubit/login_cubit.dart';
import 'package:flutter_advance_bloc_course/features/login/ui/widgets/password_validations.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/helpers/spacing.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../core/widgets/app_text_form_field.dart';

class EmailAndPassword extends StatefulWidget {
  const EmailAndPassword({super.key});

  @override
  State<EmailAndPassword> createState() => _EmailAndPasswordState();
}

class _EmailAndPasswordState extends State<EmailAndPassword> {
  bool isObscureText = true;
  late TextEditingController emailController;
  late TextEditingController passwordController;
  late LoginCubit loginCubit;

  bool hasUppercase = false;
  bool hasNumbers = false;
  bool hasLowercase = false;
  bool hasSpecialCharacters = false;
  bool hasMinLength = false;

  @override
  void initState() {
    super.initState();
    // to read any function or variable from cubit
    //  context.read<CubitName>().functionNameOrVar();
    loginCubit = context.read<LoginCubit>();
    emailController = loginCubit.emailController;
    passwordController = loginCubit.passwordController;
    setupPasswordControllerListener();
  }

  void setupPasswordControllerListener() {
    passwordController.addListener(() {
      setState(() {
        hasLowercase = AppRegex.hasLowerCase(passwordController.text);
        hasUppercase = AppRegex.hasUpperCase(passwordController.text);
        hasNumbers = AppRegex.hasNumber(passwordController.text);
        hasSpecialCharacters = AppRegex.hasSpecialCharacter(
          passwordController.text,
        );
        hasMinLength = AppRegex.hasMinLength(passwordController.text);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: context.read<LoginCubit>().formKey,
      child: Column(
        children: [
          AppTextFormField(
            controller: emailController,
            hintText: 'Email',
            textInputType: TextInputType.emailAddress,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Please enter your email';
              }
              if (!AppRegex.isEmailValid(text)) {
                return 'Please enter a valid email';
              }
            },
          ),
          verticalSpace(18),
          AppTextFormField(
            controller: passwordController,
            hintText: 'Password',
            isObscureText: isObscureText,
            textInputType: TextInputType.visiblePassword,
            validator: (text) {
              if (text == null || text.isEmpty) {
                return 'Please enter your password';
              }
              if (!hasLowercase ||
                  !hasUppercase ||
                  !hasNumbers ||
                  !hasSpecialCharacters ||
                  !hasMinLength) {
                return 'Please enter validate password';
              }
            },
            isDoneAction: true,
            suffixIcon: IconButton(
              onPressed: () {
                setState(() {
                  isObscureText = !isObscureText;
                });
              },
              icon: Icon(
                isObscureText ? Icons.visibility_off : Icons.visibility,
                color: AppColors.lightGray,
              ),
            ),
          ),
          verticalSpace(24),
          PasswordValidations(
            hasUppercase: hasUppercase,
            hasNumbers: hasNumbers,
            hasLowercase: hasLowercase,
            hasSpecialCharacters: hasSpecialCharacters,
            hasMinLength: hasMinLength,
          ),
          verticalSpace(24),
        ],
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }
}
