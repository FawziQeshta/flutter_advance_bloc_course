import 'package:flutter_advance_bloc_course/core/networking/api_error_model.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'sign_up_state.freezed.dart';

@freezed
class SignUpState<T> with _$SignUpState<T> {
  const factory SignUpState.initial() = _Initial;
  const factory SignUpState.signupLoading() = SignupLoading;
  const factory SignUpState.signupSuccess(T data) = SignupSuccess<T>;
  const factory SignUpState.signupError(ApiErrorModel apiErrorModel) =
      SignupError;
}
