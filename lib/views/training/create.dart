import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/views/training/view.dart';
import '../../commands/training_command.dart';
import '../../commands/event_command.dart';
import '../../components/create_event_payment.dart';
import '../../components/create_event_request.dart';
import '../../components/create_team_payment.dart';
import '../../components/create_team_request.dart';
import '../../components/date_time_picker.dart';
import '../../components/location_search_bar.dart';
import '../../models/enums/EventType.dart';
import '../../components/headers.dart';

class TrainingCreate extends StatefulWidget {
  const TrainingCreate({Key? key}) : super(key: key);

  @override
  State<TrainingCreate> createState() => _TrainingCreateState();
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

  CreateEventRequest createEventRequestWidget = CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = CreateEventPayment();
  CreateTeamPayment createTeamPaymentWidget = CreateTeamPayment();
  CreateTeamRequest createTeamRequestWidget = CreateTeamRequest();
  DateTimePicker dateTimePicker = DateTimePicker();
  final Map<String, dynamic> locationInput = {
    "name": "",
    "latitude": 0,
    "longitude": 0,
  };
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

  Future<void> createTraining() async {
    print("createTraining");
    try {
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
        'type': EventType.TRAINING
      };

      Map<String, dynamic> trainingData = {};

      print("locationInputCheck: $locationInput");

      Map<String, dynamic> createTrainingResp = await TrainingCommand()
          .createTraining(trainingData, eventInput, locationInput);

      print("createTrainingResp: $createTrainingResp");
      if (createTrainingResp['success']) {
        dynamic createdTraining = createTrainingResp['data'];
        await EventCommand()
            .updateViewModelsWithEvent(createdTraining['event'], true);

        if (context.mounted) {
          Navigator.pop(
            context,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TrainingView(
                training: createdTraining['event'],
              ),
            ),
          );
        }
      }
    } on ApiException catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Headers().getMainHeader(context),
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
              controller: locationController,
              decoration: const InputDecoration.collapsed(hintText: 'Location'),
            ),
            TextField(
              controller: imagesController,
              decoration: const InputDecoration.collapsed(hintText: 'Images'),
            ),
            GestureDetector(
              onTap: () {
                createTraining();
              },
              child: const Text("tap me"),
            ),
          ],
        ),
      ),
    );
  }
}
