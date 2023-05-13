import 'dart:math';

import 'package:flutter/material.dart';

class GroupStageWidget extends StatefulWidget {
  final List<dynamic> groupData;

  const GroupStageWidget({required this.groupData});

  @override
  _GroupStageWidgetState createState() => _GroupStageWidgetState();
}

class _GroupStageWidgetState extends State<GroupStageWidget> {
  List<dynamic> fakeGroupData = [];
  bool _isLoading = true;

  List<dynamic> generateFakeGroupData() {
    Random random = Random();
    List<dynamic> groupData = [];

    for (int i = 0; i < 8; i++) {
      List<dynamic> teams = [];
      for (int j = 0; j < 4; j++) {
        String teamName = 'Team ${String.fromCharCode(65 + random.nextInt(26))}';
        teams.add({'teamName': teamName});
      }
      groupData.add({'groupName': 'Group ${i + 1}', 'teams': teams});
    }

    return groupData;
  }

  void loadInitialData() {
    print("loadInitialData");
    print(widget.groupData);
    fakeGroupData = generateFakeGroupData();
    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    print("initState");
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
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
      body: !_isLoading
          ? SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: List.generate(fakeGroupData.length, (index) {
                  var group = fakeGroupData[index];
                  return Container(
                    width: 200, // Set the width of each group container
                    padding: EdgeInsets.all(8.0),
                    child: Column(
                      children: [
                        Text(
                          'Group ${group['groupName']}',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 8.0),
                        Column(
                          children: List.generate(group['teams'].length, (index) {
                            var team = group['teams'][index];
                            return GestureDetector(
                              onTap: () {
                                print('Team clicked');
                              },
                              child: ListTile(
                                leading: Icon(Icons.sports_soccer), // Placeholder icon
                                title: Text(team['teamName']),
                              ),
                            );
                          }),
                        ),
                        SizedBox(height: 16.0),
                      ],
                    ),
                  );
                }),
              ),
            )
          : Container(child: Text("Loading...")),
    );
  }
}
