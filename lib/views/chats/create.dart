import 'package:flutter/material.dart';
import 'package:soccermadeeasy/views/chats/view.dart';
import 'package:soccermadeeasy/views/home.dart';
import '../../components/profile.dart';
import '../../commands/chat_command.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import 'chat/view.dart';

class ChatCreate extends StatefulWidget {
  const ChatCreate({Key? key, required this.eventObject, required this.teamObject, required this.players })
    : super(key: key);    

  final dynamic eventObject;
  final dynamic teamObject;
  final dynamic players;

  @override
  _ChatCreateState createState() => _ChatCreateState();
}

class _ChatCreateState extends State<ChatCreate> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
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



  void createChat() async {
    print("create chat");
    print("eventObject: "+widget.eventObject.toString());
    print("teamObject: "+widget.teamObject.toString());
    print("players: "+widget.players.toString());
    print("players length: "+widget.players.length.toString());
    String playersInput = "";
    for (var i = 0; i < widget.players.length; i++) {
      print("player: "+widget.players[i].toString());
      playersInput += widget.players[i]["_id"] +",";            
    }
    print("playersInput: $playersInput");
    dynamic chatInput = {
      "name": nameController.text.toString(),  
      "isPrivate": isPrivate

    };    
    dynamic objectsToAttachInput = {
      "eventId": widget.eventObject!=null ? 
        widget.eventObject["_id"] : null,
      "teamId": widget.teamObject!=null ? 
        widget.teamObject["_id"] : null,
      "playersIds":playersInput,
    };
    print("objectsToAttachInput: $objectsToAttachInput");
    Map<String, dynamic> createChatResp = await ChatCommand().createChat(chatInput, objectsToAttachInput);

    print("createChatResp: $createChatResp");
    if(createChatResp['success']){
      dynamic chatObject = createChatResp['data'];
      if(mounted){
        Navigator.pop(context, chatObject);
      }
    //   Navigator.push(context, MaterialPageRoute<void>(
    //   builder: (BuildContext context) {
    //     return Home();
    //   },
    // ));
    //   Navigator.push(context, MaterialPageRoute<void>(
    //   builder: (BuildContext context) {
    //     return ChatsView();
    //   },
    // )); 
    //   Navigator.push(context, MaterialPageRoute<void>(
    //   builder: (BuildContext context) {
    //     return ChatView(index: 0,chatObject: chatObject);
    //   },
    // ));
    }

  }

  @override
  void initState() {
    print("chat/view.dart init state");
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
            child: Text("Create Chat")),
        backgroundColor: Colors.orange.shade500,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Go to the next page',
            onPressed: () {
              
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
              createChat();
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
