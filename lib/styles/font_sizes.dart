import 'package:flutter/widgets.dart';

class FontSizes {
  static double xxxs(BuildContext context) => MediaQuery.of(context).size.width * 0.02;
  static double xxs(BuildContext context) => MediaQuery.of(context).size.width * 0.025;
  static double xs(BuildContext context) => MediaQuery.of(context).size.width * 0.03;
  static double s(BuildContext context) => MediaQuery.of(context).size.width * 0.035;
  static double m(BuildContext context) => MediaQuery.of(context).size.width * 0.04;
  static double lg(BuildContext context) => MediaQuery.of(context).size.width * 0.05;
  static double xl(BuildContext context) => MediaQuery.of(context).size.width * 0.06;
  static double xxl(BuildContext context) => MediaQuery.of(context).size.width * 0.07;
}
