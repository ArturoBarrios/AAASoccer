import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

class DateTimePicker extends StatefulWidget {
  @override
  _DateTimePicker createState() => _DateTimePicker();
  bool startTimeSet = false;
  DateTime startTime = new DateTime.now();
  DateTime endTime = new DateTime.now();
  String startTimestamp = "";
  String endTimestamp = "";
  DateTime rightNow = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch ~/ 1000 * 1000);
  DateTime twoHoursFromStart = DateTime.fromMillisecondsSinceEpoch(DateTime.now().add(Duration(hours: 2)).millisecondsSinceEpoch ~/ 1000 * 1000);
}

class _DateTimePicker extends State<DateTimePicker> {
  // State variables go here
  void setStartTime(DateTime time) {
    
    widget.startTime = time;
    widget.startTimestamp = time.millisecondsSinceEpoch.toString();
    print("setStartTime: " + time.toString());
    print("setStartTime: " + widget.startTimestamp.toString());
    widget.twoHoursFromStart = DateTime.fromMillisecondsSinceEpoch(time.add(Duration(hours: 2)).millisecondsSinceEpoch ~/ 1000 * 1000);
    widget.startTimeSet = true;
    setEndTime(widget.twoHoursFromStart);
    
  }

  void setEndTime(DateTime time) {
    
    widget.endTime = time;
    widget.endTimestamp = time.millisecondsSinceEpoch.toString();
    print("setEndTime: " + time.toString());
    print("setEndTime: " + widget.endTimestamp.toString());
  
  }

  @override
  Widget build(BuildContext context) {
    // Build method goes here
    return Container(
        child: Column(children: [
      TextButton(
          onPressed: () {
            DatePicker.showDateTimePicker(context, showTitleActions: true,
                onChanged: (date) {
              print('change $date in time zone ' +
                  date.timeZoneOffset.inHours.toString());
            }, onConfirm: (date) {
              print('confirm $date');
              setStartTime(date);
            }, currentTime: !widget.startTimeSet ? widget.rightNow : widget.startTime);
          },
          child: Text(
            'show date time picker',
            style: TextStyle(color: Colors.blue),
          )),
      TextButton(
          onPressed: () {
            DatePicker.showDateTimePicker(context, showTitleActions: true,
                onChanged: (date) {
              print('change $date in time zone ' +
                  date.timeZoneOffset.inHours.toString());
            }, onConfirm: (date) {
              print('confirm $date');
              setEndTime(date);
            }, currentTime: widget.twoHoursFromStart);
          },
          child: Text(
            'show date time picker',
            style: TextStyle(color: Colors.blue),
          )),
    ]));
  }
}
