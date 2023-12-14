import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/svg_widgets.dart';

import '../styles/colors.dart';
import '../styles/font_sizes.dart';

class LogoTextWidget extends StatefulWidget {
  
  LogoTextWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.backgroundColor,   
    this.hasAnimation = false,
    this.textColor,
    this.fontSize,
    
  }) : super(key: key);

  final double? width;
  final double? height;
  final Color backgroundColor;
  late bool hasAnimation;
  final Color? textColor;
  final double? fontSize;
  
  @override
  _LogoTextWidgetState createState() => _LogoTextWidgetState();
}
class _LogoTextWidgetState extends State<LogoTextWidget> with SingleTickerProviderStateMixin{
  
    late AnimationController _controller;
  late Animation<double> _animation;
  
   
 @override
  void initState() {
    super.initState();
    int animationSeconds = widget.hasAnimation ? 4 : 1000000;
    
    _controller = AnimationController(
      duration: Duration(seconds: animationSeconds),
      vsync: this,
    )..repeat();

    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
  }

  @override
  Widget build(BuildContext context) {
    Svg logo = SVGWidgets().logo();
    print("logooooo: "+ logo.toString());
    return Container(
      color: widget.backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RotationTransition(
          turns: _animation,
          child:
          Image(
            width: widget.height, // Using height to keep the image square
            height: widget.height,
            image: logo,
            color: AppColors.tsnLightGreen,
          )),
          SizedBox(width: 16), // Optional: for spacing between image and text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("The", style: TextStyle(fontSize: widget.fontSize, color: widget.textColor)),
              Text("Soccer", style: TextStyle(fontSize: widget.fontSize, color: widget.textColor)),
              Text("Network", style: TextStyle(fontSize: widget.fontSize, color: widget.textColor)),
            ],
          ),
        ],
      ),
    );
  }
}

