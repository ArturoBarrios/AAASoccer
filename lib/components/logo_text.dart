import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/svg_widgets.dart';

import '../styles/colors.dart';

class LogoTextWidget extends StatelessWidget {
  final double width;
  final double height;
  final Color backgroundColor;

  LogoTextWidget({
    Key? key,
    required this.width,
    required this.height,
    required this.backgroundColor,    
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Svg logo = SVGWidgets().logo();
    return Container(
      color: backgroundColor,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image(
            width: height, // Using height to keep the image square
            height: height,
            image: logo,
            // color: AppColors.tra,
          ),
          SizedBox(width: 16), // Optional: for spacing between image and text
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("The", style: TextStyle(fontSize: 12)),
              Text("Soccer", style: TextStyle(fontSize: 12)),
              Text("Network", style: TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }
}
