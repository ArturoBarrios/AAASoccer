import 'package:flutter/material.dart';
import 'package:soccermadeeasy/styles/colors.dart';

class AgreementFormWidget extends StatelessWidget {
  final String title;
  final String bodyText;
  final VoidCallback onAccept;
  final VoidCallback onReject;
  final bool viewMode;

  const AgreementFormWidget({
    Key? key,
    required this.title,
    required this.bodyText,
    required this.onAccept,
    required this.onReject,
    required this.viewMode,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.all(10), // Padding around the edges
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: double.infinity, // Makes sure the dialog takes up most of the width
          maxHeight: MediaQuery.of(context).size.height * 0.9, // 90% of screen height
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: EdgeInsets.all(16.0),
              child: Text(title, style: Theme.of(context).textTheme.headline6),
            ),
            Expanded(
              child: SingleChildScrollView(
                padding: EdgeInsets.all(16.0),
                child: Text(bodyText),
              ),
            ),
            if(!viewMode)
            ButtonBar(
              alignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                TextButton(
                  
                  onPressed: onReject,
                  child: const Text('Reject', style: TextStyle(color: AppColors.tsnRed)),
                ),
                ElevatedButton(
                  onPressed: onAccept,
                  child: const Text('Accept', style: TextStyle(color: AppColors.tsnGreen)),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
