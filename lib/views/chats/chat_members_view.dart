import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccermadeeasy/components/loading_circular.dart';
import 'package:soccermadeeasy/extensions/check_string_if_url.dart';
import 'package:soccermadeeasy/models/enums/view_status.dart';
import 'package:soccermadeeasy/models/pageModels/event_page_model.dart';
import 'package:soccermadeeasy/styles/colors.dart';

import '../../commands/images_command.dart';
import '../../models/pageModels/chat_page_model.dart';
import 'add_new_member_chat_view.dart';

class ChatMembersView extends StatefulWidget {
  const ChatMembersView({
    Key? key,
  }) : super(key: key);

  @override
  State<ChatMembersView> createState() => _ChatMembersViewState();
}

class _ChatMembersViewState extends State<ChatMembersView> {
  ViewStatus _viewStatus = ViewStatus.loading;

  List<dynamic>? memberList;
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
        memberList = await processImages(
            List.from(chats[selectedChatIndex]['users']['data']),
            eventUserParticipant);
        modifiedMemberList = getGroupedUsers(memberList ?? []);
        setState(() {});
      }
    });
  }

  Future<dynamic> processImages(
      List<dynamic> chatMembers, List<dynamic> eventUserParticipant) async {
    List<String> keys = [];

    for (var object in chatMembers) {
      if (object['images']['data'].isNotEmpty) {
        keys.add(object['images']['data'].last['key'] ?? '');
      } else {
        keys.add('');
      }
    }

    final responses = await ImagesCommand().getImagesList(keys);
    final imageList = responses['data'];
    for (var object in chatMembers) {
      final user = eventUserParticipant.firstWhere(
        (element) => object['_id'] == element['user']['_id'],
        orElse: () => null,
      );
      object['roles'] = user['roles'];

      for (var image in object['images']['data']) {
        for (var response in imageList) {
          if (image['key'] == response['key']) {
            image['url'] = response['signedUrl'];
          }
        }
      }
    }

    return chatMembers;
  }

  changeViewStatus(final ViewStatus status) {
    setState(() {
      _viewStatus = status;
    });
  }

  Future<void> onTapAddMember() async {
    await Navigator.of(context).push(
      MaterialPageRoute(
        fullscreenDialog: true,
        builder: (BuildContext context) => const AddNewMemberChatView(),
      ),
    );
  }

  Map<String, List<RoleModelWithImage>> getGroupedUsers(List userParticipants) {
    Map<String, List<RoleModelWithImage>> groupedUsers = {};

    for (var userMap in userParticipants) {
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
            name: userMap['name'],
            image: userMap['images'] != null
                ? List.from(userMap['images']['data']).isNotEmpty
                    ? List.from(userMap['images']['data']).last['url']
                    : ''
                : ''));
      }
    }

    return groupedUsers;
  }

  @override
  Widget build(BuildContext context) {
    context.watch<ChatPageModel>();

    return Scaffold(
        appBar: AppBar(
          title: const Text('Members'),
        ),
        body: _viewStatus == ViewStatus.loading
            ? const LoadingCircular()
            : Stack(
                children: [
                  ListView.builder(
                    itemCount: modifiedMemberList?.length,
                    itemBuilder: (context, index) {
                      String role =
                          modifiedMemberList?.keys.elementAt(index) ?? '';
                      final users = modifiedMemberList?[role];
                      return ListTile(
                        title: Text(role),
                        subtitle: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: users
                                  ?.map((user) => Row(
                                        children: [
                                          if (user.image != null &&
                                              user.image.isValidUrl())
                                            Image.network(
                                              user.image ?? '',
                                              height: 100,
                                              width: 100,
                                              fit: BoxFit.cover,
                                            )
                                          else
                                            Container(
                                              height: 100,
                                              width: 100,
                                              color:
                                                  AppColors.orangeColorShade500,
                                            ),
                                          const SizedBox(width: 10),
                                          Text(user.name ?? '')
                                        ],
                                      ))
                                  .toList() ??
                              [],
                        ),
                      );
                    },
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: TextButton(
                      onPressed: onTapAddMember,
                      style: TextButton.styleFrom(backgroundColor: Colors.blue),
                      child: const Text(
                        'Add member',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  )
                ],
              ));
  }
}

class RoleModelWithImage {
  const RoleModelWithImage({
    this.name,
    this.image,
    this.userId,
    this.chatId,
  });

  final String? name;
  final String? image;
  final String? userId;
  final String? chatId;
}
