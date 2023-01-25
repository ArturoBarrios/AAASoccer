import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../commands/league_command.dart';
import '../../commands/event_command.dart';
import '../../models/app_model.dart';
import '../../testing/seeding/location_seeder.dart';
import '../../components/profile.dart';

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

  bool _isLoading = false;

  Future<Map<String, dynamic>> createLeague() async {
    print("createLeague");
    Map<String, dynamic> createEventResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      Map<String, dynamic> createEventInput = {
        "name": nameController.text.trim(),
        "price": priceController.text.trim(),
        'isMainEvent': true,   
      };
      
        // Map<String, dynamic> generateRandomLocation = await LocationSeeder().generateRandomLocation(LocationSeeder().locations[0]);
        Map<String, dynamic> locationInput = {
          "latitude": AppModel().currentPosition.latitude,
          "longitude": AppModel().currentPosition.longitude
        };//generateRandomLocation["data"]["randomLocation"];
        print("locationInputCheck: " + locationInput.toString());   
        Map<String, dynamic> createLeagueInput = {
          "numberOfTeams": 2,
        };
        Map<String, dynamic> createdLeague =
            await LeagueCommand().createLeague(createLeagueInput, createEventInput, locationInput);
        print("createdLeague: " + createdLeague.toString());
        if (createdLeague['success']) {
          //update models that depend on league data
          LeagueCommand().updateLeagueData(createdLeague['data']);
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
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Profile();
                },
              ));
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
        TextField(
          controller: priceController,
          decoration: new InputDecoration.collapsed(hintText: 'Price'),
        ),
        TextField(
          controller: numberOfTeamsController,
          decoration: new InputDecoration.collapsed(hintText: 'Number of Teams'),
        ),
        TextField(
          controller: isPickupController,
          decoration: new InputDecoration.collapsed(hintText: 'Pickup'),
        ),
        TextField(
          controller: surfaceController,
          decoration: new InputDecoration.collapsed(hintText: 'Surface'),
        ),
        TextField(
          controller: fieldSizeController,
          decoration: new InputDecoration.collapsed(hintText: 'Field Size'),
        ),
        TextField(
          controller: privateController,
          decoration: new InputDecoration.collapsed(hintText: 'Private'),
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
              createLeague();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
