import 'dart:ui';

import 'package:flutter/material.dart';

import '../commands/event_command.dart';
import '../commands/team_command.dart';
import '../commands/user_command.dart';
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
  List<dynamic> teamsNearMeList = [];
  List<dynamic> myTeamList = [];
  List<dynamic> objectTeamList = [];
  List<dynamic> teamsSelectedList = [];

  void setupMyTeams() {
    print("setupMyTeams");
    List<dynamic> myTeamsResp = UserCommand().getAppModelMyTeams();
    myTeamList = myTeamsResp;
    print("myTeamList: " + myTeamList.toString());
    
  }

  void setupTeams(){
    print("setupTeams");
    List<dynamic> appModelTeams = TeamCommand().getAppModelTeamsNearMe();
    print("appModelTeams: " + appModelTeams.toString());
    teamsNearMeList = appModelTeams;
    //sort by my teams first
    teamsNearMeList.sort((a, b) => (myTeamList.contains(b) ? 1 : 0).compareTo(myTeamList.contains(a) ? 1 : 0));
    print("teamsNearMeList: " + teamsNearMeList.toString());
  }

  void setupObjectTeamList(){
    print("setupObjectTeamList");
    objectTeamList = widget.userObjectDetails['teams'];
  }

  sendEventRequestForMyTeam(Map<int, dynamic> indexes, 
      List<dynamic> primaryList, List<dynamic> secondaryList) {    
    print("sendEventRequestForMyTeam: " + teamsSelectedList.toString());
    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic teamChosen = primaryList[mainIndex];      
      TeamCommand().sendEventRequestForMyTeam(
          widget.userObjectDetails['mainEvent'], teamChosen);

    });
    
  }
  
  Future<void> sendTeamsEventRequest(Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList) async {
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
        teamsNearMeList.remove(teamChosen);
        await EventCommand().addTeamToEvent(widget.userObjectDetails['mainEvent'], teamChosen);
        print("team added to event");
        setState(() {
          widget.userObjectDetails['teams'].add(teamChosen);          
        });
      }
      else{
        await TeamCommand().sendTeamEventRequest(teamChosen, widget.userObjectDetails['mainEvent']);
      }
    });
  }

  Container sendEventRequestForMyTeamWidget(
      BuildContext context, dynamic userObjectDetails) {
    return Container(
        child: GestureDetector(
            onTap: () async {
              print("myTeamList before: " + myTeamList.toString());
              List<dynamic> primaryList = [];
              List<dynamic> secondaryList = [];
              List<dynamic> myProcessedTeamList = myTeamList
                  .where((item1) => !userObjectDetails['teams']
                      .any((item2) => item2["_id"] == item1["_id"]))
                  .map((item) => item)
                  .toList();
              primaryList = myProcessedTeamList;

              
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
    // setupTeamList();
        if(userObjectDetails['isMine']){
          return Container(
              child: GestureDetector(
                  onTap: () async {
                    List<dynamic> primaryList = [];
                    List<dynamic> secondaryList = [];
                    print("teamsNearMeList: "+ teamsNearMeList.toString());
                    List<dynamic> processedTeamList = teamsNearMeList
                        .where((item1) => !userObjectDetails['teams']
                            .any((item2) => item2["_id"] == item1["_id"]))
                        .map((item) => item)
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
                      sendTeamsEventRequest(result,
                          primaryList, secondaryList);
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
    setupMyTeams();
    setupTeams();
  }

  @override
  Widget build(BuildContext context) {
    return sendTeamsRequestWidget(context, widget.userObjectDetails);
}
}
