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
// import 'create.dart';

class BottomTextBox extends StatefulWidget {
  const BottomTextBox({Key? key}) : super(key: key);

  @override
  _BottomTextBoxState createState() => _BottomTextBoxState();
}

class _BottomTextBoxState extends State<BottomTextBox> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  bool _isLoading = false;
  late ScrollController _selectEventController = ScrollController();

  void goBack() {
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
    Map<String, dynamic> createChatResp =
        await ChatCommand().createChat(chatInput);
    print("createChatResp: $createChatResp");
  }

  @override
  void initState() {
    print("chat/create.dart init state");
    super.initState();
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
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
                    onPressed: () {},
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
      ),
    );
  }
}
