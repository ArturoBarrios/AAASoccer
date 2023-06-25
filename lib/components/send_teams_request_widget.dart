import 'dart:ui';

import 'package:flutter/material.dart';

import '../commands/event_command.dart';
import '../commands/team_command.dart';
import '../commands/user_command.dart';
import '../views/team/view.dart';
import 'Dialogues/animated_dialogu.dart';
import 'Mixins/event_mixin.dart';

// // // // // // // // // // // // // // //
class SendTeamsRequestWidget extends StatefulWidget with EventMixin {

   SendTeamsRequestWidget({Key? key, required this.userObjectDetails, required this.addTeamCallback})
      : super(key: key);

  final dynamic userObjectDetails;
  final Function addTeamCallback;

  @override
  _SendTeamsRequestWidgetState createState() => _SendTeamsRequestWidgetState();

  
}

class _SendTeamsRequestWidgetState extends State<SendTeamsRequestWidget> {  

  sendEventRequestForMyTeam(Map<int, dynamic> indexes, 
      List<dynamic> primaryList, List<dynamic> secondaryList) {        
    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic teamChosen = primaryList[mainIndex];      
      TeamCommand().sendEventRequestForMyTeam(
          widget.userObjectDetails['mainEvent'], teamChosen);
          
    });
    
  }
  
  Future<void> sendTeamsEventRequest(Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList, Function addTeamCallback) async {
    print("sendTeamsEventRequest");
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());
    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic teamChosen = primaryList[mainIndex];
      bool isMyTeam = false;
      isMyTeam = widget.userObjectDetails['roles'].contains("ORGANIZER");
      print("isMyTeam: " + isMyTeam.toString());
      //check if player is a team and organizer, if so, add to list
      if(widget.userObjectDetails['isMine'] && isMyTeam){
        print("isMyTeam");
        // teamsNearMeList.remove(teamChosen);
        await EventCommand().addTeamToEvent(widget.userObjectDetails['mainEvent'], teamChosen);
        print("team added to event");
        setState(() {
          // widget.userObjectDetails['teams'].add(teamChosen);    
          addTeamCallback(teamChosen);                
        });

      }
      else{
        await TeamCommand().sendTeamEventRequest(teamChosen, widget.userObjectDetails['mainEvent']);
      }
    });
  }

  void goToTeam(dynamic team) {
    print("goToTeam");
    print("team: " + team.toString());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamView(teamObject: team),
      ),
    );
  }


  Container sendEventRequestForMyTeamWidget(
      BuildContext context, dynamic userObjectDetails) {
        print("sendEventRequestForMyTeamWidget");
        widget.setupMyTeams();
    return Container(
        child: GestureDetector(
            onTap: () async {
              // print("myTeamList before: " + myTeamList.toString());
              widget.setupMyTeams();
              List<dynamic> primaryList = [];
              List<dynamic> secondaryList = [];
              List<dynamic> myProcessedTeamList = widget.myTeamList
                  .where((item1) => !userObjectDetails['teams']
                      .any((item2) => item2["_id"] == item1["_id"]))
                  .map((item) => item['team'])
                  .toList();
              primaryList = myProcessedTeamList;
              print("primaryList: " + primaryList.toString());

              
              Map<int, dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                      details: {"title": "Send Event Request For My Team"},
                      items: primaryList,
                      singleSelect: false,
                      secondaryItems: secondaryList,
                      goToFunctions: [goToTeam]);
                },
              );
              if (result.isNotEmpty) {
                print('Selected items: $result');
                // teamsSelected(result, myProcessedTeamList);
                sendEventRequestForMyTeam(result, primaryList, secondaryList);
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.green,
              child: Center(child: Text("Send My Teams Request")),
            )));
  }

  //send request to all teams near me(excluding)
  Container sendTeamsRequestWidget(
      BuildContext context, dynamic userObjectDetails) {
    print("sendTeamsRequestWidgett: " + userObjectDetails.toString());
    widget.setupTeamList();
    
        if(userObjectDetails['isMine']){
          return Container(
              child: GestureDetector(
                  onTap: () async {
                    List<dynamic> primaryList = [];
                    List<dynamic> secondaryList = [];
                    print("teamList: "+ widget.teamList.toString());
                    List<dynamic> processedTeamList = widget.teamList
                        .where((item1) => !userObjectDetails['teams']
                            .any((item2) => item2["_id"] == item1["_id"]))
                        .map((item) => item)
                        .toList();
                    primaryList = processedTeamList;
                    print("primaryList: " + primaryList.toString());
                    //original list (just look at commented code below)
                    // teamList.where((item1) => !userObjectDetails['teams'].any((item2) => item2["_id"] == item1["_id"])).toList();
                    Map<int, dynamic> result = await showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AnimatedDialog(
                            details: {"title": "Send Teams Request"},
                            items: primaryList,
                            singleSelect: false,
                            secondaryItems: secondaryList,
                            goToFunctions: [goToTeam]);
                      },
                    );
                    if (result.isNotEmpty) {
                      print('Selected items: $result');
                      sendTeamsEventRequest(result,
                          primaryList, secondaryList, widget.addTeamCallback);
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
  void initState() {
    super.initState();
    // setupMyTeams();
    // setupTeams();
  }

  @override
  Widget build(BuildContext context) {
    return sendTeamsRequestWidget(context, widget.userObjectDetails);
}
}
