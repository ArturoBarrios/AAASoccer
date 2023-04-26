

import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:geocoder/geocoder.dart';
import 'package:soccermadeeasy/views/request/view.dart';

import '../../commands/event_command.dart';
import '../../commands/player_command.dart';
import '../../commands/team_command.dart';
import '../../commands/user_command.dart';
import '../../constants.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';

mixin CreateEventMixin {
  bool startTimeSet = false;
  DateTime startTime = new DateTime.now();
  DateTime endTime = new DateTime.now();
  String startTimestamp = "";
  String endTimestamp = "";
  DateTime rightNow = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch ~/ 1000 * 1000);
  DateTime twoHoursFromStart = DateTime.fromMillisecondsSinceEpoch(DateTime.now().add(Duration(hours: 2)).millisecondsSinceEpoch ~/ 1000 * 1000);
  Coordinates coordinates = new Coordinates(0, 0);

  final locationController = TextEditingController();

  void setStartTime(DateTime time) {
    
    startTime = time;
    startTimestamp = time.millisecondsSinceEpoch.toString();
    print("setStartTime: " + time.toString());
    print("setStartTime: " + startTimestamp.toString());
    twoHoursFromStart = DateTime.fromMillisecondsSinceEpoch(time.add(Duration(hours: 2)).millisecondsSinceEpoch ~/ 1000 * 1000);
    startTimeSet = true;
    setEndTime(twoHoursFromStart);
    
  }

  void setEndTime(DateTime time) {
    
    endTime = time;
    endTimestamp = time.millisecondsSinceEpoch.toString();
    print("setEndTime: " + time.toString());
    print("setEndTime: " + endTimestamp.toString());
  
  }

  Container getTimeWidgets(context) {
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
            }, currentTime: !startTimeSet ? rightNow : startTime);
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
            }, currentTime: twoHoursFromStart);
          },
          child: Text(
            'show date time picker',
            style: TextStyle(color: Colors.blue),
          )),
    ]));
  }

  void chooseAddress(String chosenAddress) async {
    print("chooseAddress");
    locationController.text = chosenAddress;
    List<Address> addresses = await Geocoder.local.findAddressesFromQuery(chosenAddress);
    Address address = addresses.first;
    print("address: " + address.toString());
    coordinates = address.coordinates;
    print("coordinates: " + coordinates.toString());
    coordinates.latitude;
    coordinates.longitude;
    // LocationCommand().translateAddressToLocation(location);
  }

}
