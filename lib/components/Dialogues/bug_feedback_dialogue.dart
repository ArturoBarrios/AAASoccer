import 'package:flutter/material.dart';

class BugFeedbackWidget extends StatefulWidget {
  final VoidCallback onSubmitCallback;
  final VoidCallback onCancelCallback;

  const BugFeedbackWidget({
    Key? key,
    required this.onSubmitCallback,
    required this.onCancelCallback,
  }) : super(key: key);

  @override
  _BugFeedbackWidgetState createState() => _BugFeedbackWidgetState();
}

class _BugFeedbackWidgetState extends State<BugFeedbackWidget> {
  int selectedSeverity = 1;
  final TextEditingController descriptionController = TextEditingController();

  Widget severityButton(int number) {
    return GestureDetector(
      onTap: () => setState(() => selectedSeverity = number),
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.symmetric(horizontal: 4),
        decoration: BoxDecoration(
          color: selectedSeverity == number ? Colors.blue : Colors.grey[300],
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          '$number',
          style: TextStyle(color: selectedSeverity == number ? Colors.white : Colors.black),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Found a Bug?'),
      content: SingleChildScrollView(
        child: ListBody(
          children: <Widget>[
            Text('Description'),
            TextField(
              controller: descriptionController,
              decoration: InputDecoration(
                hintText: 'Enter a description of the bug',
                border: OutlineInputBorder(), // Adds a border around the TextField
              ),
              keyboardType: TextInputType.multiline,
              maxLines: null, // Allows for unlimited lines
              minLines: 5, // Sets a minimum height for the TextField
            ),
            SizedBox(height: 16),
            Text('Severity'),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: List.generate(5, (index) => severityButton(index + 1)),
            ),
            SizedBox(height: 16),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          child: Text('Cancel'),
          onPressed: widget.onCancelCallback,
        ),
        TextButton(
          child: Text('Submit'),
          onPressed: () {
            // Access the description using descriptionController.text
            widget.onSubmitCallback();
          },
        ),
      ],
    );
  }

  @override
  void dispose() {
    descriptionController.dispose();
    super.dispose();
  }
}
