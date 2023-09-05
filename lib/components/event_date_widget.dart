import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // This package is for date formatting

class EventDateWidget extends StatefulWidget {   
  final bool canEdit;
  final String startTime;
  final String endTime;
  

  EventDateWidget({required this.canEdit, required this.startTime, required this.endTime});

  @override
  _EventDateWidget createState() => _EventDateWidget();
}

class _EventDateWidget extends State<EventDateWidget> {
  late TextEditingController _startController;
  late TextEditingController _endController;

  void loadInitialData(){
    DateTime startTime = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.startTime));
    DateTime endTime = DateTime.fromMillisecondsSinceEpoch(int.parse(widget.endTime));
    String formattedStartTime = DateFormat('MM/dd/yyyy HH:mm').format(startTime);
    String formattedEndTime = DateFormat('MM/dd/yyyy HH:mm').format(endTime);

    _startController = TextEditingController(text: formattedStartTime);
    _endController = TextEditingController(text: formattedEndTime);
  }

  @override
  void initState() {
    super.initState();
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        ListTile(
          title: Text('Start Time'),
          subtitle: TextFormField(
            controller: _startController,
            readOnly: !widget.canEdit,
          ),
        ),
        ListTile(
          title: Text('End Time'),
          subtitle: TextFormField(
            controller: _endController,
            readOnly: !widget.canEdit,
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _startController.dispose();
    _endController.dispose();
    super.dispose();
  }
}
