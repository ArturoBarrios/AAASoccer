import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/models/pageModels/app_model.dart';
import 'package:soccermadeeasy/views/tournament/view.dart';
import '../../commands/tournament_command.dart';
import '../../commands/event_command.dart';
import '../../components/create_event_payment.dart';
import '../../components/create_team_payment.dart';
import '../../components/create_team_request.dart';
import '../../components/create_event_request.dart';
import '../../components/date_time_picker.dart';
import '../../components/event_input_widget.dart';
import '../../components/location_search_bar.dart';
import '../../models/enums/EventType.dart';

class TournamentCreate extends StatefulWidget {
  final dynamic league;
  const TournamentCreate({
    Key? key,
    this.league,
  }) : super(key: key);

  @override
  State<TournamentCreate> createState() => _TournamentCreateState();
}

class _TournamentCreateState extends State<TournamentCreate> {
  String name = "";
  final groupPlayController = TextEditingController();
  final numberOfTeamsController = TextEditingController();
  final isPickupController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();
  String price = "0.00";
  final locationController = TextEditingController();
  final imagesController = TextEditingController();
  final numberOfRoundsPerTeamController = TextEditingController();
  final numberOfTeamsPerGroupController = TextEditingController();
  final roundOfXController = TextEditingController();
  final knockoutRoundsController = TextEditingController();
  final teamPriceController = TextEditingController();
  final capacityController = TextEditingController();

  CreateEventRequest createEventRequestWidget = CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = CreateEventPayment();
  CreateTeamPayment createTeamPaymentWidget = CreateTeamPayment();
  CreateTeamRequest createTeamRequestWidget = CreateTeamRequest();
  DateTimePicker dateTimePicker = DateTimePicker();
  String address = '';
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

  void onUserEventDetailsChange(String newName, String newPrice) {
    setState(() {
      name = newName;
      price = newPrice;
    });
  }

  Future<Map<String, dynamic>> createTournament() async {
    print("createTournament");
    Map<String, dynamic> createEventResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      Map<String, dynamic> createEventInput = {
        "name": name,
        'isMainEvent': true,
        'price': double.parse(price),
        'teamPrice': double.parse(teamPriceController.text.toString()),
        'startTime': dateTimePicker.startTimestamp,
        'endTime': dateTimePicker.endTimestamp,
        'withRequest': createEventRequestWidget.withRequest.value,
        'withPayment': createEventPaymentWidget.withPayment.value,
        'withTeamPayment': createTeamPaymentWidget.withPayment.value,
        'withTeamRequest': createTeamRequestWidget.withRequest.value,
        'roles': "{PLAYER, ORGANIZER}",
        'createdAt': dateTimePicker.rightNow.millisecondsSinceEpoch.toString(),
        'type': EventType.TOURNAMENT,
        'capacity': int.parse(capacityController.text.toString()),
      };

      Map<String, dynamic> locationInput = {
        "name": address,
        "latitude": AppModel().currentPosition.latitude,
        "longitude": AppModel().currentPosition.longitude
      };

      print("locationInputCheck: $locationInput");
      Map<String, dynamic> createTournamentInput = {
        "numberOfRoundsPerTeam":
            int.parse(numberOfRoundsPerTeamController.text.toString()),
        "numberOfTeams": int.parse(numberOfTeamsController.text.toString()),
        "numberOfGroups": int.parse(numberOfTeamsController.text.toString()) ~/
            int.parse(numberOfTeamsPerGroupController.text.toString()),
        "groupPlay": false,
        "numberOfTeamsPerGroup":
            int.parse(numberOfTeamsPerGroupController.text.toString()),
        "roundOfX": int.parse(roundOfXController.text.toString()),
        "knockoutRounds": int.parse(knockoutRoundsController.text.toString()),
      };
      Map<String, dynamic> createdTournamentResp = await TournamentCommand()
          .createTournament(createTournamentInput, createEventInput,
              locationInput, widget.league);
      print("createdTournamentResp: $createdTournamentResp");

      if (createdTournamentResp['success']) {
        dynamic createdTournament = createdTournamentResp['data'];
        dynamic mainEvent =
            EventCommand().getMainEvent(createdTournament['events']['data']);
        print("mainEventt: $mainEvent");
        await EventCommand().updateViewModelsWithEvent(mainEvent, true);

        if (context.mounted) {
          Navigator.pop(
            context,
          );

          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => TournamentView(tournament: mainEvent)),
          );
        }

        createEventResponse['success'] = true;
      }
      // }
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 50.0),
        child:Center(
        child: Column(
          children: [
            EventInputWidget(
                onUserEventDetailsChange: onUserEventDetailsChange),
            locationSearchBar,
            createEventRequestWidget,
            createEventPaymentWidget,
            createTeamRequestWidget,
            createTeamPaymentWidget,
            dateTimePicker,
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
              controller: numberOfRoundsPerTeamController,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Number of Rounds Per Team'),
            ),
            TextField(
              controller: numberOfTeamsPerGroupController,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Number of Teams Per Group'),
            ),
            TextField(
              controller: roundOfXController,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Round of X'),
            ),
            TextField(
              controller: knockoutRoundsController,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Knockout Rounds'),
            ),            
            GestureDetector(
              onTap: () {
                createTournament();
              },
              child: const Text("tap me"),
            ),
          ],
        ),
      )),
    );
  }
}
