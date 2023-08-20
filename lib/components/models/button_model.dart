import 'package:flutter/material.dart';

class ButtonModel {
  const ButtonModel({
    this.text,
    this.textStyle,
    this.backgroundColor,
    this.onTap,
  });

  final String? text;
  final TextStyle? textStyle;
  final VoidCallback? onTap;
  final Color? backgroundColor;
}
