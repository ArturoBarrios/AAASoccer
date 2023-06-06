import 'package:flutter/material.dart';

class ChatsListWidget extends StatelessWidget {
  final List<dynamic> chats;

  ChatsListWidget({required this.chats});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,  // You can adjust this height as needed
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
              itemCount: chats.length,
              itemBuilder: (context, index) {
                var chat = chats[index];
                var isPrivate = chat['isPrivate'];
                return Card(
                  child: ListTile(
                    onTap: () {
                      // Do something when a chat row is clicked
                    },
                    title: Text(isPrivate ? 'Private Chat(No Details available)' : chat['name']),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.ice_skating),  // Replace icon1 with your desired icon
                        Icon(Icons.safety_check),  // Replace icon2 with your desired icon
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
