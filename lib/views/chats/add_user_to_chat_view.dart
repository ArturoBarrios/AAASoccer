import 'package:flutter/material.dart';

class AddUserToChatView extends StatelessWidget {
  const AddUserToChatView({Key? key, this.selectedChat}) : super(key: key);

  final dynamic selectedChat;

  Future<void> addUserOnTap() async {}

  @override
  Widget build(BuildContext context) {
    final memberList = List.from(selectedChat);

    return Scaffold(
        appBar: AppBar(
          title: const Text('Members'),
        ),
        body: ListView.builder(
          itemCount: memberList.length,
          itemBuilder: (context, index) {
            final imageList = List.from(memberList[index]['images']['data']);
            return Card(
              child: Row(
                children: [
                  if (imageList.isNotEmpty)
                    Image.network(
                      imageList.last['url'] ?? '',
                      height: 100,
                      width: 100,
                      fit: BoxFit.cover,
                    ),
                  Text(
                    memberList[index]['name'],
                  ),
                ],
              ),
            );
          },
        ));
  }
}
