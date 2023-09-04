import 'package:flutter/material.dart';
import 'package:soccermadeeasy/styles/colors.dart';

class PlayerRateSlider extends StatelessWidget {
  const PlayerRateSlider({
    Key? key,
    this.currentMaxValue = 50,
    this.rangeCallback,
  }) : super(key: key);

  final double currentMaxValue;
  final void Function(double)? rangeCallback;

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RangeSlider(
              values: RangeValues(0, currentMaxValue),
              min: 0,
              max: 100,
              activeColor: AppColors.orangeColorShade500,
              onChanged: (RangeValues values) =>
                  rangeCallback?.call(values.end)),
        ],
      );
}
