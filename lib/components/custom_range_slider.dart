import 'package:flutter/material.dart';
import 'package:soccermadeeasy/styles/colors.dart';

class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider({
    Key? key,
    this.minValue = 0,
    this.maxValue = 500,
    this.currentMaxValue = 500,
    this.rangeCallback,
  }) : super(key: key);

  final double minValue;
  final double maxValue;
  final double currentMaxValue;
  final void Function(double?)? rangeCallback;

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  late double? _currentMaxValue;
  bool isMaxAmount = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentMaxValue = widget.currentMaxValue;
      isMaxAmount = _currentMaxValue == widget.maxValue;
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RangeSlider(
            values: RangeValues(widget.minValue, _currentMaxValue ?? 500),
            min: widget.minValue,
            max: widget.maxValue,
            activeColor: AppColors.orangeColorShade500,
            onChanged: (RangeValues values) {
              setState(() {
                _currentMaxValue = values.end;
                isMaxAmount = _currentMaxValue == widget.maxValue;
              });
              widget.rangeCallback?.call(values.end);
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${widget.minValue.toStringAsFixed(2)}'),
              if (!isMaxAmount)
                Text('\$${_currentMaxValue?.toStringAsFixed(2)}'),
              if (isMaxAmount) const Text('Max Amount'),
            ],
          ),
        ],
      );
}
