import 'package:flutter/material.dart';
import '../../../components/Loading/loading_screen.dart';
import '../../../views/home.dart';
// import '../../components/payment_screen.dart';
// import '../../components/card_form_screen.dart';
import '../../../commands/user_command.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../../models/chat_page_model.dart';
import 'package:provider/provider.dart';
import '../../../components/headers.dart';
import '../../../components/conversation_list.dart';
import '../../../components/bottom_text_box.dart';
// import 'create.dart';

class ChatView extends StatefulWidget {
  const ChatView({Key? key, required this.chatObject})
      : super(key: key);
  final Map<String, dynamic> chatObject;
  

  @override
  _ChatViewState createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  dynamic user = {};

  List<Map<String, dynamic>> chatUsers = [
    {"messageContent": "Hello, Will", "messageType": "receiver"},
    {"messageContent": "How have you been?", "messageType": "sender"},
  ];

  bool _isLoading = true;
  late ScrollController scrollController = ScrollController();

  dynamic chatMessages = [];

  void goBack() {
    Navigator.pop(context);
  }

  Future<void> _firstLoad() async {
    print("first load for chat data");
    dynamic findMyUserByIdResp = await UserCommand().findMyUserById();
    print("findMyUserByIdResp: $findMyUserByIdResp");
    dynamic newUser = findMyUserByIdResp['data'];
    setState(() {
      user = newUser;

      _isLoading = false;
    });
  }

  @override
  void initState() {
    print("chats/chat/view.dart init state");
    print("widget.chatObject: ${widget.chatObject}");
    super.initState();
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    List messages =
        context.select<ChatPageModel, List>((value) => value.messages);

    // int messagesLength =
    //     context.select<ChatPageModel, int>((value) => value.messagesLength);
    print("build() messages: $messages");
    return Scaffold(
      appBar: Headers().getChatDetailHeader(context, widget.chatObject),
      body: _isLoading
          ? Container(
              height: double.infinity,
              width: double.infinity,
              child: Align(
                  alignment: Alignment.center,
                  child:
                      // BottomNav()//for times when user deleted in cognito but still signed into app
                      LoadingScreen(
                          currentDotColor: Colors.white,
                          defaultDotColor: Colors.black,
                          numDots: 10)))
          : Stack(children: <Widget>[
              // Text("messagesLength: $messagesLength"),
              Expanded(
                  child: ListView.builder(
                      controller: scrollController,
                      itemCount: messages.length,
                      shrinkWrap: true,
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      physics: AlwaysScrollableScrollPhysics(),
                      itemBuilder: (_, index) {
                        return Container(
                            padding: EdgeInsets.only(
                                left: 14, right: 14, top: 10, bottom: 10),
                            child: Align(
                              alignment: (messages[index]['sender']['_id'] !=
                                      user['_id']
                                  ? Alignment.topLeft
                                  : Alignment.topRight),
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(20),
                                  color: (messages[index]['sender']['_id'] !=
                                          user['_id']
                                      ? Colors.grey.shade200
                                      : Colors.blue[200]),
                                ),
                                padding: EdgeInsets.all(16),
                                child: Text(
                                  messages[index]['textObject']['content'],
                                  style: TextStyle(fontSize: 15),
                                ),
                                // child: Text(chatUsers[index]['messageContent'], style: TextStyle(fontSize: 15),),
                              ),
                            ));
                      })),
              BottomTextBox(
                chatObject: widget.chatObject,
                
              ),
            ]),
    );
  }
}
