import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../../styles/colors.dart';

class BasicElevatedButton extends StatefulWidget {
  final double? height;
  final double? width;
  final Svg? customIcon;
  final IconData? icon; 
  final String? text;
  final Color? backgroundColor;
  final Color? iconColor;
  final Function? onPressed;


  const BasicElevatedButton({Key? key, this.height, this.width, this.backgroundColor, this.customIcon, this.icon, this.iconColor, this.text, this.onPressed }) : super(key: key);

  @override
  State<BasicElevatedButton> createState() => _BasicElevatedButton();
}

class _BasicElevatedButton extends State<BasicElevatedButton> {
  bool visible = false;


  @override
  Widget build(BuildContext context) {
    // Calculating sizes based on given height and width
    double iconSize = widget.height!=null ?
       widget.height! * 0.5 : 20;
    double fontSize = widget.width!=null ? 
      widget.width! * 0.1 : 20;

    final ButtonStyle buttonStyle = ElevatedButton.styleFrom(
      primary: widget.backgroundColor==null ? 
        AppColors.tsnGreen : widget.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    );

    return Container(
  height: widget.height,
  width: widget.width,
  child: ElevatedButton(
    style: buttonStyle,
    onPressed: () {
      setState(() {
        widget.onPressed!();
      });
      print("test");
    },
    child: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment:
          widget.icon == null && widget.text != null // replace widget.text with your actual text variable
              ? MainAxisAlignment.center
              : (widget.icon != null || widget.customIcon != null) && widget.text == null // replace widget.text with your actual text variable
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
      children: [
        if (widget.icon != null || widget.customIcon != null) // replace widget.icon with your actual icon variable
          widget.icon != null ? 
          Icon(
            widget.icon,
            color: widget.iconColor,
            size: iconSize,
          ) : 
          Image(            
              width: iconSize,
              height: iconSize,
              image: widget.customIcon!,
              color: widget.iconColor
            ),
        if ((widget.icon != null || widget.customIcon != null) && widget.text != null) // replace widget.text with your actual text variable
          SizedBox(width: 8), // Add spacing only if icon and text exist
        if (widget.text != null) // replace widget.text with your actual text variable
          Expanded(
            child: Text(
              widget.text!, // replace 'Enabled' with your actual text variable
              textAlign: (widget.icon == null && widget.customIcon == null) ? TextAlign.center : TextAlign.left,
              style: TextStyle(fontSize: fontSize),
            ),
          ),
      ],
    ),
  ),
);


  }
}
