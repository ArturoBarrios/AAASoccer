import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:soccermadeeasy/views/chats/chat_members_view.dart';

import '../commands/chat_command.dart';
import '../commands/images_command.dart';
import '../models/pageModels/chat_page_model.dart';
import '../views/chats/chat/view.dart';
import 'Loading/loading_screen.dart';
import 'conversation_list.dart';

class ChatsListWidget extends StatefulWidget {
  final List<dynamic> chats;

  const ChatsListWidget({
    Key? key,
    required this.chats,
  }) : super(key: key);

  @override
  State<ChatsListWidget> createState() => _ChatsListWidgetState();
}

class _ChatsListWidgetState extends State<ChatsListWidget> {
  bool _isLoading = true;
  List<dynamic> chatsToDisplay = [];

  void removeChat(chatToRemove) {
    // Implement the logic to remove a chat from the list
    setState(() {
      widget.chats
          .remove(chatToRemove); // Remove the chat at index 0 as an example
    });
  }

  void goToChat(chat) {
    // Implement the logic to go to the chat page
    dynamic chatObjectDetails = {"chatObject": chat};
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatView(chatObject: chat),
      ),
    );
  }

  Future<void> loadInitialData() async {
    print("loadInitialData()");
    print("widget.chats: " + widget.chats.toString());
    // Implement the logic to load chat data from the API
    Map<String, dynamic> setupChatsResp =
        await ChatCommand().setupChats(widget.chats);
    print("setupChatsResp: " + setupChatsResp.toString());
    if (setupChatsResp['success'] == true) {
      setState(() {
        chatsToDisplay = setupChatsResp['data'];
        print("chatsToDisplay: " + chatsToDisplay.toString());
        _isLoading = false;
      });
    }
  }

  @override
  void initState() {
    print("initState()");
    super.initState();
    loadInitialData();
  }

  Future<void> onTapMembers({dynamic selectedChat}) async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => const ChatMembersView(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return _isLoading
        ? SizedBox(
            height: 120,
            width: MediaQuery.of(context).size.width,
            child: const Align(
              alignment: Alignment.center,
              child:
                  // BottomNav()//for times when user deleted in cognito but still signed into app
                  LoadingScreen(
                currentDotColor: Colors.white,
                defaultDotColor: Colors.black,
                numDots: 10,
              ),
            ),
          )
        : Container(
            height: 300, // You can adjust this height as needed
            padding: const EdgeInsets.all(8.0),
            decoration: BoxDecoration(
              border: Border.all(
                color: Colors.grey,
              ),
              borderRadius: BorderRadius.circular(5.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // You can replace this with any header widget you'd like.
                const Text(
                  'Chats',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                    itemCount: chatsToDisplay.length,
                    itemBuilder: (context, index) {
                      var chat = chatsToDisplay[index];
                      var isPrivate = chat['isPrivate'];

                      return ConversationList(
                        chatObject: chat,
                        participantCount:
                            List.from(chatsToDisplay[index]['users']['data'])
                                .length,
                        onTapMembers: () async {
                          ChatPageModel().selectedChat = index;

                          await onTapMembers(
                              selectedChat: chatsToDisplay[index]['users']
                                  ['data']);
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
