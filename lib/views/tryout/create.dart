import 'dart:math';
import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../commands/tryout_command.dart';
import '../../commands/event_command.dart';
import '../../components/profile.dart';
import '../../components/headers.dart';
import '../../testing/seeding/event_seeder.dart';

class TryoutCreate extends StatefulWidget {
  @override
  _TryoutCreateState createState() => _TryoutCreateState();
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

  bool _isLoading = false;

  

  Future<Map<String, dynamic>> createTryout() async {
    print("createGame");
    Map<String, dynamic> createEventResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      var rng = Random();
       Map<String, dynamic> eventInput = {        
        "name": "Tryout " + rng.nextInt(100000000).toString(),
        'isMainEvent': true,        
        'price':  "10"//int.parse(priceController.text.toString())
      };

      Map<String, dynamic> randomPickupData = EventSeeder().getRandomTryoutData();      
      Map<String, dynamic> locationInput = {
        "latitude": 39.9526,
        "longitude": 75.1652,
      };
      print("locationInputCheck: " + locationInput.toString());  

      Map<String, dynamic> createTryoutResp = await TryoutCommand().createTryout(randomPickupData, eventInput, locationInput);                                      
      print("createTryoutResp: "+ createTryoutResp.toString());
                    
      return createEventResponse;
      }
       on ApiException catch (e) {
      return createEventResponse;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headers().getMainHeader(context),
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
          controller: locationController,
          decoration: new InputDecoration.collapsed(hintText: 'Location'),
        ),
        TextField(
          controller: imagesController,
          decoration: new InputDecoration.collapsed(hintText: 'Images'),
        ),
        GestureDetector(
            onTap: () {
              createTryout();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
