import 'package:flutter/material.dart';
import 'package:soccermadeeasy/commands/base_command.dart';
import '../commands/event_command.dart';
import '../commands/user_command.dart';
import '../views/team/view.dart';
import 'Loading/loading_screen.dart';

class TeamsListWidget extends StatefulWidget {
  final dynamic user;
  final dynamic mainEvent;
  List? teams;
  List? teamUserParticipants;
  // final void Function(dynamic) addTeam; // Optional function input parameter

  TeamsListWidget(
      {required this.user,
      required this.mainEvent,
      this.teams,
      this.teamUserParticipants}); // Include required modifier

  @override
  _TeamsListWidgetState createState() => _TeamsListWidgetState();
}

class _TeamsListWidgetState extends State<TeamsListWidget> {
  bool iterateOverTeams = true;
  bool isLoading = true;

  Future<void> removeUserFromTeam(dynamic team) async {
    print("removeUserFromTeam");
    print("team: " + team.toString());
    dynamic removeUserFromTeamInput = {
      'team_id': team['_id'],
      'user_id': widget.user['_id'],
    };
    dynamic removeTeamFromEventResp =
        await EventCommand().removeTeamFromEvent(removeUserFromTeamInput);
    print("removeTeamFromEventResp: " + removeTeamFromEventResp.toString());
    if (removeTeamFromEventResp['success']) {
      setState(() {
        widget.teams!.removeWhere((teamItem) => teamItem['_id'] == team['_id']);
      });
    }
  }

  Future<void> removeTeamFromEvent(dynamic team) async {
    print("removeTeamFromEvent");
    print("team: " + team.toString());
    dynamic removeTeamFromEventInput = {
      'team_id': team['_id'],
      'event_id': widget.mainEvent['_id'],
    };
    dynamic removeTeamFromEventResp =
        await EventCommand().removeTeamFromEvent(removeTeamFromEventInput);
    print("removeTeamFromEventResp: " + removeTeamFromEventResp.toString());
    if (removeTeamFromEventResp['success']) {
      setState(() {
        widget.teams!.removeWhere((teamItem) => teamItem['_id'] == team['_id']);
      });
    }
  }

  void loadInitialData() {
    print("loadInitialData");
    print("widget.teamUserParticipants: " +
        widget.teamUserParticipants.toString());
    if (widget.teamUserParticipants!.isNotEmpty) {
      widget.teams = widget.teamUserParticipants!
          .where((participantMap) => participantMap.containsKey('team'))
          .map((participantMap) => participantMap['team'])
          .toList();
    }
    print("widget.teams: " + widget.teams.toString());

    setState(() {
      isLoading = false;
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

  @override
  initState() {
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        children: <Widget>[
          Text(
            'Team List',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          isLoading
              ? LoadingScreen(
                  currentDotColor: Colors.white,
                  defaultDotColor: Colors.black,
                  numDots: 10,
                )
              : (widget.teams!.isEmpty
                  ? Center(
                      child: Text('No Teams'),
                    )
                  : Column(
                      children: List<Widget>.generate(widget.teams!.length, (index) {
                        String teamName = widget.teams![index]['name'] ?? '';

                        return InkWell(
                          onTap: () {
                            print('Team pressed');
                            goToTeam(widget.teams![index]);
                            // Implement your logic here when ListTile is clicked.
                          },
                          child: ListTile(
                            title: Text(teamName),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              //can add multiple buttons here
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    removeTeamFromEvent(widget.teams![index]);
                                  },
                                ),
                                // Check if addTeam function exists before displaying the icon button
                                // if (widget.addTeam != null)
                                //   IconButton(
                                //     icon: Icon(Icons.add),
                                //     onPressed: () {
                                //       widget.addTeam(teams[index]);
                                //     },
                                //   ),
                              ],
                            ),
                          ),
                        );
                      }),
                    )),
        ],
      ),
    );
  }
}
