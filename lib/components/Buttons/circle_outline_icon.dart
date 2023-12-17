import 'package:flutter/material.dart';

class CircleOutlineIcon extends StatelessWidget {
  final Widget icon;
  final Color backgroundColor;
  final Color borderColor;
  final double circleSize;
  final double borderThickness;

  CircleOutlineIcon({
    required this.icon,
    required this.backgroundColor,
    required this.borderColor,
    this.circleSize = 50.0, // Default size
    this.borderThickness = 2.0, // Default border thickness
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: circleSize,
      height: circleSize,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: backgroundColor,
        border: Border.all(
          color: borderColor,
          width: borderThickness,
        ),
      ),
      child: Center(
        child: icon,
      ),
    );
  }
}
