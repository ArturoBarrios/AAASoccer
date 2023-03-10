import 'package:flutter/material.dart';
// import '../../components/profile.dart';
// import '../../components/payment_screen.dart';
// import '../../components/card_form_screen.dart';
// import '../../components/Cards/chat_card.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import '../../models/user_model.dart';
import 'package:provider/provider.dart';
import '../../../components/headers.dart';
import '../../../commands/chat_command.dart';
import '../../../commands/user_command.dart';
// import 'create.dart';

class BottomTextBox extends StatefulWidget {
  const BottomTextBox({Key? key, required this.chatObject}) 
    : super(key: key);
  final Map<String, dynamic> chatObject;  

  @override
  _BottomTextBoxState createState() => _BottomTextBoxState();
}

class _BottomTextBoxState extends State<BottomTextBox> {
  final messageController = TextEditingController();


  bool _isLoading = false;
  late ScrollController _selectEventController = ScrollController();

  void goBack() {
    Navigator.pop(context);
  }

  void _firstLoad() async {
    print("first load");
  }

  void sendMessage() async {
    print("send message");
    dynamic currentUser = UserCommand().getAppModelUser();
    dynamic messageInput = {
      "content": messageController.text.toString(),
      "chat_id": widget.chatObject['_id'],
      "sender_id": currentUser['_id'],
    };
    Map<String, dynamic> sendMessageResp =
        await ChatCommand().createText(messageInput);
    print("createChatResp: $sendMessageResp");
  }

  @override
  void initState() {
    print("chat/create.dart init state");
    super.initState();
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    return 
      Stack(
        children: <Widget>[
          Align(
            alignment: Alignment.bottomLeft,
            child: Container(
              padding: EdgeInsets.only(left: 10, bottom: 10, top: 10),
              height: 60,
              width: double.infinity,
              color: Colors.white,
              child: Row(
                children: <Widget>[
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      height: 30,
                      width: 30,
                      decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(30),
                      ),
                      child: Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                          hintText: "Write message...",
                          hintStyle: TextStyle(color: Colors.black54),
                          border: InputBorder.none),
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  FloatingActionButton(
                    onPressed: () {
                      print("send message button pressed");
                      sendMessage();
                    },
                    child: Icon(
                      Icons.send,
                      color: Colors.white,
                      size: 18,
                    ),
                    backgroundColor: Colors.blue,
                    elevation: 0,
                  ),
                ],
              ),
            ),
          ),
        ],
      );
    
  }
}
