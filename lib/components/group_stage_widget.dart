import 'package:flutter/material.dart';

import '../commands/tournament_command.dart';
import 'Dialogues/animated_dialogu.dart';

class GroupStageWidget extends StatefulWidget {
  final Map<String, dynamic>? groupData;
  final List<dynamic>? teams;

  const GroupStageWidget({this.groupData, this.teams});

  @override
  _GroupStageWidgetState createState() => _GroupStageWidgetState();
}

class _GroupStageWidgetState extends State<GroupStageWidget> {
  List<dynamic> groupData = [];

  void loadInitialData() {
    print("loadInitialData: "+ widget.groupData.toString());
    if (widget.groupData != null) {
      setState(() {
        groupData = widget.groupData!['groups']['data'];
      });
    }
  }

  void addTeamToTeamOrder(dynamic indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList, dynamic teamOrder) {
    print("addTeamToGroupStage: ");    
    print("indexes: " + indexes.toString());
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());
    print("teamOrder: " + teamOrder.toString());

    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic teamChosen = primaryList[mainIndex];
      dynamic teamOrderInput = {
        'points': 0,
        'team_id': teamChosen['_id'],
        '_id':  teamOrder['_id'],
        
      };
      print("teamOrderInput: " + teamOrderInput.toString());
      dynamic addTeamTeamOrderResp =
          await TournamentCommand().addTeamToTeamOrder(teamOrderInput);
      print("check if addTeamToGroup success");
      print("addTeamToGroupResp: " + addTeamTeamOrderResp.toString());
      if (addTeamTeamOrderResp['success']) {
        dynamic updatedTeamOrder = addTeamTeamOrderResp['data'];
        int index = 0;
        widget.groupData!['groups']['data'].forEach((group) {
          print("in forEach");
          if (group['_id'] == updatedTeamOrder['group']['_id'])
            print("in first group if");
            int teamOrderIndex = 0;
          widget.groupData!['groups']['data'][index]['teamOrders']['data'].forEach((teamOrderItem) {
            print("iterate over teamOrders: " + teamOrderItem.toString());
            if(teamOrderItem['_id'] == updatedTeamOrder['_id']){
              print("in if, update group TeamOrder");
              setState(() {
                widget.groupData!['groups']['data'][index]['teamOrders']['data'][teamOrderIndex] = updatedTeamOrder;

              });
            }
            teamOrderIndex += 1;
          });         
          index += 1;
        });
      }
    });
  }

  void removeTeamFromTeamOrder(dynamic teamOrder ,dynamic team) async{
    print("removeTeamFromGroupStage: " + teamOrder.toString());
    print("teamOrder: " + teamOrder.toString());

    dynamic teamOrderInput = {      
      '_id': teamOrder['_id'],      
    };

    dynamic removeTeamFromTeamOrderResp = await TournamentCommand().removeTeamFromTeamOrder(teamOrderInput);
    print("removeTeamFromTeamOrderResp: "+ removeTeamFromTeamOrderResp.toString());
    if(removeTeamFromTeamOrderResp['success']){
      dynamic updateTeamOrder = removeTeamFromTeamOrderResp['data'];
      int index = 0;
      widget.groupData!['groups']['data'].forEach((group) {
        print("in forEach");
        if (group['_id'] == updateTeamOrder['group']['_id'])
          print(
              "update widget.groupData!['groups']['data'][index] with updatedGroup");
          int teamOrderIndex = 0;
          widget.groupData!['groups']['data'][index]['teamOrders']['data'].forEach((teamOrder) {
            if(widget.groupData!['groups']['data'][index]['teamOrders']['data'][teamOrderIndex]['_id'] == updateTeamOrder['_id']){
              setState(() {
                widget.groupData!['groups']['data'][index]['teamOrders']['data'][teamOrderIndex] = updateTeamOrder;

              });
            } 
            teamOrderIndex += 1;             
          });
        index += 1;
      });
    }


    

    
  }

  @override
  void initState() {
    super.initState();
    print("initState GroupStageWidget");
    loadInitialData();
  }

@override
Widget build(BuildContext context) {
  print("build() widget.groupData: " + widget.groupData.toString());
  if (widget.groupData == null) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'Create a Group Stage!',
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 20.0),
            ElevatedButton(
              child: Icon(Icons.add_circle_outline, size: 100.0),
              onPressed: () {
                print('Add a group stage');
              },
            ),
          ],
        ),
      ),
    );
  }

  return Scaffold(
    appBar: AppBar(
      title: Text('Group Stage'),
      actions: [
        IconButton(
          icon: Icon(Icons.view_list),
          onPressed: () {
            print('View Bracket');
          },
        ),
      ],
    ),
    body: SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: groupData.map<Widget>((group) {
          int numberOfTeamsPerGroup = widget.groupData!['numberOfTeams'] ~/ 
            widget.groupData!['groups']['data'].length as int;

          print("group: " + group.toString());
          print("numberOfTeamsPerGroup: " + numberOfTeamsPerGroup.toString());

          List<Widget> teamWidgets = group['teamOrders']['data'].map<Widget>((teamOrder) {
            if (teamOrder['team'] == null) {
              return ListTile(
                leading: Icon(Icons.add),
                title: Text('No team'),
                onTap: () async {
                  print('Add Team tapped');
                  List<dynamic> primaryList = widget.teams!;
                  List<dynamic> secondaryList = [];
                  Map<int, dynamic> result = await showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AnimatedDialog(
                        items: primaryList,
                        singleSelect: false,
                        secondaryItems: secondaryList
                      );
                    },
                  );
                  if (result.isNotEmpty) {
                    print('Selected items: $result');
                    addTeamToTeamOrder(result, primaryList, secondaryList, teamOrder);
                  }
                },
              );
            } else {
              return GestureDetector(
                onTap: () {
                  print('Team clicked');
                },
                child: ListTile(
                  leading: Icon(Icons.sports_soccer),
                  title: Text(teamOrder['team']['name']),
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () {
                      print('Delete icon for team ${teamOrder['team']['name']} pressed');
                      removeTeamFromTeamOrder(teamOrder, teamOrder['team']);
                    },
                  ),
                ),
              );
            }
          }).toList();

          return Container(
            width: 200,
            padding: EdgeInsets.all(8.0),
            child: Column(
              children: [
                Text(
                  'Group ${group['groupNumber']}',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 8.0),
                Column(
                  children: teamWidgets,
                ),
                SizedBox(height: 16.0),
              ],
            ),
          );
        }).toList(),
      ),
    )
  );
}


}
