import 'dart:ui';

import 'package:flutter/material.dart';

import '../commands/event_command.dart';
import '../commands/team_command.dart';
import 'Dialogues/animated_dialogu.dart';

// // // // // // // // // // // // // // //
class SendTeamsRequestWidget extends StatefulWidget {

  SendTeamsRequestWidget({Key? key, required this.userObjectDetails})
      : super(key: key);

  final dynamic userObjectDetails;

  @override
  _SendTeamsRequestWidgetState createState() => _SendTeamsRequestWidgetState();

  
}

class _SendTeamsRequestWidgetState extends State<SendTeamsRequestWidget> {
  dynamic teamList = [];

  Future<void> sendTeamsEventRequest(dynamic event, Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList, dynamic userObjectDetails) async {
    print("sendTeamsEventRequest");
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());
    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic teamChosen = primaryList[mainIndex];
      bool isMyTeam = false;
      isMyTeam = userObjectDetails['roles'].contains("ORGANIZER");
      //check if player is a team and organizer, if so, add to list
      if(event[userObjectDetails['isMine']] && isMyTeam){
        print("isMyTeam");
        teamList.remove(teamChosen);
        await EventCommand().addTeamToEvent(event, teamChosen);
        userObjectDetails['teams'].add(teamChosen);
      }
      else{
        await TeamCommand().sendTeamEventRequest(teamChosen, event);

      }
    });
  }

  Container sendEventRequestForMyTeamWidget(
      BuildContext context, dynamic userObjectDetails) {
    return Container(
        child: GestureDetector(
            onTap: () async {
              print("myTeamList before: " + myTeamList.toString());

              List<dynamic> myProcessedTeamList = myTeamList
                  .where((item1) => !userObjectDetails['teams']
                      .any((item2) => item2["_id"] == item1["_id"]))
                  .map((item) => item['team'])
                  .toList();

              //  List<String> myTeamList = ['Item 1', 'Item 2', 'Item 3', 'Item 4'];
              Map<int, dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                      items: myProcessedTeamList,
                      singleSelect: false,
                      secondaryItems: []);
                },
              );
              if (result.isNotEmpty) {
                print('Selected items: $result');
                teamsSelected(result, myProcessedTeamList);
                sendEventRequestForMyTeam(userObjectDetails);
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.green,
              child: Center(child: Text("Send My Teams Request")),
            )));
  }


  Container sendTeamsRequestWidget(
      BuildContext context, dynamic userObjectDetails) {
    print("sendTeamsRequestWidget: " + userObjectDetails.toString());
    // setupTeamList();
        if(userObjectDetails['isMine']){
          return Container(
              child: GestureDetector(
                  onTap: () async {
                    List<dynamic> primaryList = [];
                    List<dynamic> secondaryList = [];
                    List<dynamic> processedTeamList = teamList
                        .where((item1) => !userObjectDetails['teams']
                            .any((item2) => item2["_id"] == item1["_id"]))
                        .map((item) => item['name'])
                        .toList();
                    primaryList = processedTeamList;
                    //original list (just look at commented code below)
                    // teamList.where((item1) => !userObjectDetails['teams'].any((item2) => item2["_id"] == item1["_id"])).toList();
                    Map<int, dynamic> result = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AnimatedDialog(
                            items: primaryList,
                            singleSelect: false,
                            secondaryItems: secondaryList);
                      },
                    );
                    if (result.isNotEmpty) {
                      print('Selected items: $result');
                      sendTeamsEventRequest(userObjectDetails['mainEvent'], result,
                          primaryList, secondaryList, userObjectDetails);
                    }
                  },
                  child: Container(
                    width: 200,
                    height: 50,
                    color: Colors.blue,
                    child: Center(child: Text("Send Teams Request")),
                  )));
        }
        else{
          return sendEventRequestForMyTeamWidget(context, userObjectDetails);                
        }
  }

  @override
  Widget build(BuildContext context) {
    return sendTeamsRequestWidget(context, widget.game);
}
}
