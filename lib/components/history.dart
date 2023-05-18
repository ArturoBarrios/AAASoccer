import 'package:flutter/material.dart';

import '../commands/event_command.dart';

dynamic listOfEvents = [];

class History extends StatefulWidget {
  final dynamic historyDetails;

  History({required this.historyDetails});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  bool _isLoading = true;


  @override
  void initState() {
    super.initState();
    print("History initState");
    print("historyDetails: " + widget.historyDetails.toString());
    loadInitialData();
  }

void loadInitialData() async {
  print("loadInitialData");

  // Retrieve all events
  var rawEvents = await EventCommand().returnMyEventsModel();

  // Filter events to get only those that have already ended and format them accordingly
  DateTime now = DateTime.now();
  listOfEvents = rawEvents.map((rawEvent) {
    DateTime eventDate = DateTime.fromMillisecondsSinceEpoch(int.parse(rawEvent['event']['endTime']));
    return {
      'name': rawEvent['event']['name'],
      'endDate': eventDate.isBefore(now) ? int.parse(rawEvent['event']['endTime']) : null,
      'type': rawEvent['event']['type'],
    };
  }).toList();

  // Filter out any events that didn't end
  listOfEvents = listOfEvents.where((event) => event['endDate'] != null).toList();

  print("listOfEvents: " + listOfEvents.toString());
  // You can perform any additional data processing here
  setState(() {
    _isLoading = false;
    
  });
}



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event History'),
      ),
      body: !_isLoading ? ListView.builder(
        itemCount: listOfEvents.length,
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              print('Event clicked');
            },
            child: Card(
              child: ListTile(
                title: Text(listOfEvents[index]['name']),
                subtitle: Text(getFormattedDate(listOfEvents[index]['endDate'])),
                trailing: Text(listOfEvents[index]['type']),
              ),
            ),
          );
        },
      ): 
      Center(
        child: CircularProgressIndicator(),
      ),
    );
  }

  String getFormattedDate(int endDate) {
  DateTime dateTime = DateTime.fromMillisecondsSinceEpoch(endDate);
  String formattedDate =
      '${dateTime.month.toString().padLeft(2, '0')}/${dateTime.day.toString().padLeft(2, '0')}/${dateTime.year}';
  return formattedDate;
}

}
