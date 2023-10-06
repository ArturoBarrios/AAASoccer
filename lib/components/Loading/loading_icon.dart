import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

import '../../styles/colors.dart';

class LoadingIcon extends StatefulWidget {
   double? width;
   double? height;
   Svg svgImage;

  LoadingIcon({
     this.width,
     this.height,
    required this.svgImage,
  });

  @override
  _LoadingIconState createState() => _LoadingIconState();
}

class _LoadingIconState extends State<LoadingIcon> {
  late double rotationAngle = 0.0;




  @override
  void initState() {
    super.initState();
    Timer.periodic(Duration(milliseconds: 50), (Timer t) {
      setState(() {
        rotationAngle += 0.1;
      });
    });
    
      widget.width ??=  10;
      widget.height ??= 10;    

  }

  @override
  Widget build(BuildContext context) {
    return Transform.rotate(
      angle: rotationAngle,
      child: Image(
        width: widget.width,
        height: widget.height,
        image: widget.svgImage,
        color: AppColors.tsnLightGreen,
      ),
    );
  }
}
