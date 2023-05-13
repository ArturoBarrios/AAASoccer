import 'package:flutter/material.dart';

dynamic listOfEvents = [];

class History extends StatefulWidget {
  final dynamic historyDetails;

  History({required this.historyDetails});

  @override
  _HistoryState createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  void loadInitialData() {
    // Simulating the loading of initial data
    listOfEvents = [
      {
        "name": "Pickup Game",
        "endDate": 1684004132000,
        "type": "GAME"
      },
      {
        "name": "u23 International Champions League",
        "endDate": 1684004132000,
        "type": "TOURNAMENT"
      },
      // Add more events here...
    ];

    // You can perform any additional data processing here
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Event History'),
      ),
      body: ListView.builder(
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
