import 'package:flutter/material.dart';

import '../commands/event_command.dart';

class EventsListWidget extends StatefulWidget {
  final Map<String, dynamic> teamsDetails;

  EventsListWidget({required this.teamsDetails});
  
  @override
  _EventsListWidgetState createState() => _EventsListWidgetState();

}

class _EventsListWidgetState extends State<EventsListWidget> {

   Future<void> removeTeamFromEvent(dynamic team)async{
    print("removeTeamFromEvent");
    print("team: " + team.toString());
    dynamic removeTeamFromEventInput = {
      'team_id': team['_id'],
      'event_id': widget.teamsDetails['mainEvent']['_id'],
    };
    dynamic removeTeamFromEventResp = await EventCommand().removeTeamFromEvent(removeTeamFromEventInput);
    print("removeTeamFromEventResp: " + removeTeamFromEventResp.toString());
    if(removeTeamFromEventResp['success']){
      widget.teamsDetails['teams'].forEach((teamItem) {
        if(teamItem['_id'] == team['_id']){
          setState(() {
            widget.teamsDetails['teams'].remove(teamItem);
          });
        }
      });

    }
    
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> teams = widget.teamsDetails['teams'] ?? [];

   
  
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

                    return ListTile(
                      title: Text(teamName),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[                          
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              removeTeamFromEvent(teams[index]);
                            },
                          ),
                        ],
                      ),
                    );
                  }),
                ),
        ],
      ),
    );
  }
}
