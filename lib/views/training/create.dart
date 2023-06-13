import 'dart:math';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../commands/training_command.dart';
import '../../commands/event_command.dart';
import '../../components/create_event_payment.dart';
import '../../components/create_event_request.dart';
import '../../components/create_team_payment.dart';
import '../../components/create_team_request.dart';
import '../../components/date_time_picker.dart';
import '../../components/location_search_bar.dart';
import '../../enums/EventType.dart';
import '../../testing/seeding/event_seeder.dart';
import '../../components/headers.dart';
import '../home.dart';

class TrainingCreate extends StatefulWidget {
  @override
  _TrainingCreateState createState() => _TrainingCreateState();
}

class _TrainingCreateState extends State<TrainingCreate> {
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

  CreateEventRequest createEventRequestWidget = new CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = new CreateEventPayment();
  CreateTeamPayment createTeamPaymentWidget = new CreateTeamPayment();
  CreateTeamRequest createTeamRequestWidget = new CreateTeamRequest();
  DateTimePicker dateTimePicker = new DateTimePicker();
  LocationSearchBar locationSearchBar = new LocationSearchBar();
    

  Future<void> createTraining() async {
    print("createTraining");
    Map<String, dynamic> createEventResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      var rng = Random();
       Map<String, dynamic> eventInput = {        
        "name": nameController.text.toString(),
        'isMainEvent': true,        
        'price':  double.parse(priceController.text.toString()),
        'startTime': dateTimePicker.startTimestamp,
        'endTime': dateTimePicker.endTimestamp,
        'withRequest': createEventRequestWidget.withRequest.value,
        'withPayment': createEventPaymentWidget.withPayment.value, 
        'withTeamPayment': createTeamPaymentWidget.withPayment.value, 
        'withTeamRequest': createTeamRequestWidget.withRequest.value, 
        'roles': "{PLAYER, ORGANIZER}",
        'createdAt': dateTimePicker.rightNow.millisecondsSinceEpoch.toString(),
        'type': EventType.TRAINING

      };

      Map<String, dynamic> trainingData = {};
      Map<String, dynamic> locationInput = {
        "name": locationSearchBar.address,
        "latitude": locationSearchBar.coordinates.latitude,
        "longitude": locationSearchBar.coordinates.longitude,
      };
      print("locationInputCheck: " + locationInput.toString());  

      Map<String, dynamic> createTrainingResp = await TrainingCommand().createTraining(trainingData, eventInput, locationInput);                                      
      print("createTrainingResp: "+ createTrainingResp.toString());

      if (createTrainingResp['success']) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }            
      
      }
       on ApiException catch (e) {
      
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
        locationSearchBar,
        createEventRequestWidget,
        createEventPaymentWidget,      
        createTeamRequestWidget,
        createTeamPaymentWidget, 
        dateTimePicker,
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
              createTraining();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
