import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../commands/event_command.dart';
import '../../components/payment_screen.dart';

class EventCreate extends StatefulWidget {
  @override
  _EventCreateState createState() => _EventCreateState();
}

class _EventCreateState extends State<EventCreate> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  bool _isLoading = false;

  Future<Map<String, dynamic>> createEvent() async {
    print("createEvent");
    Map<String, dynamic> createPickupGameResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> createEventInput = {
        "name": nameController.text.trim(),
        "secondaryName": secondaryNameController.text.trim(),
        "address": addressController.text.trim(),
        "surface": surfaceController.text.trim(),
        "images": imageController.text.trim(),
        "fieldSize": fieldSizeController.text.trim(),
        "private": privateController.text.trim()
      };
      Map<String, dynamic> createEventRes =
          await EventCommand().createEvent(createEventInput);
      if (createEventRes['success']) {
        createPickupGameResponse['success'] = true;
        createPickupGameResponse['data'] = createEventRes['data'];
      }
      return createPickupGameResponse;
    } on ApiException catch (e) {
      return createPickupGameResponse;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Name'),
        ),
        TextField(
          controller: imageController,
          decoration: new InputDecoration.collapsed(hintText: 'Image'),
        ),
        TextField(
          controller: secondaryNameController,
          decoration: new InputDecoration.collapsed(hintText: 'Secondary Name'),
        ),
        TextField(
          controller: addressController,
          decoration: new InputDecoration.collapsed(hintText: 'Address'),
        ),
        TextField(
          controller: surfaceController,
          decoration: new InputDecoration.collapsed(hintText: 'Surface'),
        ),
        TextField(
          controller: fieldSizeController,
          decoration: new InputDecoration.collapsed(hintText: 'Field Size'),
        ),
        TextField(
          controller: privateController,
          decoration: new InputDecoration.collapsed(hintText: 'Private'),
        ),
        GestureDetector(
            onTap: () {
              createEvent();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
