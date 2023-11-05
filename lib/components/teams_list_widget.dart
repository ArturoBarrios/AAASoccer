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
  List? teamCards;
  // final void Function(dynamic) addTeam; // Optional function input parameter

  TeamsListWidget({
    required this.user,
    required this.mainEvent,
    this.teams,
    this.teamUserParticipants,
    this.teamCards,
  }); // Include required modifier

  @override
  _TeamsListWidgetState createState() => _TeamsListWidgetState();
}

class _TeamsListWidgetState extends State<TeamsListWidget> {
  bool iterateOverTeams = true;
  late ScrollController _selectTeamController = ScrollController();

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
    double screenHeight = MediaQuery.of(context).size.height;
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
          (widget.teamCards!.isEmpty
              ? Center(
                  child: Text('No Teams'),
                )
              : SizedBox(
                  height: screenHeight *
                      .2, // Set a fixed height for the list. Adjust as necessary for your ListTile height.
                  child: ListView.builder(
                    scrollDirection:
                        Axis.horizontal, // Set the direction to horizontal
                    itemCount: widget
                        .teamCards!.length, // The number of items in the list
                    itemBuilder: (context, index) {
                      return IntrinsicWidth(
                          // This will size the width based on the child's intrinsic size.
                          child: widget.teamCards![index]);
                    },
                  ),
                )),
        ],
      ),
    );
  }
}
