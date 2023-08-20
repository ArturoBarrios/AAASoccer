import 'package:flutter/material.dart';
import '../styles/colors.dart';

class CustomTextFormField extends StatelessWidget {
  final String? label;
  final String? hintText;
  final TextEditingController controller;
  final bool isSuffixIcon;
  final Widget? suffixIcon;
  final Function()? onPressed;
  final TextInputType? keyboardType;
  final bool enabled;
  final String? Function(String? value)? validator;

  const CustomTextFormField(
      {this.label,
      this.hintText,
      required this.controller,
      this.isSuffixIcon = false,
      this.suffixIcon,
      this.onPressed,
      Key? key,
      this.keyboardType,
      this.enabled = true,
      this.validator})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: TextFormField(
        controller: controller,
        enabled: enabled,
        onTap: onPressed,
        autovalidateMode: AutovalidateMode.onUserInteraction,
        cursorColor: AppColors.orangeColorShade500,
        keyboardType: keyboardType,
        validator: validator,
        decoration: InputDecoration(
          errorStyle: const TextStyle(
              color: AppColors.redColor,
              fontSize: 14,
              fontWeight: FontWeight.normal),
          enabled: true,
          labelText: label,
          hintText: hintText,
          hintStyle: const TextStyle(fontSize: 15, color: AppColors.grayColor),
          labelStyle: const TextStyle(fontSize: 15, color: AppColors.grayColor),
          suffixIcon: suffixIcon,
          fillColor: AppColors.whiteColor,
          filled: true,
          suffixIconColor: AppColors.orangeColorShade200,
          contentPadding: const EdgeInsets.all(12),
          errorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: AppColors.redColorShade200,
              width: 2,
            ),
          ),
          disabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: AppColors.grayColorShade400,
              width: 2,
            ),
          ),
          enabledBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: AppColors.grayColorShade400,
              width: 2,
            ),
          ),
          focusedBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: AppColors.orangeColorShade200,
              width: 2,
            ),
          ),
          focusedErrorBorder: const OutlineInputBorder(
            borderRadius: BorderRadius.all(
              Radius.circular(10.0),
            ),
            borderSide: BorderSide(
              color: AppColors.redColorShade200,
              width: 2,
            ),
          ),
        ),
      ),
    );
  }
}
