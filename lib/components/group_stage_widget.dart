import 'package:flutter/material.dart';

import '../commands/tournament_command.dart';

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
    if (widget.groupData != null) {
      setState(() {
        groupData = widget.groupData!['groups']['data'];
      });
    }
  }

  void addTeamToGroupStage(groupStageNumber){
    print('Add team to group stage');
    print("groupStageNumber: " + groupStageNumber.toString());
    dynamic groupStageInput = {
      'groupStageNumber': groupStageNumber,
      'team_id': ''
    };

    TournamentCommand().addTeamToGroupStage(groupStageInput);


  }

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
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
            int numberOfTeamsPerGroup = widget.groupData!['numberOfTeams']~/widget.groupData!['groups']['data'].length as int;
            var teamPlaceholders = List.filled( numberOfTeamsPerGroup - group['teams']['data'].length as int , 'No team yet');
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
                    children: group['teams']['data'].length > 0
                        ? group['teams']['data'].map<Widget>((team) {
                            return GestureDetector(
                              onTap: () {
                                print('Team clicked');
                              },
                              child: ListTile(
                                leading: Icon(Icons.sports_soccer), // Placeholder icon
                                title: Text(team['teamName']),
                              ),
                            );
                          }).toList()
                        : teamPlaceholders.map<Widget>((placeholder) {
                            return ListTile(
                              leading: Icon(Icons.add),
                              title: Text(placeholder),
                              onTap: () {
                                print('Add Team');
                                addTeamToGroupStage(group['groupNumber']);
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
