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

class ChatCreate extends StatefulWidget {
  const ChatCreate({Key? key}) 
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
    Map<String, dynamic> createChatResp = await ChatCommand().createChat(chatInput);
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
      appBar: Headers().getCreateChatDetailHeader(context),
      body: Container(
        child:  GestureDetector(
            onTap: () {
              createChat();
            },
            child: Text("Create Chat"))

      ),
    );
  }
}
