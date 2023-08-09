import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/views/game/view.dart';
import '../../components/create_event_payment.dart';
import '../../components/create_event_request.dart';
import '../../components/create_team_payment.dart';
import '../../components/create_team_request.dart';
import '../../components/date_time_picker.dart';
import '../../components/headers.dart';
import '../../components/location_search_bar.dart';
import '../../commands/game_command.dart';
import '../../commands/event_command.dart';
import '../../enums/EventType.dart';

class GameCreate extends StatefulWidget {
  const GameCreate({Key? key}) : super(key: key);

  @override
  State<GameCreate> createState() => _GameCreateState();
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
  final imageController = TextEditingController();

  final Map<String, dynamic> locationInput = {
    "name": "",
    "latitude": 0,
    "longitude": 0,
  };
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
        locationInput['name'] = address;
        locationInput['latitude'] = coordinates.latitude;
        locationInput['longitude'] = coordinates.longitude;
      },
    );
    super.initState();
  }

  Future<void> createPickupGame() async {
    print("createGame");
    try {
      print("priceee: ${priceController.text}");
      Map<String, dynamic> eventInput = {
        "name": nameController.text.toString(),
        'isMainEvent': true,
        'price': double.parse(priceController.text.toString()),
        'startTime': dateTimePicker.startTimestamp,
        'endTime': dateTimePicker.endTimestamp,
        'withRequest': createEventRequestWidget.withRequest.value,
        'withPayment': createEventPaymentWidget.withPayment.value,
        'withTeamPayment': createTeamPaymentWidget.withPayment.value,
        'withTeamRequest': createTeamRequestWidget.withRequest.value,
        'roles': "{PLAYER, ORGANIZER}",
        'createdAt': dateTimePicker.rightNow.millisecondsSinceEpoch.toString(),
        'type': EventType.GAME,
      };
      dynamic pickupData = {
        "pickup": true,
      };
      print("locationInputCheaheck: $locationInput");

      Map<String, dynamic> createPickupGameResp =
          await GameCommand().createGame(pickupData, eventInput, locationInput);
      print("createPickupGameResp: $createPickupGameResp");
      print(createPickupGameResp['data']);
      if (createPickupGameResp['success']) {
        Map<String, dynamic> createdGame = createPickupGameResp['data'];
        await EventCommand()
            .updateViewModelsWithEvent(createdGame['event'], true);

        if (context.mounted) {
          Navigator.pop(
            context,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => PickupView(
                game: createdGame['event'],
              ),
            ),
          );
        }
      }
    } on ApiException catch (_) {}
  }

  void goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Headers().getBackHeader(context, "Create Game"),
      body: Center(
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration.collapsed(hintText: 'Name'),
            ),
            TextField(
              controller: hometeamController,
              decoration: const InputDecoration.collapsed(hintText: 'Home'),
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
              controller: awayteamController,
              decoration: const InputDecoration.collapsed(hintText: 'Away'),
            ),
            TextField(
              controller: isPickupController,
              decoration: const InputDecoration.collapsed(hintText: 'Pickup'),
            ),
            TextField(
              controller: surfaceController,
              decoration: const InputDecoration.collapsed(hintText: 'Surface'),
            ),
            TextField(
              controller: fieldSizeController,
              decoration:
                  const InputDecoration.collapsed(hintText: 'Field Size'),
            ),
            TextField(
              controller: privateController,
              decoration: const InputDecoration.collapsed(hintText: 'Private'),
            ),
            TextField(
              controller: imageController,
              decoration: const InputDecoration.collapsed(hintText: 'Images'),
            ),
            GestureDetector(
                onTap: () {
                  createPickupGame();
                },
                child: const Text("Create")),
            GestureDetector(
              onTap: () {
                goBack();
              },
              child: const Text("Back to Home"),
            ),
          ],
        ),
      ),
    );
  }
}
