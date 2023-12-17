import 'package:flutter/material.dart';
import 'package:soccermadeeasy/models/componentModels/filter_result_model.dart';
import 'package:soccermadeeasy/styles/colors.dart';

class CustomRangeSlider extends StatefulWidget {
  const CustomRangeSlider({
    Key? key,
    this.minValue = 0,
    this.maxValue = 500,
    this.currentMinValue = 0,
    this.currentMaxValue = 500,
    this.rangeCallback,
  }) : super(key: key);

  final double minValue;
  final double maxValue;
  final double currentMinValue;
  final double currentMaxValue;
  final void Function(FilterRangeResultModel?)? rangeCallback;

  @override
  State<CustomRangeSlider> createState() => _CustomRangeSliderState();
}

class _CustomRangeSliderState extends State<CustomRangeSlider> {
  late double? _currentMinValue;
  late double? _currentMaxValue;
  bool isChanged = true;
  bool isMaxAmount = true;

  @override
  void initState() {
    super.initState();
    setState(() {
      _currentMinValue = widget.currentMinValue;
      _currentMaxValue = widget.currentMaxValue;
      isChanged = _currentMaxValue == widget.maxValue &&
          _currentMinValue == widget.minValue;
      isMaxAmount = _currentMaxValue == widget.maxValue;
    });
  }

  @override
  Widget build(BuildContext context) => Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RangeSlider(
            values: RangeValues(_currentMinValue ?? 0, _currentMaxValue ?? 500),
            min: widget.minValue,
            max: widget.maxValue,
            activeColor: AppColors.orangeColorShade500,
            onChanged: (RangeValues values) {
              setState(() {
                _currentMinValue = values.start;
                _currentMaxValue = values.end;
                isChanged = _currentMaxValue == widget.maxValue &&
                    _currentMinValue == widget.minValue;
                isMaxAmount = _currentMaxValue == widget.maxValue;
              });
              widget.rangeCallback?.call(FilterRangeResultModel(
                  minResult: values.start, maxResult: values.end));
            },
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('\$${_currentMinValue?.toStringAsFixed(2)}'),
              if (!isMaxAmount)
                Text('\$${_currentMaxValue?.toStringAsFixed(2)}'),
              if (isMaxAmount) const Text('Max Amount'),
            ],
          ),
        ],
      );
}
