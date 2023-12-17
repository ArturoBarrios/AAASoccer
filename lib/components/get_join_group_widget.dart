import 'dart:developer';

import 'package:flutter/material.dart';

import '../commands/base_command.dart';
import '../commands/event_command.dart';
import '../commands/group_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../views/chats/create.dart';
import '../views/game/view.dart';
import 'Dialogues/animated_dialogu.dart';
import 'card_form_screen.dart';

class GetJoinGroupWidget extends StatefulWidget  {
  final dynamic group;
  final dynamic user;
  final List<dynamic> roles;
  final bool isMine;
  final dynamic price;
  final String amountRemaining;

  GetJoinGroupWidget({
    required this.group,
    required this.user,
    required this.roles,
    required this.isMine,
    required this.price,
    required this.amountRemaining,
  });

  @override
  _GetJoinGroupWidgetState createState() => _GetJoinGroupWidgetState();
}

class _GetJoinGroupWidgetState extends State<GetJoinGroupWidget> {


  

  void loadInitialData() {
    // userObject = UserCommand().getAppModelUser();
    // group = widget.userObjectDetails['group'];
  }

  @override
  void initState() {
    super.initState();
    print("initState() GetJoinGroupWidget");
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
