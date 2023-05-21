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
      if (addTeamToGroupResp['status'] == 'success') {
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

  void removeTeamFromGroupStage(dynamic group, dynamic team) {
    print("removeTeamFromGroupStage: " + group.toString());
    print("group: " + group.toString());

    dynamic groupStageInput = {
      'order': group['groupNumber'],
      'team_id': team['_id'],
      '_id': widget.groupData?['_id'],
      'group_id': group['_id'],
    };
    // dynamic addTeamToGroupStageResp = await TournamentCommand().removeTeamFromGroupStage(groupStageInput);

    // if (addTeamToGroupStageResp['status'] == 'success') {
    //   print("addTeamToGroupStageResp: " + addTeamToGroupStageResp.toString());
    //   setState(() {
    //     group['teams']['data'].add(teamChosen);
    //   });
    // }
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
              SizedBox(height: 20.0), // Add some spacing
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
            return Container(
              width: 200, // Set the width of each group container
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
                    children: group['teamOrders']['data'].length > 0
                        ? group['teamOrders']['data'].map<Widget>((teamOrder) {
                            return GestureDetector(
                              onTap: () {
                                print('Team clicked');
                              },
                              child: ListTile(
                                leading: Icon(
                                    Icons.sports_soccer), // Placeholder icon
                                title: Text(teamOrder['team']['name']),
                              ),
                            );
                          }).toList()
                        : teamPlaceholders.map<Widget>((placeholder) {
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
                                        secondaryItems: secondaryList);
                                  },
                                );
                                if (result.isNotEmpty) {
                                  print('Selected items: $result');
                                  addTeamToGroupStage(group, result,
                                      primaryList, secondaryList);

                                  // userObjectDetails['mainEvent'], result, primaryList, secondaryList);
                                }
                              },
                            );
                          }).toList(),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}
