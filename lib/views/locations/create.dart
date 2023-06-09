import 'package:flutter/material.dart';
import 'package:soccermadeeasy/views/chats/view.dart';
import 'package:soccermadeeasy/views/home.dart';
import '../../commands/location_command.dart';
import '../../components/profile.dart';
import '../../commands/chat_command.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';



class LocationCreate extends StatefulWidget {
  const LocationCreate({Key? key, required this.eventObject, required this.teamObject })
    : super(key: key);    

  final dynamic eventObject;
  final dynamic teamObject;  

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

  bool _isLoading = false;




  void goBack(){
    Navigator.pop(context);
  }

  void _firstLoad() async {
    print("first load");
  }



  void createLocation() async {
    print("createLocation");
    print("eventObject: "+widget.eventObject.toString());
    print("teamObject: "+widget.teamObject.toString());        
    
    dynamic objectsToAttachInput = {
      "eventId": widget.eventObject!=null ? 
        widget.eventObject["_id"] : null,
      "teamId": widget.teamObject!=null ? 
        widget.teamObject["_id"] : null,
    };
    dynamic locationInput = {
      "name": nameController.text.toString(),  
      "address": "",
      "surface": surfaceController.text.toString(),
      "fieldSize": fieldSizeController.text.toString(),
      "description": descriptionController.text.toString(),
      "private": isPrivate,
      "latitude": 0.0,
      "longitude": 0.0,
      "objectsToAttachInput": objectsToAttachInput

    };    
    print("objectsToAttachInput: $objectsToAttachInput");
    Map<String, dynamic> createLocationResp = await LocationCommand().createLocation(locationInput);

    print("createLocationResp: $createLocationResp");
    if(createLocationResp['success']){
      dynamic locationObject = createLocationResp['data'];
      if(mounted){
        Navigator.pop(context);
      }
    }

  }

  @override
  void initState() {
    print("views/locations/create.dart init state");
    super.initState();    
    

    _firstLoad();    
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: new Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Create Location")),
        backgroundColor: Colors.orange.shade500,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Go to the next page',
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute<void>(
              //   builder: (BuildContext context) {
              //     return Profile();
              //   },
              // )
              // );
            },
          ),
        ],
      ),
      body: 
      Center(
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
          decoration: InputDecoration.collapsed(hintText: 'Make Chat Private'),
        ),
      ],
    )   ,         
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
