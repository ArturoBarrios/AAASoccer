import 'dart:ffi';
import 'dart:math';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../components/location_search_bar.dart';
import '../../commands/game_command.dart';
import '../../commands/game_command.dart';
import '../../commands/location_command.dart';
import '../../commands/event_command.dart';
import '../../testing/seeding/event_seeder.dart';
import '../../testing/seeding/location_seeder.dart';
import '../../components/profile.dart';
import '../../views/home.dart';
import 'package:geocoder/geocoder.dart';

class GameCreate extends StatefulWidget {
  @override
  _GameCreateState createState() => _GameCreateState();
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
  final locationController = TextEditingController();
  Coordinates coordinates = new Coordinates(0, 0);
  final imagesController = TextEditingController();

  bool _isLoading = false;


  void chooseAddress(String chosenAddress) async {
    print("chooseAddress");
    locationController.text = chosenAddress;
    List<Address> addresses = await Geocoder.local.findAddressesFromQuery(chosenAddress);
    Address address = addresses.first;
    print("address: " + address.toString());
    coordinates = address.coordinates;
    print("coordinates: " + coordinates.toString());
    coordinates.latitude;
    coordinates.longitude;
    // LocationCommand().translateAddressToLocation(location);
  }

  Future<void> createPickupGame() async {
    print("createGame");
    Map<String, dynamic> createPickupGameResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      var rng = Random();
      print("priceee: " + priceController.text.toString());
      Map<String, dynamic> eventInput = {
        "name": nameController.text.toString(),
        'isMainEvent': true,
        'price': int.parse(priceController.text.toString())
      };

      Map<String, dynamic> randomPickupData =
          EventSeeder().getRandomPickupGameData();
      // Map<String, dynamic> generateRandomLocation = await LocationSeeder().generateRandomLocation(LocationSeeder().locations[0]);
      Map<String, dynamic> locationInput = {
        "latitude": coordinates.latitude,
        "longitude": coordinates.longitude,
      };
      // Map<String, dynamic> locationInput = generateRandomLocation["data"]["randomLocation"];
      print("locationInputCheaheck: " + locationInput.toString());

      Map<String, dynamic> createPickupGameResp = await GameCommand()
          .createGame(randomPickupData, eventInput, locationInput);
      print("createPickupGameResp: ");
      print(createPickupGameResp['data']);
      if (createPickupGameResp['success']) {
        Map<String, dynamic> pickupGame = createPickupGameResp['data'];
        Map<String, dynamic> event = pickupGame['event'];
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => Home()),
        );
      }
    } on ApiException catch (e) {}
  }

  void goBack() {
    Navigator.pop(context);
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
          controller: hometeamController,
          decoration: new InputDecoration.collapsed(hintText: 'Home'),
        ),
        // TextField(
        //   controller: locationController,
        //   decoration: new InputDecoration.collapsed(hintText: 'Location'),
        //   onChanged: (value) async => {
        //     await LocationCommand().place_api_autocomplete(value),
        //   }),

        LocationSearchBar(chooseAddress: chooseAddress,),

        TextField(
          controller: awayteamController,
          decoration: new InputDecoration.collapsed(hintText: 'Away'),
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
          controller: priceController,
          decoration: new InputDecoration.collapsed(hintText: 'Price'),
        ),
        TextField(
          controller: imagesController,
          decoration: new InputDecoration.collapsed(hintText: 'Images'),
        ),
        GestureDetector(
            onTap: () {
              createPickupGame();
            },
            child: Text("Create")),
        GestureDetector(
            onTap: () {
              goBack();
            },
            child: Text("Back to Home")),
      ])),
    );
  }
}
