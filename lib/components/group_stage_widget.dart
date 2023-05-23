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

  void addTeamToGroupStage(dynamic group, dynamic indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList) {
    print("addTeamToGroupStage: " + group.toString());
    print("group: " + group.toString());
    print("indexes: " + indexes.toString());
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());

    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic teamChosen = primaryList[mainIndex];
      dynamic groupStageInput = {
        'points': 0,
        'team_id': teamChosen['_id'],
        '_id': group['_id'],
      };
      dynamic addTeamToGroupResp =
          await TournamentCommand().addTeamToGroup(groupStageInput);
      print("check if addTeamToGroup success");
      print("addTeamToGroupResp: " + addTeamToGroupResp.toString());
      if (addTeamToGroupResp['success']) {
        dynamic updatedGroup = addTeamToGroupResp['data'];
        int index = 0;
        widget.groupData!['groups']['data'].forEach((group) {
          print("in forEach");
          if (group['_id'] == updatedGroup['_id'])
            print(
                "update widget.groupData!['groups']['data'][index] with updatedGroup");
          setState(() {
            widget.groupData!['groups']['data'][index] = updatedGroup;
          });
        });
        index += 1;
      }
    });
  }

  void removeTeamFromTeamOrder(dynamic teamOrder ,dynamic team, dynamic groupToUpdate) async{
    print("removeTeamFromGroupStage: " + teamOrder.toString());
    print("teamOrder: " + teamOrder.toString());

    dynamic teamOrderInput = {      
      '_id': teamOrder['_id'],      
    };

    dynamic removeTeamFromTeamOrderResp = await TournamentCommand().removeTeamFromTeamOrder(teamOrderInput);
    print("removeTeamFromTeamOrderResp: "+ removeTeamFromTeamOrderResp.toString());
    if(removeTeamFromTeamOrderResp['success']){
      dynamic deleteTeamOrder = removeTeamFromTeamOrderResp['data'];
      int index = 0;
      widget.groupData!['groups']['data'].forEach((group) {
        print("in forEach");
        if (group['_id'] == groupToUpdate['_id'])
          print(
              "update widget.groupData!['groups']['data'][index] with updatedGroup");
          int teamOrderIndex = 0;
          widget.groupData!['groups']['data'][index]['teamOrders']['data'].forEach((teamOrder) {
            if(teamOrder['_id'] == deleteTeamOrder['_id']){
              setState(() {
                widget.groupData!['groups']['data'][index]['teamOrders']['data'].removeAt(teamOrderIndex);

              });
            } 
            teamOrderIndex += 1;             
          });
      });
      index += 1;
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
          var teamPlaceholders = List.filled(
              numberOfTeamsPerGroup - group['teamOrders']['data'].length as int, 
              'No team yet');

          print("group: " + group.toString());
          print("numberOfTeamsPerGroup: " + numberOfTeamsPerGroup.toString());
          print("teamPlaceholders: " + teamPlaceholders.toString());          
          List<Widget> teamWidgets = group['teamOrders']['data'].map<Widget>((teamOrder) {            
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
                    removeTeamFromTeamOrder(teamOrder, teamOrder['team'], group);
                  },
                ),
              ),
            );
          }).toList();

          List<Widget> placeholderWidgets = teamPlaceholders.map<Widget>((placeholder) {
            return ListTile(
              leading: Icon(Icons.add),
              title: Text(placeholder),
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
                  addTeamToGroupStage(group, result, primaryList, secondaryList);
                }
              },
            );
          }).toList();

          List<Widget> combinedWidgets = []..addAll(teamWidgets)..addAll(placeholderWidgets);

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
                  children: combinedWidgets,
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
