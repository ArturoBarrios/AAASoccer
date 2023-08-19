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
  final capacityController = TextEditingController();
  int createTeamCurrentStep = 0;
  final createTeamTotalSteps = 3;
  final priceController = TextEditingController();
  bool isLoading = false;
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

  Future<void> createTeam() async {
    print("createGame");
    setState(() {
      isLoading = true;
    });
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
        'capacity': capacityController.text.trim(),
        'price': double.parse(priceController.text.toString()),
        'withRequest': createEventRequestWidget.withRequest.value,
        'withPayment': createEventPaymentWidget.withPayment.value,
        'roles': "{PLAYER, ORGANIZER}",
        'createdAt': dateTimePicker.rightNow.millisecondsSinceEpoch.toString(),
        'updatedAt': dateTimePicker.rightNow.millisecondsSinceEpoch.toString(),
      };

      Map<String, dynamic> createdTeamResp = await TeamCommand().createTeam(
        createTeamInput,
        locationInput,
      );

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
        setState(() {
          isLoading = false;
        });
      }
    } on ApiException catch (_) {
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: const Padding(
          padding: EdgeInsets.only(left: 20.0),
          child: Text("Find Soccer Near You"),
        ),
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(
              height: 24,
            ),
            TextField(
              controller: nameController,
              decoration: const InputDecoration(
                hintText: 'Name',
                labelText: 'Name',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: colorController,
              decoration: const InputDecoration(
                hintText: 'Color',
                labelText: 'Color',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            locationSearchBar,
            createEventRequestWidget,
            createEventPaymentWidget,
            dateTimePicker,
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: priceController,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              decoration: const InputDecoration(
                hintText: 'Price',
                labelText: 'Price',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: imagesController,
              decoration: const InputDecoration(
                hintText: 'images',
                labelText: 'images',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            TextField(
              controller: capacityController,
              keyboardType: const TextInputType.numberWithOptions(signed: true),
              decoration: const InputDecoration(
                hintText: 'Team Capacity',
                labelText: 'Team Capacity',
                border: InputBorder.none,
                filled: true,
              ),
            ),
            const SizedBox(
              height: 8,
            ),
            FilledButton(
              onPressed: () {
                createTeam();
              },
              child: isLoading
                  ? const SizedBox(
                      width: 24,
                      height: 24,
                      child: CircularProgressIndicator(
                        color: Colors.white,
                      ),
                    )
                  : const Text("Create Team"),
            ),
            const SizedBox(
              height: 32,
            ),
          ],
        ),
      ),
    );
  }
}
