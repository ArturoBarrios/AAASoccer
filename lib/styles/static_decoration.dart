import 'package:flutter/material.dart';

// Padding
const EdgeInsets horizonatal20 = EdgeInsets.symmetric(horizontal: 20);
EdgeInsets customVerticalHorizontal20({double vertical = 0}) =>
    EdgeInsets.symmetric(horizontal: 20, vertical: vertical);

// Sizedbox
SizedBox customWidth(double width) => SizedBox(width: width);

SizedBox customHeight(double height) => SizedBox(height: height);

BorderRadius circularBorderRadius(double radius) =>
    BorderRadius.circular(radius);
