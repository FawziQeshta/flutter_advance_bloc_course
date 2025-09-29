import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/core/helpers/spacing.dart';
import 'package:flutter_advance_bloc_course/core/theming/app_colors.dart';
import 'package:flutter_advance_bloc_course/core/theming/styles.dart';

class PasswordValidations extends StatelessWidget {
  final bool hasUppercase;
  final bool hasNumbers;
  final bool hasLowercase;
  final bool hasSpecialCharacters;
  final bool hasMinLength;
  const PasswordValidations({
    super.key,
    required this.hasUppercase,
    required this.hasNumbers,
    required this.hasLowercase,
    required this.hasSpecialCharacters,
    required this.hasMinLength,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildValidationRow('At least 1 uppercase letter', hasUppercase),
        verticalSpace(2),
        buildValidationRow('At least 1 lowercase letter', hasLowercase),
        verticalSpace(2),
        buildValidationRow('At least 1 number', hasNumbers),
        verticalSpace(2),
        buildValidationRow(
          'At least 1 special character',
          hasSpecialCharacters,
        ),
        verticalSpace(2),
        buildValidationRow('Minimum 8 characters', hasMinLength),
      ],
    );
  }

  Widget buildValidationRow(String text, bool hasValidated) {
    return Row(
      children: [
        CircleAvatar(radius: 2.5, backgroundColor: AppColors.gray),
        horizontalSpace(6),
        Text(
          text,
          style: TextStyles.font13BlueRegular.copyWith(
            decoration: hasValidated ? TextDecoration.lineThrough : null,
            decorationColor: Colors.green,
            decorationThickness: 2,
            color: hasValidated ? AppColors.gray : AppColors.darkBlue,
          ),
        ),
      ],
    );
  }
}
