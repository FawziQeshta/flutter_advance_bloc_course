import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/core/networking/api_result.dart';
import 'package:flutter_advance_bloc_course/features/sign_up/data/models/sign_up_request_body.dart';
import 'package:flutter_advance_bloc_course/features/sign_up/data/repos/sign_up_repo.dart';
import 'package:flutter_advance_bloc_course/features/sign_up/logic/cubit/sign_up_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpCubit extends Cubit<SignUpState> {
  final SignUpRepo _signUpRepo;
  SignUpCubit(this._signUpRepo) : super(const SignUpState.initial());

  TextEditingController nameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  void emitSignupStates() async {
    emit(const SignUpState.signupLoading());

    final s = SignUpRequestBody(
        name: nameController.text,
        email: emailController.text,
        phone: phoneController.text,
        password: passwordController.text,
        passwordConfirmation: confirmPasswordController.text,
        gender: "0"
    );

    final response = await _signUpRepo.signUp(s);

    response.when(
      success: (signupResponse) {
        emit(SignUpState.signupSuccess(signupResponse));
      },
      failure: (error) {
        emit(SignUpState.signupError(error: error.apiErrorModel.message));
      },
    );
  }
}
