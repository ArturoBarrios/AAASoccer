import 'package:flutter/material.dart';

import '../commands/event_command.dart';
import '../views/game/view.dart';

class EventsListWidget extends StatefulWidget {
  final Map<String, dynamic> objectEventsDetails;

  EventsListWidget({required this.objectEventsDetails});
  
  @override
  _EventsListWidgetState createState() => _EventsListWidgetState();

}

class _EventsListWidgetState extends State<EventsListWidget> {
  List<dynamic> events = [];

   Future<void> removeEventFromObject(dynamic event)async{
    print("removeEventFromObject");  
    
    String teamId = "";
    if(widget.objectEventsDetails['team'] != null){
      teamId = widget.objectEventsDetails['team']['_id'];      
    }
    
    dynamic removeTeamFromEventInput = {
      'team_id': teamId,
      'event_id': event['_id'],
    };
    dynamic removeTeamFromEventResp = await EventCommand().removeTeamFromEvent(removeTeamFromEventInput);
    print("removeTeamFromEventResp: " + removeTeamFromEventResp.toString());
    if(removeTeamFromEventResp['success']){
      setState(() {        
        widget.objectEventsDetails['team']['events']['data'].remove(event);
      });


    }
    
  }

  void goToEvent(BuildContext context, dynamic event) {
  print("goToEvent");
  dynamic eventToNavigateTo = event;
  //what event view should you go to? 
  //for training, tryout, league, tournament
  Navigator.push(
    context,
    MaterialPageRoute(
      builder: (context) => PickupView(game: event),
    ),
  );
}

  void loadInitialData(){
    if(widget.objectEventsDetails['team'] != null){
      events = widget.objectEventsDetails['team']['events']['data'];    
    }
    else{
      List<dynamic> eventUserParticipants = widget.objectEventsDetails['eventUserParticipants'];
      eventUserParticipants.forEach((eventUserParticipant) {
        events.add(eventUserParticipant['event']);
      });

    }
  }

  @override
  void initState() {
    super.initState();
    print("initState() EventsListWidget");
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    // List<dynamic> events = widget.objectEventsDetails['team']['events']['data'] ?? [];
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

                return InkWell(
                  onTap: () {
                    print("pressed");
                    //go to event
                    goToEvent(context, events[index]);
                    
                  },
                  child: ListTile(
                    title: Text(teamName),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[                          
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            removeEventFromObject(events[index]);
                          },
                        ),
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
