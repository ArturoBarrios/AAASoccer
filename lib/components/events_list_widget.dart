import 'package:flutter/material.dart';

import '../commands/event_command.dart';

class EventsListWidget extends StatefulWidget {
  final Map<String, dynamic> objectEventsDetails;

  EventsListWidget({required this.objectEventsDetails});
  
  @override
  _EventsListWidgetState createState() => _EventsListWidgetState();

}

class _EventsListWidgetState extends State<EventsListWidget> {

   Future<void> removeEventFromObject()async{
    // print("removeEventFromObject");
    // print("team: " + team.toString());
    // dynamic removeTeamFromEventInput = {
    //   'team_id': team['_id'],
    //   'event_id': widget.teamsDetails['mainEvent']['_id'],
    // };
    // dynamic removeTeamFromEventResp = await EventCommand().removeTeamFromEvent(removeTeamFromEventInput);
    // print("removeTeamFromEventResp: " + removeTeamFromEventResp.toString());
    // if(removeTeamFromEventResp['success']){
    //   widget.teamsDetails['teams'].forEach((teamItem) {
    //     if(teamItem['_id'] == team['_id']){
    //       setState(() {
    //         widget.teamsDetails['teams'].remove(teamItem);
    //       });
    //     }
    //   });

    // }
    
  }

  @override
  void initState() {
    super.initState();
    print("initState() EventsListWidget");
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> events = widget.objectEventsDetails['team']['events']['data'] ?? [];
    print("EventsListWidget: " + events.toString());
   
  
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
            'Event List',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10.0),
          events.isEmpty
              ? Center(
                  child: Text('No Events'),
                )
              : Column(
                  children: List<Widget>.generate(events.length, (index) {
                    String teamName = events[index]['name'] ?? '';

                    return ListTile(
                      title: Text(teamName),
                      trailing: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[                          
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () {
                              removeEventFromObject();
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
