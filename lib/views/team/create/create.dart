import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import '../../../commands/team_command.dart';
import '../../../components/create_event_payment.dart';
import '../../../components/create_event_request.dart';
import '../../../components/date_time_picker.dart';
import '../../../components/location_search_bar.dart';
import '../view.dart';

class TeamCreate extends StatefulWidget {
  const TeamCreate({Key? key}) : super(key: key);

  @override
  State<TeamCreate> createState() => _TeamCreateState();
}

class _TeamCreateState extends State<TeamCreate> {
  final nameController = TextEditingController();
  final colorController = TextEditingController();
  final logoController = TextEditingController();
  final imagesController = TextEditingController();
  int createTeamCurrentStep = 0;
  final createTeamTotalSteps = 3;
  final priceController = TextEditingController();

  CreateEventRequest createEventRequestWidget = CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = CreateEventPayment();
  DateTimePicker dateTimePicker = DateTimePicker();
  late LocationSearchBar locationSearchBar;
  final Map<String, dynamic> locationInput = {
    "name": "",
    "latitude": 0,
    "longitude": 0,
  };
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

  void createTeam() async {
    print("createGame");
    Map<String, dynamic> createEventResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {                       
        Map<String, dynamic> createTeamInput = {
          'name': nameController.text.trim(),
          'color': colorController.text.trim(),
          'logo': logoController.text.trim(),
          'images': imagesController.text.trim(),
          'price': double.parse(priceController.text.toString()),
          'withRequest': createEventRequestWidget.withRequest.value,
          'withPayment': createEventPaymentWidget.withPayment.value,           
          'roles': "{PLAYER, ORGANIZER}",
          'createdAt': dateTimePicker.rightNow.millisecondsSinceEpoch.toString(),                    
          'updatedAt': dateTimePicker.rightNow.millisecondsSinceEpoch.toString(),                    
        };

      Map<String, dynamic> createdTeamResp =
          await TeamCommand().createTeam(createTeamInput, locationInput);

      print("createdTeamResponse: $createdTeamResp");
      if (createdTeamResp['success']) {
        //now update view and app models that depend on this data
        print("now update view and app models that depend on this data");
        dynamic createdTeam = createdTeamResp['data'];
        print("createdTeam: $createdTeam");

        TeamCommand().updateModelsWithTeam(createdTeam, true);
        //navigate home
        if (context.mounted) {
          Navigator.pop(
            context,
          );
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TeamView(
                teamObject: createdTeam,
              ),
            ),
          );
        }

        createEventResponse['success'] = true;
      }
    } on ApiException catch (_) {}
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
        child: Column(
          children: [
            TextField(
              controller: nameController,
              decoration: const InputDecoration.collapsed(hintText: 'Name'),
            ),
            TextField(
              controller: colorController,
              decoration: const InputDecoration.collapsed(hintText: 'Color'),
            ),
            locationSearchBar,
            createEventRequestWidget,
            createEventPaymentWidget,
            dateTimePicker,
            TextField(
              controller: priceController,
              decoration: const InputDecoration.collapsed(hintText: 'Price'),
            ),
            TextField(
              controller: imagesController,
              decoration: const InputDecoration.collapsed(hintText: 'images'),
            ),
            GestureDetector(
              onTap: () {
                createTeam();
              },
              child: const Text("tap me"),
            ),
          ],
        ),
      ),
    );
  }
}
