// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/models/pageModels/event_page_model.dart';
import 'package:soccermadeeasy/views/chats/chat_gallery_view.dart';

import '../../commands/chat_command.dart';
import '../../commands/event_command.dart';
import '../../components/custom_tile_list_with_title.dart';
import '../../components/models/button_model.dart';
import '../../components/models/tile_list_model.dart';
import '../../models/pageModels/chat_page_model.dart';
import 'chat_members_view.dart';

class ChatSettingsView extends StatefulWidget {
  const ChatSettingsView({Key? key}) : super(key: key);

  @override
  State<ChatSettingsView> createState() => _ChatSettingsViewState();
}

class _ChatSettingsViewState extends State<ChatSettingsView> {
  Future<void> onTapMembers() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const ChatMembersView(),
      ),
    );
  }

  Future<void> onTapGallery() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        builder: (BuildContext context) => const ChatGalleryView(),
      ),
    );
  }

  Future<void> onTapDeleteChat(
      {final String? chatId, required List currentChats}) async {
    if (chatId == null) return;

    final chatInput = {
      '_id': chatId,
      'isMainChat': false,
    };

    final selectedChat = currentChats.firstWhere(
      (element) => chatId == element['_id'],
      orElse: () => null,
    );

    final membersOfTheChat = List.from(selectedChat['users']['data']);

    for (var member in membersOfTheChat) {
      final disconnectChatInput = {
        'userId': member['_id'],
        'chatId': chatId,
      };
      await ChatCommand().disconnectUser(disconnectChatInput);
    }

    final result = await ChatCommand().removeChat(chatInput);

    if (result['data'] != null) {
      updateChats(currentChats, result['data']['_id']);
      Navigator.pop(context);
      Navigator.pop(context);
    }
  }

  void updateChats(List currentChats, String chatId) {
    List tempChatList = [];
    for (var chat in currentChats) {
      if (chat['_id'] != chatId) {
        tempChatList.add(chat);
      }
    }

    EventCommand().updateEventChat(tempChatList);
    ChatCommand().updateGeneralChatList(tempChatList);
  }

  @override
  Widget build(BuildContext context) {
    List chats = context.watch<ChatPageModel>().generalChatList;
    int selectedChat = context.watch<ChatPageModel>().selectedChat;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Settings',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w500),
        ),
      ),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  children: [
                    CustomTileListWithTitle(
                      tileModelList: [
                        TileListModel(
                          buttonList: [
                            ButtonModel(
                              text: 'Members',
                              prefixIconData: Icons.group,
                              onTap: onTapMembers,
                            ),
                            ButtonModel(
                              text: 'Gallery',
                              prefixIconData: Icons.photo_library,
                              onTap: onTapGallery,
                            ),
                            ButtonModel(
                              text: 'Delete',
                              prefixIconData: Icons.delete_rounded,
                              onTap: () => onTapDeleteChat(
                                  chatId: chats[selectedChat]['_id'],
                                  currentChats: chats),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
