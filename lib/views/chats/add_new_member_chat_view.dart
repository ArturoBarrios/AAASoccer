import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../commands/chat_command.dart';
import '../../commands/event_command.dart';
import '../../components/loading_circular.dart';
import '../../models/enums/view_status.dart';
import '../../models/pageModels/chat_page_model.dart';
import '../../models/pageModels/event_page_model.dart';
import 'chat_members_view.dart';

class AddNewMemberChatView extends StatefulWidget {
  const AddNewMemberChatView({Key? key}) : super(key: key);

  @override
  State<AddNewMemberChatView> createState() => _AddNewMemberChatViewState();
}

class _AddNewMemberChatViewState extends State<AddNewMemberChatView> {
  ViewStatus _viewStatus = ViewStatus.loading;

  Map<String, List<RoleModelWithImage>>? modifiedMemberList;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    changeViewStatus(ViewStatus.loading);
    loadInitialData();
    changeViewStatus(ViewStatus.completed);
  }

  Future<void> loadInitialData() async {
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final chatPageModel = context.read<ChatPageModel>();
      final chats = chatPageModel.generalChatList;
      final selectedChatIndex = chatPageModel.selectedChat;
      final eventUserParticipant =
          context.read<EventPageModel>().userParticipants;

      if (chats[selectedChatIndex] != null) {
        modifiedMemberList =
            getGroupedUsers(eventUserParticipant, chats[selectedChatIndex]);

        setState(() {});
      }
    });
  }

  Future<dynamic> processImages(
      List<dynamic> chatMembers, List<dynamic> eventUserParticipant) async {
    List<String> keys = [];

    for (var participant in eventUserParticipant) {
      if (participant['images']['data'].isNotEmpty) {
        keys.add(participant['images']['data'].last['key'] ?? '');
      } else {
        keys.add('');
      }
    }

    return chatMembers;
  }

  Map<String, List<RoleModelWithImage>> getGroupedUsers(
      List userParticipants, dynamic currentChat) {
    final memberList = currentChat['users']['data'];
    final notAddedUsers = userParticipants.where((participant) {
      return !memberList
          .any((member) => member['_id'] == participant['user']['_id']);
    }).toList();

    Map<String, List<RoleModelWithImage>> groupedUsers = {};

    for (var userMap in notAddedUsers) {
      if (userMap is Map<String, dynamic>) {
        String roles = userMap['roles']
            .toString()
            .replaceAll('{', '')
            .replaceAll('}', '')
            .replaceAll(' ', '')
            .replaceAll(',', '-');

        if (!groupedUsers.containsKey(roles)) {
          groupedUsers[roles] = [];
        }
        groupedUsers[roles]?.add(RoleModelWithImage(
          name: userMap['user']['name'],
          chatId: currentChat['_id'],
          userId: userMap['user']['_id'],
        ));
      }
    }

    return groupedUsers;
  }

  changeViewStatus(final ViewStatus status) {
    setState(() {
      _viewStatus = status;
    });
  }

  Future<void> addUserToChat(String? chatId, String? userId) async {
    List chats = context.read<EventPageModel>().chats;
    final generalChatList = context.read<ChatPageModel>().generalChatList;
    Map<String, dynamic> request = {
      "chatId": chatId,
      "userId": userId,
    };

    final result = await ChatCommand().addUserToChat(request);

    final modifiedEventChatList =
        updateEventChatList(chats, chatId, result['data']);
    final modifiedGeneralChatList =
        updateEventChatList(generalChatList, chatId, result['data']);
    EventCommand().updateEventChat(modifiedEventChatList);
    ChatCommand().updateGeneralChatList(modifiedGeneralChatList);

    await loadInitialData();
  }

  dynamic updateEventChatList(
      List<dynamic>? chatList, String? chatId, dynamic updatedUsers) {
    if (chatList != null) {
      for (var chat in chatList) {
        if (chat['_id'] == chatId) {
          chat['users']['data'] = updatedUsers;
        }
      }
    }
    return chatList;
  }

  dynamic updateGeneralChatList(
      List<dynamic> generalChatList, String? chatId, dynamic updatedUsers) {
    for (var chat in generalChatList) {
      if (chat['_id'] == chatId) {
        chat['users']['data'] = updatedUsers;
      }
    }

    return generalChatList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: _viewStatus == ViewStatus.loading
          ? const LoadingCircular()
          : ListView.builder(
              itemCount: modifiedMemberList?.length,
              itemBuilder: (context, index) {
                String role = modifiedMemberList?.keys.elementAt(index) ?? '';
                final users = modifiedMemberList?[role];

                return ListTile(
                  title: Text(role),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: users
                            ?.map((user) => Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(user.name ?? ''),
                                    IconButton(
                                        onPressed: () async {
                                          await addUserToChat(
                                              users[index].chatId,
                                              users[index].userId);
                                        },
                                        icon: const Icon(Icons.add))
                                  ],
                                ))
                            .toList() ??
                        [],
                  ),
                );
              },
            ),
    );
  }
}
