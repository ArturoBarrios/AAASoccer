import 'package:flutter/material.dart';
import 'package:soccermadeeasy/styles/colors.dart';

import '../models/componentModels/filter_result_model.dart';
import 'custom_range_slider.dart';
import 'models/button_model.dart';

class FilterBottomSheet extends StatefulWidget {
  const FilterBottomSheet({
    Key? key,
    this.title,
    this.confirmButton,
    this.cancelButton,
    this.clearButton,
    this.filterResult,
  }) : super(key: key);

  /// Title text.
  final String? title;

  /// Confirm button.
  final ButtonModel? confirmButton;

  /// Cancel button.
  final ButtonModel? cancelButton;

  /// Clear button.
  final ButtonModel? clearButton;

  /// Filter result model.
  final FilterResultModel? filterResult;

  @override
  State<FilterBottomSheet> createState() => _FilterBottomSheetState();
}

class _FilterBottomSheetState extends State<FilterBottomSheet> {
  FilterResultModel filterResultModel = FilterResultModel();

  @override
  Widget build(final BuildContext context) => Container(
        decoration: const BoxDecoration(
          color: AppColors.backgroundColor,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(32),
            topRight: Radius.circular(32),
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 24),
                Container(
                  height: 5,
                  width: 60,
                  decoration: const BoxDecoration(
                    color: AppColors.grayColor,
                    borderRadius: BorderRadius.all(Radius.circular(3)),
                  ),
                ),
                const SizedBox(height: 24),
                if (widget.title != null) Text(widget.title ?? ''),
                if (widget.title != null) const SizedBox(height: 12),
                CustomRangeSlider(
                  currentMaxValue:
                      widget.filterResult?.rangeResult?.maxResult ?? 500,
                  currentMinValue:
                      widget.filterResult?.rangeResult?.minResult ?? 0,
                  rangeCallback: (final value) {
                    setState(() {
                      filterResultModel.rangeResult = value;
                    });
                  },
                ),
                const SizedBox(height: 48),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: widget.cancelButton != null &&
                            widget.confirmButton != null
                        ? MainAxisAlignment.spaceBetween
                        : MainAxisAlignment.center,
                    children: [
                      if (widget.cancelButton != null)
                        ElevatedButton(
                          onPressed: widget.cancelButton?.onTap,
                          child: Text(widget.cancelButton?.text ?? ''),
                        ),
                      if (widget.clearButton != null)
                        ElevatedButton(
                          onPressed: () => widget.clearButton?.onTap?.call(),
                          child: Text(widget.clearButton?.text ?? ''),
                        ),
                      if (widget.confirmButton != null)
                        ElevatedButton(
                          onPressed: () => widget
                              .confirmButton?.onTapReturnWithValue
                              ?.call(filterResultModel),
                          child: Text(widget.confirmButton?.text ?? ''),
                        ),
                    ],
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      );
}
