import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/loading_circular.dart';
import '../../commands/chat_command.dart';
import '../../commands/event_command.dart';
import '../../commands/images_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/footers.dart';
import '../../components/headers.dart';
import '../../components/search_bar.dart' as search_bar;
import '../../commands/user_command.dart';
import '../../components/conversation_list.dart';
import '../../models/enums/view_status.dart';
import '../../models/pageModels/chat_page_model.dart';
import 'package:provider/provider.dart';

import '../../models/pageModels/event_page_model.dart';
import 'chat_members_view.dart';

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

  ViewStatus _viewStatus = ViewStatus.loading;
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
          changeViewStatus(ViewStatus.completed);
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

  void navigateMemberView() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const ChatMembersView(),
      ),
    );
  }

  changeViewStatus(final ViewStatus status) {
    setState(() {
      _viewStatus = status;
    });
  }

  Future<void> onTapMembers(
      {final List<dynamic>? chatList, required final int index}) async {
    ChatCommand().updateSelectedChatIndex(index);

    await EventCommand()
        .getSelectedEvent({'_id': "${chatList?[index]['event']['_id']}"});

    navigateMemberView();
  }

  Future<void> onTapChatItem(
      {final List<dynamic>? chatList, required final int index}) async {
    ChatCommand().updateSelectedChatIndex(index);
    await EventCommand()
        .getSelectedEvent({'_id': "${chatList?[index]['event']['_id']}"});
  }

  @override
  Widget build(BuildContext context) {
    List chats = context.watch<ChatPageModel>().generalChatList;

    return Scaffold(
      body: _viewStatus == ViewStatus.loading
          ? const LoadingCircular()
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
                        participantCount:
                            List.from(chats[index]['users']['data']).length,
                        onTapChatItem: () =>
                            onTapChatItem(chatList: chats, index: index),
                        onTapMembers: () async =>
                            onTapMembers(chatList: chats, index: index),
                      );
                    },
                  )),
                ])),
      bottomNavigationBar: const Footers().getChatBottomNav(context),
    );
  }
}
