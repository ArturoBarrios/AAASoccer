import 'package:flutter/material.dart';
// import 'package:auto_size_text/auto_size_text.dart';
// // import 'package:flutter_svg/flutter_svg.dart';
// import 'package:flutter_svg_provider/flutter_svg_provider.dart';
// import '../../svg_widgets.dart';
// import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
// import '../../models/app_model.dart';
import '../../../commands/chat_command.dart';
// import '../../views/chat/view.dart';

class ChatCard extends StatefulWidget {
  const ChatCard(
      {Key? key, required this.chatObject})
      : super(key: key);
  final Map<String, dynamic> chatObject;  

  @override
  State<ChatCard> createState() => _ChatCard();
}

void chatClicked() {
  print("Chat Clicked");
}

void removeChat(dynamic chatObject) async{
  print("removeChat for chatObject: $chatObject");
  dynamic deleteChatIterableInput = [
    {"dataType": "iterableDisconnect",
    "data": chatObject['users']['data'],
    "_id": chatObject['_id']
    }
  ];
  await ChatCommand().removeChat(chatObject);
}

void archiveChat(dynamic chatObject) async{
  print("archiveChat for chatObject: $chatObject");
  dynamic archiveChatIterableInput = [
    {"dataType": "normal",
    "data": chatObject['archived'],
    "_id": chatObject['_id']
    }
  ];
  await ChatCommand().archiveChat(chatObject);
}

class _ChatCard extends State<ChatCard> {
  final bool _isPressed = false;
  final Color color = Colors.grey.shade200;

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.orange.shade500,
      textStyle: const TextStyle(fontSize: 20));
  final imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555";
  @override
  Widget build(BuildContext context) {
    print("widget name: ");
    print(widget.chatObject.toString());
    return 
    Card(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
             ListTile(
              leading: Icon(Icons.album),
              title: Text(widget.chatObject["name"]),
              subtitle: Text('Music by Julie Gable. Lyrics by Sidney Stein.'),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                TextButton(
                  child: const Text('REMOVE'),
                  onPressed: () {
                    print("Remove Clicked");
                    removeChat(widget.chatObject);
                  },
                ),
                const SizedBox(width: 8),
                TextButton(
                  child: const Text('ARCHIVE'),
                  onPressed: () {
                    print("Remove Clicked");
                    removeChat(widget.chatObject);
                  },
                ),
                const SizedBox(width: 8),
              ],
            ),
          ],
        ),
      );
  }

}




