import 'package:flutter/material.dart';
import '../../components/profile.dart';
import '../../commands/chat_command.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

class ChatCreate extends StatefulWidget {
  const ChatCreate(
    {Key? key })
    : super(key: key);    


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

  bool _isLoading = false;




  void goBack(){
    Navigator.pop(context);
  }

  void _firstLoad() async {
    print("first load");
  }

  void createChat() async {
    print("create chat");
    dynamic chatInput = {
      "name": nameController.text.toString(),      
    };
    Map<String, dynamic> createChatResp = await ChatCommand().createChat(chatInput);
    print("createChatResp: $createChatResp");

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
