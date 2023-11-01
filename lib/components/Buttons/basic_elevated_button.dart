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
  final double? fontSize;
  


  const BasicElevatedButton({Key? key, this.height, this.width, this.backgroundColor, this.customIcon, this.icon, this.iconColor, this.text, this.onPressed, this.fontSize }) : super(key: key);

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
    // double fontSize = widget.width!=null ? 
    //   widget.width! * 0.1 : 20;

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
      mainAxisAlignment: MainAxisAlignment.start,  // Aligned to the start
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (widget.icon != null || widget.customIcon != null)
          Container(
            decoration: BoxDecoration(
              // border: Border.all(color: Colors.red),
            ),
            child: widget.icon != null
                ? Icon(
                    widget.icon,
                    color: widget.iconColor,
                    size: iconSize,
                  )
                : Image(
                    width: iconSize,
                    height: iconSize,
                    image: widget.customIcon!,
                    color: widget.iconColor,
                  ),
          ),
        if ((widget.icon != null || widget.customIcon != null) && widget.text != null)
          SizedBox(width: 8),
        if (widget.text != null)
          Expanded(
            flex: 16,
            child: Container(
              decoration: BoxDecoration(
                // border: Border.all(color: Colors.red),
              ),
              child: Text(
                widget.text!,
                textAlign: (widget.icon == null && widget.customIcon == null)
                    ? TextAlign.center
                    : TextAlign.start,  // Changed to start
                style: TextStyle(fontSize: widget.fontSize),
              ),
            ),
          ),
      ],
    ),
  ),
);





  }
}
