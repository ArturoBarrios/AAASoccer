import 'package:flutter/material.dart';

/// Displays a snackbar based on a message and type.
extension SnackBarDialogue on ScaffoldMessengerState {
  /// Displays a snackbar based on a message and type.
  void show({
    final SnackBarType? type,
    final String? message,
    final String? buttonText,
    final SnackBarBehavior? behavior,
    final VoidCallback? onTap,
  }) {
    showSnackBar(
      SnackBar(
        behavior: behavior,
        margin: behavior != null ? const EdgeInsets.only(bottom: 70) : null,
        backgroundColor:
            type == SnackBarType.success ? Colors.green : Colors.red,
        content: Row(
          children: [
            Flexible(
              child: Text(
                message ?? '',
              ),
            ),
            if (onTap != null) const Spacer(),
            if (onTap != null)
              ElevatedButton(
                onPressed: onTap,
                child: Text(buttonText ?? ''),
              ),
          ],
        ),
      ),
    );
  }
}

///
enum SnackBarType {
  ///
  success,

  ///
  failure,
}
