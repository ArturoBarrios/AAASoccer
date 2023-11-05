import 'package:flutter/material.dart';

import '../commands/event_command.dart';
import '../views/game/view.dart';
import '../views/splash_screen.dart';
import 'Loading/loading_screen.dart';

class EventsListWidget extends StatefulWidget {
  final dynamic team;
  final dynamic user;
  List events;
  List eventUserParticipants;
  List? eventCards;

  EventsListWidget(
      {required this.team,
      required this.user,
      required this.events,
      required this.eventUserParticipants,
       this.eventCards});

  @override
  _EventsListWidgetState createState() => _EventsListWidgetState();
}

class _EventsListWidgetState extends State<EventsListWidget> {
  bool isLoading = true;

  Future<void> removeEventFromObject(dynamic event) async {
    print("removeEventFromObject");

    String teamId = "";
    if (widget.team != null) {
      teamId = widget.team['_id'];
    }

    dynamic removeTeamFromEventInput = {
      'team_id': teamId,
      'event_id': event['_id'],
    };
    dynamic removeTeamFromEventResp =
        await EventCommand().removeTeamFromEvent(removeTeamFromEventInput);
    print("removeTeamFromEventResp: " + removeTeamFromEventResp.toString());
    if (removeTeamFromEventResp['success']) {
      setState(() {
        // widget.objectEventsDetails['team']['events']['data'].remove(event);
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

  void loadInitialData() {
    
   

    setState(() {
      isLoading = false;
    });
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
    print("EventsListWidget: " + widget.events.toString());
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
            'Event List',
            style: TextStyle(
              fontSize: 18.0,
              fontWeight: FontWeight.bold,
            ),
          ),
         SizedBox(height: 10.0),
                   
                        

                        (widget.eventCards!.isEmpty
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
                        .eventCards!.length, // The number of items in the list
                    itemBuilder: (context, index) {
                      return IntrinsicWidth(
                          // This will size the width based on the child's intrinsic size.
                          child: widget.eventCards![index]);
                    },
                  ),
                )
                      
                    ),
        ],
      ),
    );
  }
}
