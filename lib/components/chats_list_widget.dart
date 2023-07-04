import 'package:flutter/material.dart';

import '../views/chats/chat/view.dart';
import 'conversation_list.dart';

class ChatsListWidget extends StatefulWidget {
  final List<dynamic> chats;

  ChatsListWidget({required this.chats});

  @override
  _ChatsListWidgetState createState() => _ChatsListWidgetState();
}

class _ChatsListWidgetState extends State<ChatsListWidget> {
  void removeChat(chatToRemove) {
    // Implement the logic to remove a chat from the list
    setState(() {
      widget.chats.remove(chatToRemove); // Remove the chat at index 0 as an example
    });
  }

  void goToChat(chat) {
    // Implement the logic to go to the chat page
    dynamic chatObjectDetails = {      
      "chatObject": chat
    };
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ChatView(chatObject: chat),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // You can adjust this height as needed
      padding: EdgeInsets.all(8.0),
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
          Text(
            'Chats',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 18,
            ),
          ),
          Expanded(
            child: ListView.builder(
              itemCount: widget.chats.length,
              itemBuilder: (context, index) {
                var chat = widget.chats[index];
                var isPrivate = chat['isPrivate'];
                return ConversationList(                  
                  chatObject: chat,                  
                );
                // return Card(
                //   child: ListTile(
                //     onTap: () {
                //       // Do something when a chat row is clicked
                //       print('Chat row tapped!');
                //       goToChat(chat);

                //     },
                //     title: Text(
                //         isPrivate ? 'Private Chat(No Details available)' : chat['name']),
                //     trailing: Row(
                //       mainAxisSize: MainAxisSize.min,
                //       children: [
                //         IconButton(
                //           icon: Icon(Icons.ice_skating), // Replace icon1 with your desired icon
                //           onPressed: () {
                //             // Do something when icon1 is pressed
                //             print('Icon 1 pressed!');
                //           },
                //         ),
                //         IconButton(
                //           icon: Icon(Icons.delete), // Replace icon2 with your desired icon
                //           onPressed: () {
                //             // Do something when delete icon is pressed
                //             print('Delete pressed!');
                //             removeChat(chat);
                //           },
                //         ),
                //       ],
                //     ),
                //   ),
                // );
              },
            ),
          ),
        ],
      ),
    );
  }
}
