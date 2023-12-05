import 'package:flutter/material.dart';

class SidewaysPillWidget extends StatelessWidget {
  final String text;
  final IconData? icon;
  final Color? color;

  SidewaysPillWidget({required this.text, this.icon, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      decoration: BoxDecoration(
        color: color, // Change the background color as needed
        borderRadius: BorderRadius.circular(50), // Pill-shaped border
      ),
      child: Row(
        mainAxisAlignment: icon == null
            ? MainAxisAlignment.center
            : MainAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null)
            Icon(
              icon,
              color: Colors.white, // Change the icon color as needed
            ),
          if (icon != null) SizedBox(width: 8),
          Text(
            text,
            style: TextStyle(
              color: Colors.white, // Change the text color as needed
            ),
          ),
        ],
      ),
    );
  }
}
