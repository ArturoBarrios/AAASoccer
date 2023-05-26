import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import 'package:soccermadeeasy/models/app_model.dart';
import '../../commands/tournament_command.dart';
import '../../commands/event_command.dart';
import '../../components/create_event_payment.dart';
import '../../components/create_team_payment.dart';
import '../../components/create_event_request.dart';
import '../../components/date_time_picker.dart';
import '../../components/location_search_bar.dart';
import '../../enums/EventType.dart';
import '../../testing/seeding/location_seeder.dart';
import '../../components/profile.dart';
import 'dart:math';
import 'dart:convert';

import '../home.dart';

class TournamentCreate extends StatefulWidget {
  @override
  _TournamentCreateState createState() => _TournamentCreateState();
}

class _TournamentCreateState extends State<TournamentCreate> {
  final nameController = TextEditingController();
  final groupPlayController = TextEditingController();
  final numberOfTeamsController = TextEditingController();
  final isPickupController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  final imagesController = TextEditingController();
  final numberOfRoundsPerTeamController = TextEditingController();
  final numberOfTeamsPerGroupController = TextEditingController();
  final roundOfXController = TextEditingController();
  final knockoutRoundsController = TextEditingController();
  final teamPriceController = TextEditingController();
  final capacityController = TextEditingController();

  bool _isLoading = false;

  CreateEventRequest createEventRequestWidget = new CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = new CreateEventPayment();
  CreateTeamPayment createTeamPaymentWidget = new CreateTeamPayment();
  DateTimePicker dateTimePicker = new DateTimePicker();
  LocationSearchBar locationSearchBar = new LocationSearchBar();

 
  

  Future<Map<String, dynamic>> createTournament() async {
    print("createTournament");
    Map<String, dynamic> createEventResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      Map<String, dynamic> createEventInput = {
        "name": nameController.text.trim(),
        'isMainEvent': true,           
        'price': double.parse(priceController.text.toString()),
        'teamPrice': double.parse(teamPriceController.text.toString()),
        'startTime': dateTimePicker.startTimestamp,
        'endTime': dateTimePicker.endTimestamp,
        'withRequest': createEventRequestWidget.withRequest,
        'withPayment': createEventPaymentWidget.withPayment, 
        'withTeamPayment': createTeamPaymentWidget.withPayment, 
        'roles': "{PLAYER, ORGANIZER}",
        'createdAt': dateTimePicker.rightNow.millisecondsSinceEpoch.toString(),
        'type': EventType.TOURNAMENT,
        'capacity': int.parse(capacityController.text.toString()),
      };
      
        Map<String, dynamic> locationInput = {"latitude": AppModel().currentPosition.latitude, "longitude": AppModel().currentPosition.longitude};//generateRandomLocation["data"]["randomLocation"];
        List<dynamic> groupPlayOptions = [true, false];
        var rng = Random();        
        print("locationInputCheck: " + locationInput.toString());   
        Map<String, dynamic> createTournamentInput = {
          "numberOfRoundsPerTeam": int.parse(numberOfRoundsPerTeamController.text.toString()),
          "numberOfTeams": int.parse(numberOfTeamsController.text.toString()),
          "numberOfGroups": int.parse(numberOfTeamsController.text.toString()) ~/ int.parse(numberOfTeamsPerGroupController.text.toString()),
          "groupPlay": false,
          "numberOfTeamsPerGroup": int.parse(numberOfTeamsPerGroupController.text.toString()),
          "roundOfX": int.parse(roundOfXController.text.toString()),
          "knockoutRounds": int.parse(knockoutRoundsController.text.toString()),

        };
        Map<String, dynamic> createdTournament =
            await TournamentCommand().createTournament(createTournamentInput, createEventInput, locationInput);
        print("createdTournament: "+ createdTournament.toString());        

        if (createdTournament['success']) {
          //update models that depend on tournament data
           Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );

          createEventResponse['success'] = true;
        }
      // }
      return createEventResponse;
    } on ApiException catch (e) {
      return createEventResponse;
    }
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
        locationSearchBar,
        createEventRequestWidget,
        createEventPaymentWidget,
        createTeamPaymentWidget,
        dateTimePicker,
        TextField(
          controller: priceController,
          decoration: new InputDecoration.collapsed(hintText: 'Price'),
        ),
        TextField(
          controller: teamPriceController,
          decoration: new InputDecoration.collapsed(hintText: 'Team Price'),
        ),
        TextField(
          controller: numberOfTeamsController,
          decoration: new InputDecoration.collapsed(hintText: 'Number of Teams'),
        ),
        
       
        TextField(
          controller: numberOfRoundsPerTeamController,
          decoration: new InputDecoration.collapsed(hintText: 'Number of Rounds Per Team'),
        ),
        TextField(
          controller: numberOfTeamsPerGroupController,
          decoration: new InputDecoration.collapsed(hintText: 'Number of Teams Per Group'),
        ),
        TextField(
          controller: roundOfXController,
          decoration: new InputDecoration.collapsed(hintText: 'Round of X'),
        ),
        TextField(
          controller: knockoutRoundsController,
          decoration: new InputDecoration.collapsed(hintText: 'Knockout Rounds'),
        ),
        TextField(
          controller: capacityController,
          decoration: new InputDecoration.collapsed(hintText: 'Capcity'),
        ),
        GestureDetector(
            onTap: () {
              createTournament();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
