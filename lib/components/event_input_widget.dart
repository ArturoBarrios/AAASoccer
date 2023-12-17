import 'package:flutter/material.dart';

class EventInputWidget extends StatefulWidget {
  final Function(String, String) onUserEventDetailsChange;

  EventInputWidget({required this.onUserEventDetailsChange, Key? key}) : super(key: key);

  @override
  _EventInputWidgetState createState() => _EventInputWidgetState();
}

class _EventInputWidgetState extends State<EventInputWidget> {
  late final TextEditingController nameController;
  late final TextEditingController priceController;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController();
    priceController = TextEditingController();

    nameController.addListener(_onTextChanged);
    priceController.addListener(_onTextChanged);
  }

  @override
  void dispose() {
    nameController.dispose();
    priceController.dispose();
    super.dispose();
  }

  void _onTextChanged() {
    widget.onUserEventDetailsChange(
      nameController.text,
      priceController.text
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          controller: nameController,
          decoration: InputDecoration(
            labelText: "Name",
          ),
        ),
        TextField(
          controller: priceController,
          decoration: InputDecoration(
            labelText: "Price",
          ),
          keyboardType: TextInputType.number,
        ),
      ],
    );
  }
}
