import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/views/tryout/view.dart';
import '../../commands/tryout_command.dart';
import '../../commands/event_command.dart';
import '../../components/create_event_payment.dart';
import '../../components/create_event_request.dart';
import '../../components/create_team_payment.dart';
import '../../components/create_team_request.dart';
import '../../components/date_time_picker.dart';
import '../../components/location_search_bar.dart';
import '../../components/headers.dart';
import '../../models/enums/EventType.dart';

class TryoutCreate extends StatefulWidget {
  const TryoutCreate({Key? key}) : super(key: key);

  @override
  State<TryoutCreate> createState() => _TryoutCreateState();
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

  Future<Map<String, dynamic>> createTryout() async {
    print("createGame");
    Map<String, dynamic> createEventResponse = {
      "success": false,
      "message": "Default Error"
    };
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
        'type': EventType.TRYOUT,
      };

      Map<String, dynamic> tryoutData = {};
      print("locationInputCheck: $locationInput");
      Map<String, dynamic> createTryoutResp = await TryoutCommand()
          .createTryout(tryoutData, eventInput, locationInput);
      print("createTryoutResp: $createTryoutResp");
      if (createTryoutResp['success']) {
        dynamic createdTryout = createTryoutResp['data'];
        await EventCommand()
            .updateViewModelsWithEvent(createdTryout['event'], true);
        if (context.mounted) {
          Navigator.pop(
            context,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    TryoutView(event: createdTryout['event'])),
          );
        }
      }
      return createEventResponse;
    } on ApiException catch (_) {
      return createEventResponse;
    }
  }

  void goBack() {
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const Headers().getBackHeader(context, "Create Tryout"),
      body: SingleChildScrollView(
        child: Center(
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
                controller: imagesController,
                decoration: const InputDecoration.collapsed(hintText: 'Images'),
              ),
              GestureDetector(
                  onTap: () {
                    createTryout();
                  },
                  child: const Text("tap me")),
              GestureDetector(
                onTap: () {
                  goBack();
                },
                child: const Text("Back to Home"),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
