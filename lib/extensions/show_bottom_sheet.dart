import 'package:flutter/material.dart';

import '../components/filter_bottom_sheet.dart';
import '../components/models/button_model.dart';
import '../models/componentModels/filter_result_model.dart';

///
extension CustomBottomSheet on BuildContext {
  ///
  Future<T?> showFilterBottomSheet<T>(
          {final String? title,
          final ButtonModel? confirmButton,
          final ButtonModel? cancelButton,
          final ButtonModel? clearButton,
          final FilterResultModel? filterResult}) =>
      showModalBottomSheet(
        context: this,
        isScrollControlled: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(32),
          ),
        ),
        builder: (final context) => Padding(
          padding: MediaQuery.of(context).viewInsets,
          child: FilterBottomSheet(
            filterResult: filterResult,
            cancelButton: cancelButton,
            clearButton: clearButton,
            confirmButton: confirmButton,
          ),
        ),
      );
}
