import 'dart:math';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../commands/tryout_command.dart';
import '../../commands/event_command.dart';
import '../../components/profile.dart';
import '../../components/headers.dart';
import '../../testing/seeding/event_seeder.dart';

class TryoutCreate extends StatefulWidget {
  @override
  _TryoutCreateState createState() => _TryoutCreateState();
}

class _TryoutCreateState extends State<TryoutCreate> {
  final nameController = TextEditingController();
  final hometeamController = TextEditingController();
  final awayteamController = TextEditingController();
  final isPickupController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  final imagesController = TextEditingController();

  bool _isLoading = false;

  String startTimestamp = "";
  String endTimestamp = "";
  bool startTimeSet = false;
  DateTime startTime = new DateTime.now();
  DateTime endTime = new DateTime.now();
  DateTime rightNow = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().millisecondsSinceEpoch ~/ 1000 * 1000);
  DateTime twoHoursFromStart = DateTime.fromMillisecondsSinceEpoch(
      DateTime.now().add(Duration(hours: 2)).millisecondsSinceEpoch ~/
          1000 *
          1000);

  void setStartTime(DateTime time) {
    setState(() {
      startTime = time;
      startTimestamp = time.millisecondsSinceEpoch.toString();
      print("setStartTime: " + time.toString());
      print("setStartTime: " + startTimestamp.toString());
      twoHoursFromStart = DateTime.fromMillisecondsSinceEpoch(
          time.add(Duration(hours: 2)).millisecondsSinceEpoch ~/ 1000 * 1000);
      startTimeSet = true;
    });
  }

  void setEndTime(DateTime time) {
    setState(() {
      endTime = time;
      endTimestamp = time.millisecondsSinceEpoch.toString();
      print("setEndTime: " + time.toString());
      print("setEndTime: " + endTimestamp.toString());
    });
  }

  Future<Map<String, dynamic>> createTryout() async {
    print("createGame");
    Map<String, dynamic> createEventResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      var rng = Random();
      Map<String, dynamic> eventInput = {
        "name": nameController.text.toString(),
        'isMainEvent': true,
        'price': priceController.text.toString(),
        'startTime': startTimestamp,
        'endTime': endTimestamp,
      };

      Map<String, dynamic> randomPickupData =
          EventSeeder().getRandomTryoutData();
      Map<String, dynamic> locationInput = {
        "latitude": 39.9526,
        "longitude": 75.1652,
      };
      print("locationInputCheck: " + locationInput.toString());

      Map<String, dynamic> createTryoutResp = await TryoutCommand()
          .createTryout(randomPickupData, eventInput, locationInput);
      print("createTryoutResp: " + createTryoutResp.toString());

      return createEventResponse;
    } on ApiException catch (e) {
      return createEventResponse;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headers().getMainHeader(context),
      body: Center(
          child: Column(children: [
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Name'),
        ),
        TextField(
          controller: hometeamController,
          decoration: new InputDecoration.collapsed(hintText: 'Home'),
        ),
        TextField(
          controller: awayteamController,
          decoration: new InputDecoration.collapsed(hintText: 'Away'),
        ),
        TextField(
          controller: isPickupController,
          decoration: new InputDecoration.collapsed(hintText: 'Pickup'),
        ),
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
        TextField(
          controller: priceController,
          decoration: new InputDecoration.collapsed(hintText: 'Price'),
        ),
        TextField(
          controller: locationController,
          decoration: new InputDecoration.collapsed(hintText: 'Location'),
        ),
        TextField(
          controller: imagesController,
          decoration: new InputDecoration.collapsed(hintText: 'Images'),
        ),
        GestureDetector(
            onTap: () {
              createTryout();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
