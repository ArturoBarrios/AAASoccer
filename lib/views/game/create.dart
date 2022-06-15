import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../commands/game_command.dart';
import '../../commands/event_command.dart';

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
  final imagesController = TextEditingController();

  bool _isLoading = false;

  Future<Map<String, dynamic>> createPickupGame() async {
    print("createGame");
    Map<String, dynamic> createPickupGameResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {
      Map<String, dynamic> createGameInput = {
        "hometeam": hometeamController.text.trim(),
        "awayTeam": awayteamController.text.trim(),
        "pickup": isPickupController.text.trim()
      };
      Map<String, dynamic> createdGame =
          await GameCommand().createGame(createGameInput);
      if(createdGame['success']){
        
        Map<String, dynamic> createEventInput = {
          "name": nameController.text.trim(),
          "gameId": createdGame['data'].id,
          "price": priceController.text.trim(),
          "location": locationController.text.trim(),
          "images": imagesController.text.trim()
        };
        Map<String, dynamic> createdEvent =
            await EventCommand().createEvent(createEventInput);
        if(createdEvent['success']){
          createPickupGameResponse['success'] = true;
        }
      }
      return createPickupGameResponse;
    } on ApiException catch (e) {
      return createPickupGameResponse;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              createPickupGame();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
