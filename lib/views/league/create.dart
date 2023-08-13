import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
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
import '../tournament/create.dart';

class LeagueCreate extends StatefulWidget {
  const LeagueCreate({Key? key}) : super(key: key);

  @override
  State<LeagueCreate> createState() => _LeagueCreateState();
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

  String address = '';
  bool isHasTournamentChecked = false;

  CreateEventRequest createEventRequestWidget = CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = CreateEventPayment();
  CreateTeamPayment createTeamPaymentWidget = CreateTeamPayment();
  CreateTeamRequest createTeamRequestWidget = CreateTeamRequest();
  DateTimePicker dateTimePicker = DateTimePicker();
  late LocationSearchBar locationSearchBar;

  @override
  initState() {
    locationSearchBar = LocationSearchBar(
      onCoordinatesChange: (coordinates, address) {
        this.address = address;
      },
    );
    super.initState();
  }

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
        "name": address,
        "latitude": AppModel().currentPosition.latitude,
        "longitude": AppModel().currentPosition.longitude
      };
      print("locationInputCheck: $locationInput");
      Map<String, dynamic> createLeagueInput = {
        "numberOfTeams": int.parse(numberOfTeamsController.text.toString()),
        "numberOfRoundsPerTeam":
            int.parse(numberOfRoundsPerTeamController.text.toString()),
      };
      Map<String, dynamic> createdLeagueResp = await LeagueCommand()
          .createLeague(createLeagueInput, createEventInput, locationInput);
      print("createdLeagueResp: $createdLeagueResp");

      if (createdLeagueResp['success']) {
        dynamic createdLeague = createdLeagueResp['data'];
        dynamic mainEvent =
            EventCommand().getMainEvent(createdLeague['events']['data']);
        print("mainEvent: $mainEvent");
        if (isHasTournamentChecked) {
          if (context.mounted) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => TournamentCreate(league: createdLeague),
              ),
            );
          }
        } else {
          await EventCommand().updateViewModelsWithEvent(mainEvent, true);
          if (context.mounted) {
            Navigator.pop(
              context,
            );

            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => LeagueView(league: mainEvent)),
            );
          }
        }

        createEventResponse['success'] = true;
      }

      return createEventResponse;
    } on ApiException catch (_) {
      return createEventResponse;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Padding(
            padding: EdgeInsets.only(left: 20.0),
            child: Text("Find Soccer Near You")),
        backgroundColor: Colors.orange.shade500,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Go to the next page',
            onPressed: () {
             
            },
          ),
        ],
      ),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration.collapsed(hintText: 'Name'),
            ),
            locationSearchBar,
            createEventRequestWidget,
            createEventPaymentWidget,
            createTeamRequestWidget,
            createTeamPaymentWidget,
            dateTimePicker,
            TextField(
              controller: priceController,
              decoration: const InputDecoration.collapsed(hintText: 'Price'),
            ),
            TextField(
              controller: teamPriceController,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Team Price'),
            ),
            TextField(
              controller: numberOfTeamsController,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Number of Teams'),
            ),
            TextField(
              controller: locationController,
              decoration: const InputDecoration.collapsed(hintText: 'Location'),
            ),
            TextField(
              controller: numberOfRoundsPerTeamController,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Number of Rounds Per Team'),
            ),
            TextField(
              controller: capacityController,
              decoration: const InputDecoration.collapsed(hintText: 'Capacity'),
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
                const TextField(
                  decoration:
                      InputDecoration.collapsed(hintText: 'Checkbox Field'),
                ),
              ],
            ),
            GestureDetector(
              onTap: () {
                createLeague();
              },
              child: const Text("tap me"),
            ),
          ],
        ),
      ),
    );
  }
}
