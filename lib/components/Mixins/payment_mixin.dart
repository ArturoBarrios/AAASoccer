import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/request/view.dart';

import '../../commands/event_command.dart';
import '../../commands/player_command.dart';
import '../../commands/team_command.dart';
import '../../commands/user_command.dart';
import '../../constants.dart';

mixin PaymentMixin {
  GestureDetector getJoinGameWidget(bool isMyEvent, dynamic event, dynamic userInput) {
    if (isMyEvent) {
      return GestureDetector(
        onTap: () {
          print("onTap Join My Game");
        },
        child: Text("Join my Game"),
      );
    } else {
      //!withPayment&&!withRequest
      if (!event['joinConditions']['withPayment'] &&
          !event['joinConditions']['withRequest']) {
        return GestureDetector(
          onTap: () {
            print("onTap Join Gameeeee");
            EventCommand().addUserToEvent(event, userInput);
          },
          child: Text("Join Game"),
        );
      }
      //!withPayment && withRequest
      else if (!event['joinConditions']['withPayment'] &&
          event['joinConditions']['withRequest']) {
        return GestureDetector(
          onTap: () {
            print("Send Request to Join with no payment required");
          },
          child: Text("Send Request to Join(No Payment required to join)"),
        );
      }
      //withPayment && !withRequest
      else if (event['joinConditions']['withPayment'] &&
          !event['joinConditions']['withRequest']) {
        return GestureDetector(
          onTap: () {
            print("Send Request to Join with no payment required");
          },
          child: Text("Pay to Join Game"),
        );
      }
      //withPayment && withRequest
      else {
        return GestureDetector(
          onTap: () {
            print("Send Request to Join with no payment required");
          },
          child: Text("Send Request to Join(Payment required to join)"),
        );
      }
    }
  }
}
