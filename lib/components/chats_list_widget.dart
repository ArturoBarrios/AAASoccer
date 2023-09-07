import 'dart:developer';

import 'package:flutter/material.dart';

import '../commands/chat_command.dart';
import '../commands/images_command.dart';
import '../views/chats/add_user_to_chat_view.dart';
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
    final chatMemberList = await processImages(List.from(selectedChat));
    if (chatMemberList != null) {
      await Navigator.of(context).push(
        MaterialPageRoute(
          fullscreenDialog: true,
          builder: (BuildContext context) =>
              AddUserToChatView(selectedChat: chatMemberList),
        ),
      );
    }
  }

  Future<dynamic> processImages(List<dynamic> objects) async {
    List<String> keys = [];

    for (var object in objects) {
      if (object['images']['data'].isNotEmpty) {
        keys.add(object['images']['data'].last['key'] ?? '');
      } else {
        keys.add('');
      }
    }

    final responses = await ImagesCommand().getImagesList(keys);
    final imageList = responses['data'];
    for (var object in objects) {
      for (var image in object['images']['data']) {
        for (var response in imageList) {
          if (image['key'] == response['key']) {
            image['url'] = response['signedUrl'];
          }
        }
      }
    }

    return objects;
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
                      inspect(chatsToDisplay);
                      return ConversationList(
                        chatObject: chat,
                        participantCount:
                            List.from(chatsToDisplay[index]['users']['data'])
                                .length,
                        onTapMembers: () async => await onTapMembers(
                            selectedChat: chatsToDisplay[index]['users']
                                ['data']),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
  }
}
