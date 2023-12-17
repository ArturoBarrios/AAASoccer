import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/request/view.dart';
import '../views/profile/profile.dart';
import '../views/game/create.dart';
import '../views/tournament/create.dart';
import '../views/league/create.dart';
import '../views/training/create.dart';
import '../views/tryout/create.dart';
import '../views/team/create/create.dart';
import '../commands/chat_command.dart';
import '../components/history.dart';
import '../views/chats/view.dart';

class SingleListDialog extends StatefulWidget {
  const SingleListDialog({Key? key}) : super(key: key);

  @override
  State<SingleListDialog> createState() => _SingleListDialog();
}

class _SingleListDialog extends State<SingleListDialog> {
  void onTapMenu() {}
  final title = "Jefferson";
  final upperTitle = "Welcome back,";

  @override
  Widget build(BuildContext context) {
    return AppBar(
      centerTitle: false,
      title: new Padding(
          padding: const EdgeInsets.only(left: 20.0),
          child: Text("Find Soccer Near You")),
      backgroundColor: Colors.orange.shade500,
      actions: <Widget>[
        IconButton(
          icon: const Icon(Icons.account_circle),
          tooltip: 'Go to the next page',
          onPressed: () {
            // Navigator.push(context, MaterialPageRoute<void>(
            //   builder: (BuildContext context) {
            //     return Profile();
            //   },
            // ));
          },
        ),
      ],
    );
  }
}
