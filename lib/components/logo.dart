import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/svg_widgets.dart';

class LogoWidget extends StatelessWidget {
  final double width;
  final double height;  
  final Color backgroundColor;

  LogoWidget({
    Key? key,
    required this.width,
    required this.height,    
    required this.backgroundColor,
  }) : super(key: key);
 

  @override
  Widget build(BuildContext context) {
    Svg logo = SVGWidgets().logo();
    return Container(
      width: width,
      height: height,
      color: backgroundColor,
      child: Image(
        width: width,
        height: height,
        image: logo,
      ),
    );
  }
}
