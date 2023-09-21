import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/headers.dart';
import 'package:soccermadeeasy/views/chats/view.dart';
import 'package:soccermadeeasy/views/home.dart';
import '../../commands/location_command.dart';
import '../profile/profile.dart';
import '../../commands/chat_command.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class LocationCreate extends StatefulWidget {
  const LocationCreate(
      {Key? key})
      : super(key: key);  

  @override
  _LocationCreateState createState() => _LocationCreateState();
}

class _LocationCreateState extends State<LocationCreate> {
  final nameController = TextEditingController();
  final descriptionController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  bool isPrivate = false;
  

  void goBack() {
    Navigator.pop(context);
  }  

  void createLocation() async {
    print("createLocation");
    
  }

  @override
  void initState() {
    print("views/locations/create.dart init state");
    super.initState();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Headers()
          .getBackHeader(context, "Create Location"),
      body: Center(
          child: Column(children: [
        TextField(
          readOnly: false,
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Name'),
        ),
        TextField(
          readOnly: true,
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Home'),
        ),
        Column(
          children: [
            Checkbox(
              value: isPrivate,
              onChanged: (value) {
                setState(() {
                  isPrivate = value!;
                });
              },
            ),
            TextField(
              decoration:
                  InputDecoration.collapsed(hintText: 'Make Chat Private'),
            ),
          ],
        ),
        IconButton(
          icon: const Icon(Icons.mark_chat_unread_rounded),
          tooltip: 'Chat',
          onPressed: () {
            createLocation();
          },
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
