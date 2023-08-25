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
  SendPlayersRequestWidget({Key? key, required this.userObjectDetails})
      : super(key: key);

  final dynamic userObjectDetails;

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

    String type = getRequestType(widget.userObjectDetails['mainEvent']);

    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic playerChosen = primaryList[mainIndex];
      dynamic roles = [];
      secondaryIndexes.forEach((secondaryIndex, blankValue) {
        roles.add(secondaryList[secondaryIndex]);
      });
      print("roles: " + roles.toString());
      await EventCommand().sendPlayerEventRequests(
          playerChosen, [widget.userObjectDetails['mainEvent']], roles, type);
    });
  }

  Future<void> sendPlayersTeamRequest(Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList) async {
    print("sendPlayersTeamRequest");
    print("userObjectDetails: " + widget.userObjectDetails['team'].toString());
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
            playerChosen, [widget.userObjectDetails['team']], roles);
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
      if (widget.userObjectDetails['isMine']) {
        if (widget.userObjectDetails['mainEvent'] != null) {
          //add yourself to event
          setState(() {
            widget.userObjectDetails['players'].add(userObject);
          });
        } else {
          //add yourself to team
          setState(() {
            widget.userObjectDetails['team']['players'].add(userObject);
          });
        }
      } else {
        await EventCommand()
            .sendOrganizerEventRequest(eventObject, role, requestType);
      }
    });
    // for (int i = 0; i < selectedRequestTypeObjects.length; i++) {
    //   await EventCommand().sendOrganizerEventRequest(
    //       eventObject, selectedRequestTypeObjects[i], requestType);
    // }
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
                await sendEventRequest(widget.userObjectDetails['mainEvent'],
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

  Container sendPlayersRequestWidget(dynamic userObjectDetails) {
    print("sendPlayersRequestWidget: " + userObjectDetails.toString());
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
                if (userObjectDetails['mainEvent'] != null) {
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
    return sendPlayersRequestWidget(widget.userObjectDetails);
  }
}
