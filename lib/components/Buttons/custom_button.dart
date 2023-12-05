import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final IconData iconData;
  final String buttonText;
  final double fontSize;

  CustomButton({required this.iconData, required this.buttonText, required this.fontSize});

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // Your button press action here
      },
      child: Row(
        mainAxisSize: MainAxisSize.min, // Shrink the row to the size of the largest child
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(iconData),
          SizedBox(width: 8),  // Add a little spacing between the icon and the text
          Text(
            buttonText,
            textAlign: TextAlign.end,
            style: TextStyle(fontSize: fontSize),
          ),
        ],
      ),
    );
  }
}
