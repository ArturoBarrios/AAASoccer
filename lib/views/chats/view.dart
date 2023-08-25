import 'package:flutter/material.dart';
import '../../commands/chat_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/footers.dart';
import '../../components/headers.dart';
import '../../components/search_bar.dart' as search_bar;
import '../../commands/user_command.dart';
import '../../components/conversation_list.dart';
import '../../models/chat_page_model.dart';
import 'package:provider/provider.dart';

class ChatsView extends StatefulWidget {
  const ChatsView({Key? key}) : super(key: key);

  @override
  _ChatsViewState createState() => _ChatsViewState();
}

class _ChatsViewState extends State<ChatsView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  dynamic objectImageInput;

  bool _isLoading = true;
  late ScrollController _selectEventController = ScrollController();

  void goBack() {
    Navigator.pop(context);
  }

  Future<void> loadInitialData() async {
    print("first load");
    //get user chats
    dynamic findMyUserByIdResp = await UserCommand().findMyUserById();
    Map<String, dynamic> setupChatModelsResp =
        await ChatCommand().setupChatModels();
    print("setupChatModelsResp: " + setupChatModelsResp.toString());
    if (setupChatModelsResp['success'] == true) {
      WidgetsBinding.instance.addPostFrameCallback(
        (_) {
          setState(() {
            _isLoading = false;
          });
        },
      );
    }
  }

  @override
  void initState() {
    print("chat/view.dart init state");
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    print("build() in chats view.dart page");
    List chats = context.watch<ChatPageModel>().chats;

    print("chats: " + chats.toString());
    // int messagesLength = context.select<ChatPageModel, int>((value) => value.messagesLength);
    return Scaffold(
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
                        numDots: 10),
              ),
            )
          : SafeArea(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: <Widget>[
                  Headers().getChatHeader(context),
                  search_bar.SearchBar(),
                  // Text("Chats: " + messagesLength.toString()),
                  Expanded(
                      child: ListView.builder(
                    itemCount: chats.length,
                    shrinkWrap: true,
                    padding: EdgeInsets.only(top: 16),
                    physics: ScrollPhysics(),
                    itemBuilder: (context, index) {
                      dynamic messages = chats[index]['messages']['data'];
                      String messageContent = messages.length > 0
                          ? messages[(messages.length) - 1]['textObject']
                              ['content']
                          : "No Messages Yet";
                      return ConversationList(
                        chatObject: chats[index],
                      );
                    },
                  )),
                ])),
      bottomNavigationBar: const Footers().getChatBottomNav(context),
    );
  }
}
