import 'package:flutter/material.dart';
import 'package:flutter_advance_bloc_course/core/theming/app_colors.dart';
import 'package:flutter_advance_bloc_course/core/theming/styles.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTextFormField extends StatelessWidget {
  final EdgeInsetsGeometry? contentPadding;
  final InputBorder? focusedBorder;
  final InputBorder? enabledBorder;
  final InputBorder? errorBorder;
  final TextStyle? inputTextStyle;
  final TextStyle? hintStyle;
  final String? hintText;
  final Widget? suffixIcon;
  final bool isObscureText;
  final bool isDoneAction;
  final Color? backgroundColor;
  final TextInputType? textInputType;
  final TextEditingController? controller;
  final String? Function(String?) validator;

  const AppTextFormField({
    super.key,
    this.contentPadding,
    this.focusedBorder,
    this.enabledBorder,
    this.errorBorder,
    this.inputTextStyle,
    this.hintStyle,
    required this.hintText,
    this.suffixIcon,
    this.isObscureText = false,
    this.isDoneAction = false,
    this.backgroundColor,
    this.textInputType,
    this.controller,
    required this.validator,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      validator: (value) {
        return validator(value);
      },
      decoration: InputDecoration(
        isDense: true,
        contentPadding:
            contentPadding ??
            EdgeInsets.symmetric(vertical: 18.w, horizontal: 20.w),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),

        focusedBorder:
            focusedBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: AppColors.mainBlue,
                width: 1.3,
              ),
            ),
        enabledBorder:
            enabledBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(
                color: AppColors.lighterGray,
                width: 1.3,
              ),
            ),
        errorBorder:
            errorBorder ??
            OutlineInputBorder(
              borderRadius: BorderRadius.circular(16.0),
              borderSide: const BorderSide(color: Colors.red, width: 1.3),
            ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(16.0),
          borderSide: const BorderSide(color: Colors.red, width: 1.3),
        ),
        hintStyle: hintStyle ?? TextStyles.font14LightGrayRegular,
        hintText: hintText,
        suffixIcon: suffixIcon,
        fillColor: backgroundColor ?? AppColors.moreLightGray,
        filled: true,
      ),
      obscureText: isObscureText,
      style: inputTextStyle ?? TextStyles.font14DarkBlueMedium,
      textInputAction: !isDoneAction
          ? TextInputAction.next
          : TextInputAction.done,
      keyboardType: textInputType ?? TextInputType.text,
    );
  }
}
