import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../commands/tournament_command.dart';
import '../../commands/event_command.dart';
import '../../models/EventType.dart';

class TournamentCreate extends StatefulWidget {
  @override
  _TournamentCreateState createState() => _TournamentCreateState();
}

class _TournamentCreateState extends State<TournamentCreate> {
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

  Future<Map<String, dynamic>> createTournament() async {
    print("createGame");
    Map<String, dynamic> createEventResponse = {
      "success": false,
      "message": "Default Error"
    };
    // try {
    //   Map<String, dynamic> createEventInput = {
    //     "name": nameController.text.trim(),
    //     "price": priceController.text.trim(),
    //     "location": locationController.text.trim(),
    //     "images": imagesController.text.trim(),
    //     "type": EventType.TOURNAMENT,
    //   };

    //   Map<String, dynamic> createdEvent =
    //       await EventCommand().createEvent(createEventInput);
    // print("createdEvent: ");
    // print(createdEvent['data']);
    //   if (createdEvent['success']) {
    //     Map<String, dynamic> createTournamentInput = {
          
          
    //       "tournamentEventId": createdEvent['data'].id
    //     };
    //     Map<String, dynamic> createdTournament =
    //         await TournamentCommand().createTournament(createTournamentInput, eventInput);

    //     if (createdTournament['success']) {
    //       createEventResponse['success'] = true;
        // }
      // }
      // return createEventResponse;
    // } on ApiException catch (e) {
      return createEventResponse;
    // }
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
              createTournament();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
