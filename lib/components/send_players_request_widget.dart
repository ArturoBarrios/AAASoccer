import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:soccermadeeasy/views/profile/profile.dart';

import '../commands/event_command.dart';
import '../commands/player_command.dart';
import '../commands/team_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../views/player/view.dart';
import 'Dialogues/animated_dialogu.dart';

// // // // // // // // // // // // // // //
class SendPlayersRequestWidget extends StatefulWidget {
  SendPlayersRequestWidget({Key? key, required this.mainEvent, required this.team, required this.players, required this.isMine })
      : super(key: key);

  final dynamic mainEvent;
  final dynamic team;
  final dynamic players;
  final dynamic isMine;

  @override
  _SendPlayersRequestWidgetState createState() =>
      _SendPlayersRequestWidgetState();
}

class _SendPlayersRequestWidgetState extends State<SendPlayersRequestWidget> {
  List playerList = [];
  dynamic userObject;
  List requestUserTypes = [
    Constants.PLAYER.toString(),
    Constants.ORGANIZER.toString(),
    Constants.MANAGER.toString(),
    Constants.MAINCOACH.toString(),
    Constants.ASSISTANTCOACH.toString(),
    Constants.REF.toString(),
  ];

  void setupPlayerList() {
    print("setupPlayerList");
    playerList = PlayerCommand().getAppModelPlayersNearMe();
    print("playerList: " + playerList.toString());
    print("playerList length: " + playerList.length.toString());
    userObject = UserCommand().getAppModelUser();
  }

  String getRequestType(eventObject) {
    String type = "GAMEREQUEST";
    if (eventObject['type'] == "GAME") {
      type = "GAMEREQUEST";
    } else if (eventObject['type'] == "LEAGUE") {
      type = "LEAGUEREQUEST";
    } else if (eventObject['type'] == "TOURNAMENT") {
      type = "TOURNAMENTREQUEST";
    } else if (eventObject['type'] == "TRAINING") {
      type = "TRAININGREQUEST";
    } else if (eventObject['type'] == "TRYOUT") {
      type = "TRYOUTREQUEST";
    }
    return type;
  }

  Future<void> sendPlayersEventRequest(Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList) async {
    print("sendPlayersEventRequest");
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());

    String type = getRequestType(widget.mainEvent);

    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic playerChosen = primaryList[mainIndex];
      dynamic roles = [];
      secondaryIndexes.forEach((secondaryIndex, blankValue) {
        roles.add(secondaryList[secondaryIndex]);
      });
      print("roles: " + roles.toString());
      await EventCommand().sendPlayerEventRequests(
          playerChosen, [widget.mainEvent], roles, type);
    });
  }

  Future<void> sendPlayersTeamRequest(Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList) async {
    print("sendPlayersTeamRequest");
    print("userObjectDetails: " + widget.team.toString());
    print("indexes: " + indexes.toString());
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());
    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic playerChosen = primaryList[mainIndex];
      dynamic roles = [];
      secondaryIndexes.forEach((secondaryIndex, blankValue) async {
        roles.add(secondaryList[secondaryIndex]);
        print("roles: " + roles.toString());

        await TeamCommand().sendPlayerTeamRequests(
            playerChosen, [widget.team], roles);
      });
    });
  }

  //send organizers event request
  Future<void> sendEventRequest(dynamic eventObject, Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList) async {
    print("sendEventRequest");
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());
    String requestType = getRequestType(eventObject);

    indexes.forEach((mainIndex, secondaryIndexesThatIsNull) async {
      dynamic role = primaryList[mainIndex];
      bool isMyObject = false;
      if (widget.isMine) {
        if (widget.mainEvent != null) {
          //add yourself to event
          setState(() {
            widget.players.add(userObject);
          });
        } else {
          //add yourself to team
          setState(() {
            widget.team['players'].add(userObject);
          });
        }
      } else {
        await EventCommand()
            .sendOrganizerEventRequest(eventObject, role, requestType);
      }
    });
  }

  void goToPlayer(dynamic player) {
    print("goToPlayer");
    print("player: " + player.toString());
    dynamic profileDetails = {
      "user": player,
      "isMine": false,
    };
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Profile(profileDetails: profileDetails),
      ),
    );
  }

  Container sendOrganizerPlayerEventRequest(BuildContext context) {
    return Container(
      height: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: GestureDetector(
            onTap: () async {
              List<dynamic> primaryList = requestUserTypes;
              List<dynamic> secondaryList = [];
              Map<int, dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                      details: {"title": "Send Organizer Player Request"},
                      items: primaryList,
                      singleSelect: false,
                      secondaryItems: secondaryList,
                      goToFunctions: [goToPlayer]);
                },
              );
              if (result.isNotEmpty) {
                print('Selected items: $result');
                // await requestTypeSelected(selectedRequestTypeIndexes);
                await sendEventRequest(widget.mainEvent,
                    result, primaryList, secondaryList);
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.green,
              child: Center(child: Text("Send Player Request")),
            )),
      ),
    );
  }

  Container sendPlayersRequestWidget() {    
    setupPlayerList();
    print("playersList: " + playerList.length.toString());
    // if(userObjectDetails['isMine']){
    return Container(
        child: GestureDetector(
            onTap: () async {
              List<dynamic> primaryList = playerList;
              List<dynamic> secondaryList = requestUserTypes;
              Map<int, dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                      details: {"title": "Send Players Request"},
                      items: primaryList,
                      singleSelect: false,
                      secondaryItems: secondaryList,
                      goToFunctions: [goToPlayer]);
                },
              );
              if (result.isNotEmpty) {
                print("result: " + result.toString());
                if (widget.mainEvent != null) {
                  sendPlayersEventRequest(result, primaryList, secondaryList);
                } else {
                  sendPlayersTeamRequest(result, primaryList, secondaryList);
                }
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.blue,
              child: Center(child: Text("Send Players Request")),
            )));

    // }
    // else{
    //   return sendOrganizerPlayerEventRequest(context);

    // }
  }

  void loadInitialData() {
    setupPlayerList();
  }

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return sendPlayersRequestWidget();
  }
}
