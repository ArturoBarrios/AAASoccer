import 'package:flutter/material.dart';
import 'package:soccermadeeasy/commands/base_command.dart';
import '../commands/event_command.dart';
import '../views/team/view.dart';
import 'Loading/loading_screen.dart';

class TeamsListWidget extends StatefulWidget {
  final Map<String, dynamic> userObjectDetails;  
  // final void Function(dynamic) addTeam; // Optional function input parameter

  TeamsListWidget({required this.userObjectDetails}); // Include required modifier
  
  @override
  _TeamsListWidgetState createState() => _TeamsListWidgetState();
}

class _TeamsListWidgetState extends State<TeamsListWidget> {
  List<dynamic> teams = [];
  bool _isLoading = true;

  Future<void> removeTeamFromEvent(dynamic team) async {
    print("removeTeamFromEvent");
    print("team: " + team.toString());
    dynamic removeTeamFromEventInput = {
      'team_id': team['_id'],
      'event_id': widget.userObjectDetails['mainEvent']['_id'],
    };
    dynamic removeTeamFromEventResp =
        await EventCommand().removeTeamFromEvent(removeTeamFromEventInput);
    print("removeTeamFromEventResp: " + removeTeamFromEventResp.toString());
    if (removeTeamFromEventResp['success']) {
      print("userObjectDetailsCopy['teams']: "+ widget.userObjectDetails['teams'].toString());
      // dynamic userObjectDetailsCopy  = Map.from(widget.userObjectDetails);
      // userObjectDetailsCopy['teams'].forEach((teamItem) {
      //   if (teamItem['_id'] == team['_id']) {
          setState(() {
            widget.userObjectDetails['teams'].removeWhere((teamItem) => teamItem['_id'] == team['_id']);
          });
      //   }
      // });
      BaseCommand().updateUserEventDetailsModel(widget.userObjectDetails);
    }
  }

  void loadInitialData(){
    print("loadInitialData");
    if(widget.userObjectDetails['teams'] != null){
      teams = widget.userObjectDetails['teams'];
    }
    else{
      List<dynamic> teamUserParticipants = widget.userObjectDetails['teamUserParticipants'];
      teamUserParticipants.forEach((teamUserParticipant) {
        teams.add(teamUserParticipant['team']);
      });

    }

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
      teams.isEmpty
          ? Center(
              child: Text('No Teams'),
            )
          : Column(
              children: List<Widget>.generate(teams.length, (index) {
                String teamName = teams[index]['name'] ?? '';

                return InkWell(
                  onTap: () {
                    print('Team pressed');
                    goToTeam(teams[index]);
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
                            removeTeamFromEvent(teams[index]);
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
            ),
    ],
  ),
);
  }
}
