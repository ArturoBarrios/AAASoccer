import 'package:flutter/material.dart';
import '../../components/headers.dart';

class TrainingView extends StatefulWidget {
  const TrainingView(
    {Key? key, required this.isMyEvent, required this.training })
    : super(key: key);

    final bool isMyEvent;
    final dynamic training;

  @override
  _TrainingViewState createState() => _TrainingViewState();
}

class _TrainingViewState extends State<TrainingView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();
  


  bool _isLoading = false;

  void goBack(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print("TrainingView build() widget.training: "+ widget.training.toString());

    return Scaffold(
      appBar: Headers().getMainHeader(context),
      body: Center(
          child: Column(children: [
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Name'),
        ),
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Home'),
        ),
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Away'),
        ),
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Training'),
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
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Price'),
        ),
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Location'),
        ),
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Images'),
        ),
        
        GestureDetector(
            onTap: () {
              goBack();
            },
            child: Text("Back to Home")),
      ])),
    );
  }
}
