import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:soccermadeeasy/views/profile/profile.dart';

import '../commands/event_command.dart';
import '../commands/player_command.dart';
import '../commands/team_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../views/game/view.dart';
import '../views/player/view.dart';
import 'Dialogues/animated_dialogu.dart';

// // // // // // // // // // // // // // //
class SendMyEventsTeamRequestWidget extends StatefulWidget {
  SendMyEventsTeamRequestWidget(
      {Key? key,
      required this.team,
      required this.isMine,
      })
      : super(key: key);

  final dynamic team;
  final bool isMine;
  

  @override
  _SendMyEventsTeamRequestWidgetState createState() =>
      _SendMyEventsTeamRequestWidgetState();
}

class _SendMyEventsTeamRequestWidgetState
    extends State<SendMyEventsTeamRequestWidget> {
  List myEventsToChooseFrom = [];

  void setupEventsToChooseFrom() {
    print("setupEventsToChooseFrom");
    List<dynamic> myEvents = UserCommand().getAppModelMyEvents();
    myEventsToChooseFrom = myEvents;
  }

  Future<void> sendMyEventsRequestForTeam(
      Map<int, dynamic> indexes,
      List<dynamic> primaryList,
      List<dynamic> secondaryList,      
      ) async {
    print("sendMyEventsRequestForTeam: " + indexes.toString());
    indexes.forEach((mainIndex, secondaryIndexesThatIsNull) async {
      dynamic eventSelected = primaryList[mainIndex];
      if (widget.isMine) {
        //add team to event
        await EventCommand()
            .addTeamToEvent(eventSelected, widget.team);
        print("add team to event");
       
      }

      //add team to my event
    });
  }

  void goToMyEvent(dynamic event) {
    print("goToEvent");
    print("event: " + event.toString());
    // Navigator.push(
    //   context,
    //   MaterialPageRoute(
    //     builder: (context) => PickupView(game: event),
    //   ),
    // );
  }

  Container sendMyEventsTeamRequestWidget(
      BuildContext context) {
    print("sendMyEventsTeamRequestWidget");
    setupEventsToChooseFrom();
    return Container(
        child: GestureDetector(
            onTap: () async {
              List<dynamic> primaryList = myEventsToChooseFrom;
              List<dynamic> secondaryList = [];
              print("primaryList: " + primaryList.toString());
              print("userObjectDetails['team']['events']['data']: " +
                  widget.team['events']['data'].toString());
              List<dynamic> myProcessedEventList = primaryList
                  .where((item1) => !widget.team['events']['data']
                      .any((item2) => item2["_id"] == item1['event']["_id"]))
                  .map((item) => item['event'])
                  .toList();
              primaryList = myProcessedEventList;
              print("myProcessedEventList primaryList: " +
                  primaryList.toString());
              Map<int, dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                      details: {"title": "Send My Event Request to Team"},
                      items: primaryList,
                      singleSelect: false,
                      secondaryItems: secondaryList,
                      goToFunctions: [goToMyEvent]);
                },
              );
              if (result.isNotEmpty) {
                print("result: " + result.toString());
                sendMyEventsRequestForTeam(result, primaryList, secondaryList,
                 );
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.blue,
              child: Center(child: Text("Send My Event Request to Team")),
            )));
  }

  void loadInitialData() {
    print("loadInitialData");
  }

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return sendMyEventsTeamRequestWidget(context);
  }
}
