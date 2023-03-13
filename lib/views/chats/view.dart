import 'package:flutter/material.dart';
import '../../components/profile.dart';
import '../../components/footers.dart';
import '../../components/headers.dart';
import '../../components/search_bar.dart';
import '../../commands/user_command.dart';
import '../../components/conversation_list.dart';
import '../../components/card_form_screen.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../models/user_model.dart';
import '../../models/chat_page_model.dart';
import 'package:provider/provider.dart';
import 'create.dart';

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

  bool _isLoading = false;
  late ScrollController _selectEventController = ScrollController();

  void goBack() {
    Navigator.pop(context);
  }

  void _firstLoad() async {
    print("first load");
    //get user chats    

    await UserCommand().findMyUserById();

  }

  @override
  void initState() {
    print("chat/view.dart init state");
    super.initState();
    _firstLoad();
  }

  @override
  Widget build(BuildContext context) {
    print("build() in chats view.dart page");
    List chats = context.select<UserModel, List>((value) => value.chats);
    print("chats: "+ chats.toString());
    int messagesLength = context.select<ChatPageModel, int>((value) => value.messagesLength);
    return Scaffold(
      body: SafeArea(
          child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
            Headers().getChatHeader(context),
            SearchBar(),
            ListView.builder(
              itemCount: chats.length,
              shrinkWrap: true,
              padding: EdgeInsets.only(top: 16),
              physics: NeverScrollableScrollPhysics(),
              
              itemBuilder: (context, index) {
                 dynamic messages = chats[index]['messages']['data'];
                 String messageContent = messages.length>0 ? messages[(messages.length)-1]['textObject']['content'] : "No Messages Yet";
                return ConversationList(
                  index: index,
                  chatObject: chats[index],
                  name: chats[index]['name'],
                  messageText: messageContent,
                  imageUrl: "imageUrl",//chats[index].imageURL,
                  time: "time",//chats[index].time,
                  isMessageRead: (index == 0 || index == 3) ? true : false,
                );
              },
            ),
            
          ])),
      bottomNavigationBar: Footers().getChatBottomNav(context),
    );
  }
}
