import 'dart:convert';
import 'dart:ffi';
import 'dart:math';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/location_search_bar.dart';
import '../../commands/game_command.dart';
import '../../commands/game_command.dart';
import '../../commands/location_command.dart';
import '../../commands/event_command.dart';
import '../../testing/seeding/event_seeder.dart';
import '../../testing/seeding/location_seeder.dart';
import '../../components/profile.dart';
import '../../views/home.dart';
import 'package:geocoder/geocoder.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';


class GameCreate extends StatefulWidget with EventMixin {
  @override
  _GameCreateState createState() => _GameCreateState();
}

class _GameCreateState extends State<GameCreate> {
  final nameController = TextEditingController();
  final hometeamController = TextEditingController();
  final awayteamController = TextEditingController();
  final isPickupController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  bool startTimeSet = false;
  DateTime startTime = new DateTime.now();
  DateTime endTime = new DateTime.now();
  String startTimestamp = "";
  String endTimestamp = "";
  Coordinates coordinates = new Coordinates(0, 0);
  final imagesController = TextEditingController();

  bool _isLoading = false;

  
  DateTime rightNow = DateTime.fromMillisecondsSinceEpoch(DateTime.now().millisecondsSinceEpoch ~/ 1000 * 1000);
  DateTime twoHoursFromStart = DateTime.fromMillisecondsSinceEpoch(DateTime.now().add(Duration(hours: 2)).millisecondsSinceEpoch ~/ 1000 * 1000);
  


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

  void setStartTime(DateTime time) {
    setState(() {
      startTime = time;
      startTimestamp = time.millisecondsSinceEpoch.toString();
      print("setStartTime: " + time.toString());
      print("setStartTime: " + startTimestamp.toString());
      twoHoursFromStart = DateTime.fromMillisecondsSinceEpoch(time.add(Duration(hours: 2)).millisecondsSinceEpoch ~/ 1000 * 1000);
      startTimeSet = true;
      setEndTime(twoHoursFromStart);
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

  Future<void> createPickupGame() async {
    print("createGame");
    Map<String, dynamic> createPickupGameResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      var rng = Random();
      print("priceee: " + priceController.text.toString());
      Map<String, dynamic> eventInput = {
        "name": nameController.text.toString(),
        'isMainEvent': true,
        'price': int.parse(priceController.text.toString()),
        'startTime': startTimestamp,
        'endTime': endTimestamp,
        'withRequest': widget.withRequest,
        'withPayment': widget.withPayment, 
        'roles': "{PLAYER, ORGANIZER}"
      };

      Map<String, dynamic> randomPickupData =
          EventSeeder().getRandomPickupGameData();
      // Map<String, dynamic> generateRandomLocation = await LocationSeeder().generateRandomLocation(LocationSeeder().locations[0]);
      Map<String, dynamic> locationInput = {
        "latitude": coordinates.latitude,
        "longitude": coordinates.longitude,
      };
      // Map<String, dynamic> locationInput = generateRandomLocation["data"]["randomLocation"];
      print("locationInputCheaheck: " + locationInput.toString());

      Map<String, dynamic> createPickupGameResp = await GameCommand()
          .createGame(randomPickupData, eventInput, locationInput);
      print("createPickupGameResp: ");
      print(createPickupGameResp['data']);
      if (createPickupGameResp['success']) {
        Map<String, dynamic> pickupGame = createPickupGameResp['data'];
        Map<String, dynamic> event = pickupGame['event'];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } on ApiException catch (e) {}
  }


  void goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: new Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Find Soccer Near You")),
        backgroundColor: Colors.orange.shade500,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Go to the next page',
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute<void>(
              //   builder: (BuildContext context) {
              //     return Profile();
              //   },
              // ));
            },
          ),
        ],
      ),
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
        // TextField(
        //   controller: locationController,
        //   decoration: new InputDecoration.collapsed(hintText: 'Location'),
        //   onChanged: (value) async => {
        //     await LocationCommand().place_api_autocomplete(value),
        //   }),

        LocationSearchBar(chooseAddress: chooseAddress,),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Join With Request?"), 
            Checkbox(              
              value: widget.withRequest, 
              onChanged: (bool? value) { 
                setState(() {
                  widget.withRequest = value!;
                });
              },
              
            ),
          ]
        ),
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Join With Payment?"), 
            Checkbox(              
              value: widget.withPayment, 
              onChanged: (bool? value) { 
                setState(() {
                  widget.withPayment = value!;
                });
              },
              
            ),
          ]
        ),
        TextField(
          controller: awayteamController,
          decoration: new InputDecoration.collapsed(hintText: 'Away'),
        ),
        TextField(
          controller: isPickupController,
          decoration: new InputDecoration.collapsed(hintText: 'Pickup'),
        ),
        TextField(
          controller: surfaceController,
          decoration: new InputDecoration.collapsed(hintText: 'Surface'),
        ),
        TextField(
          controller: fieldSizeController,
          decoration: new InputDecoration.collapsed(hintText: 'Field Size'),
        ),
        TextField(
          controller: privateController,
          decoration: new InputDecoration.collapsed(hintText: 'Private'),
        ),
        TextField(
          controller: priceController,
          decoration: new InputDecoration.collapsed(hintText: 'Price'),
        ),
        TextField(
          controller: imagesController,
          decoration: new InputDecoration.collapsed(hintText: 'Images'),
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
        GestureDetector(
            onTap: () {
              createPickupGame();
            },
            child: Text("Create")),
        GestureDetector(
            onTap: () {
              goBack();
            },
            child: Text("Back to Home")),
      ])),
    );
  }
}
