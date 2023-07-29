import 'dart:math';

import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import 'package:soccermadeeasy/views/league/view.dart';
import '../../commands/league_command.dart';
import '../../commands/event_command.dart';
import '../../components/create_event_payment.dart';
import '../../components/create_event_request.dart';
import '../../components/create_team_payment.dart';
import '../../components/create_team_request.dart';
import '../../components/date_time_picker.dart';
import '../../components/location_search_bar.dart';
import '../../enums/EventType.dart';
import '../../models/app_model.dart';
import '../../testing/seeding/location_seeder.dart';
import '../../components/profile.dart';
import '../home.dart';
import '../tournament/create.dart';

class LeagueCreate extends StatefulWidget {
  @override
  _LeagueCreateState createState() => _LeagueCreateState();
}

class _LeagueCreateState extends State<LeagueCreate> {
  final nameController = TextEditingController();
  final hometeamController = TextEditingController();
  final numberOfTeamsController = TextEditingController();
  final isPickupController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();
  final priceController = TextEditingController();
  final locationController = TextEditingController();
  final imagesController = TextEditingController();
  final numberOfRoundsPerTeamController = TextEditingController();
  final teamPriceController = TextEditingController();
  final capacityController = TextEditingController();

  bool _isLoading = false;
  bool isHasTournamentChecked = false;

  CreateEventRequest createEventRequestWidget = new CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = new CreateEventPayment();
  CreateTeamPayment createTeamPaymentWidget = new CreateTeamPayment();
  CreateTeamRequest createTeamRequestWidget = new CreateTeamRequest();
  DateTimePicker dateTimePicker = new DateTimePicker();
  LocationSearchBar locationSearchBar = new LocationSearchBar();

  Future<Map<String, dynamic>> createLeague() async {
    print("createLeague");
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
        'withRequest': createEventRequestWidget.withRequest.value,
        'withPayment': createEventPaymentWidget.withPayment.value,
        'withTeamPayment': createTeamPaymentWidget.withPayment.value,
        'withTeamRequest': createTeamRequestWidget.withRequest.value,
        'roles': "{PLAYER, ORGANIZER}",
        'createdAt': dateTimePicker.rightNow.millisecondsSinceEpoch.toString(),
        'type': EventType.LEAGUE,
        'capacity': int.parse(capacityController.text.toString()),
        'hasTournament': isHasTournamentChecked,
      };

      Map<String, dynamic> locationInput = {
        "name": locationSearchBar.address,
        "latitude": AppModel().currentPosition.latitude,
        "longitude": AppModel().currentPosition.longitude
      };
      List<dynamic> groupPlayOptions = [true, false];
      var rng = Random();
      print("locationInputCheck: " + locationInput.toString());
      Map<String, dynamic> createLeagueInput = {
        "numberOfTeams": int.parse(numberOfTeamsController.text.toString()),
        "numberOfRoundsPerTeam":
            int.parse(numberOfRoundsPerTeamController.text.toString()),
      };
      Map<String, dynamic> createdLeagueResp = await LeagueCommand()
          .createLeague(createLeagueInput, createEventInput, locationInput);
      print("createdLeagueResp: " + createdLeagueResp.toString());

      if (createdLeagueResp['success']) {
        dynamic createdLeague = createdLeagueResp['data'];
        dynamic mainEvent =
            EventCommand().getMainEvent(createdLeague['events']['data']);
        print("mainEvent: " + mainEvent.toString());
        if (isHasTournamentChecked) {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => TournamentCreate(league: createdLeague),
            ),
          );
        } else {
          await EventCommand().updateViewModelsWithEvent(mainEvent, true);
          
          Navigator.pop(
            context,
          );

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => LeagueView(league: mainEvent)),
          );
        }

        createEventResponse['success'] = true;
      }

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
        createTeamRequestWidget,
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
          decoration:
              new InputDecoration.collapsed(hintText: 'Number of Teams'),
        ),
        TextField(
          controller: locationController,
          decoration: new InputDecoration.collapsed(hintText: 'Location'),
        ),
        TextField(
          controller: numberOfRoundsPerTeamController,
          decoration: new InputDecoration.collapsed(
              hintText: 'Number of Rounds Per Team'),
        ),
        TextField(
          controller: capacityController,
          decoration: new InputDecoration.collapsed(hintText: 'Capacity'),
        ),
        Column(
          children: [
            Checkbox(
              value: isHasTournamentChecked,
              onChanged: (value) {
                setState(() {
                  isHasTournamentChecked = value!;
                });
              },
            ),
            TextField(
              decoration: InputDecoration.collapsed(hintText: 'Checkbox Field'),
            ),
          ],
        ),
        GestureDetector(
            onTap: () {
              createLeague();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
