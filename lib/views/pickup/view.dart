import 'package:flutter/material.dart';

class PickupView extends StatefulWidget {
  @override
  _PickupViewState createState() => _PickupViewState();
}

class _PickupViewState extends State<PickupView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();
  


  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
          TextField(
            controller: nameController,
            decoration: new InputDecoration.collapsed(hintText: 'Email'),
          ),
      ])),
    );
  }
}
