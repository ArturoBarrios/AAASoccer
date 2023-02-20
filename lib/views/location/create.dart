import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../commands/location_command.dart';

class LocationCreate extends StatefulWidget {
  @override
  _LocationCreateState createState() => _LocationCreateState();
}

class _LocationCreateState extends State<LocationCreate> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  bool _isLoading = false;

  Future<Map<String, dynamic>> createLocation() async {
    print("createLocation");
    Map<String, dynamic> createLocationResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      Map<String, dynamic> createLocationInput = {
        "name": nameController.text.trim(),
        "secondaryName": secondaryNameController.text.trim(),
        "address": addressController.text.trim(),
        "surface": surfaceController.text.trim(),
        "images": imageController.text.trim(),
        "fieldSize": fieldSizeController.text.trim(),
        "private": privateController.text.trim()
      };
      Map<String, dynamic> createLocationRes = await LocationCommand().createLocation(createLocationInput);
      if(createLocationRes['success']){
        createLocationResponse['success'] = true;
      }

      return createLocationResponse;
    } on ApiException catch (e) {
      return createLocationResponse;
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
              // createLocation();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
