import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../../styles/colors.dart';

class BasicElevatedButton extends StatefulWidget {
  final double? height;
  final double? width;
  final Svg? icon;
  final Color? backgroundColor;


  const BasicElevatedButton({Key? key, this.height, this.width, this.backgroundColor, this.icon }) : super(key: key);

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
            visible = !visible;
          });
          print("test");
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.star, color: Colors.white, size: iconSize),  // your icon here
            SizedBox(width: 8),  // a little spacing between the icon and text
            Text(
              'Enabled',
              style: TextStyle(fontSize: fontSize),
            ),
          ],
        ),
      ),
    );
  }
}
