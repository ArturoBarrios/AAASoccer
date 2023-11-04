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

  EventsListWidget(
      {required this.team,
      required this.user,
      required this.events,
      required this.eventUserParticipants});

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
    widget.eventUserParticipants.forEach((participantMap) {
      print("participantMap['event']: " + participantMap['event'].toString());
    });
    if (widget.eventUserParticipants.isNotEmpty) {
      widget.events = widget.eventUserParticipants
          .where((participantMap) =>
              participantMap.containsKey('event') &&
              participantMap['event'] != null)
          .map((participantMap) => participantMap['event'])
          .toList();
    }

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
          isLoading
              ? LoadingScreen(
                  currentDotColor: Colors.white,
                  defaultDotColor: Colors.black,
                  numDots: 10,
                )
              : (widget.events.isEmpty
                  ? Center(
                      child: Text('No Events'),
                    )
                  : Column(
                      children:
                          List<Widget>.generate(widget.events.length, (index) {
                        print("eventttt: " + widget.events[index].toString());
                        String teamName = widget.events[index]['name'] ?? '';

                        return InkWell(
                          onTap: () {
                            print("pressed");
                            //go to event
                            goToEvent(context, widget.events[index]);
                          },
                          child: ListTile(
                            title: Text(teamName),
                            trailing: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: <Widget>[
                                IconButton(
                                  icon: Icon(Icons.delete),
                                  onPressed: () {
                                    removeEventFromObject(widget.events[index]);
                                  },
                                ),
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
