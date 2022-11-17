import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SVGWidgets {
  Svg getSoccerBallSVGImage() {
    Svg svgImage = Svg('lib/assets/icons/soccer_ball.svg');

    return svgImage;
  }
  Svg deleteSVGImage() {
    Svg svgImage = Svg('lib/assets/icons/delete.svg');

    return svgImage;
  }
  Svg friendsSVGImage() {
    Svg svgImage = Svg('lib/assets/icons/friends.svg');

    return svgImage;
  }
}