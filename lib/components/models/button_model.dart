import 'package:flutter/material.dart';

class ButtonModel {
  const ButtonModel({
    this.text,
    this.textStyle,
    this.backgroundColor,
    this.onTap,
    this.onTapReturnWithValue,
    this.prefixIconData,
    this.suffixIconData,
  });

  final String? text;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final void Function(dynamic)? onTapReturnWithValue;

  final Color? backgroundColor;
  final IconData? prefixIconData;
  final IconData? suffixIconData;
}
