import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SVGWidgets {
  Svg getSoccerBallSVGImagePath() {
    //  const Image(image: AssetImage('lib/assets/icons/soccer_ball.svg'));
    // return "lib/assets/icons/soccer_ball.svg";
    Svg svgImage = Svg('lib/assets/icons/soccer_ball.svg');

    return svgImage;
  }
}