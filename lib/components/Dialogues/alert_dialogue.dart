import 'package:flutter/material.dart';

class AlertDialogueWidget extends StatelessWidget {
  final String title;
  final String body;
  final VoidCallback onConfirmCallback;
  final VoidCallback onCancelCallback;

  const AlertDialogueWidget({
    Key? key,
    required this.title,
    required this.body,
    required this.onConfirmCallback,
    required this.onCancelCallback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(title),
      content: Text(body),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            onCancelCallback(); // Execute onCancelCallback
          },
        ),
        TextButton(
          child: Text('Confirm'),
          onPressed: () {
            Navigator.of(context).pop(); // Close the dialog
            onConfirmCallback(); // Execute onConfirmCallback
          },
        ),
      ],
    );
  }
}
