import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../../commands/team_command.dart';
import '../../../commands/user_command.dart';
import '../../../testing/seeding/team_seeder.dart';
import '../../../testing/seeding/location_seeder.dart';
import '../../../components/profile.dart';
import '../../../models/app_model.dart';
import '../../home.dart';
import '../view.dart';

class TeamCreate extends StatefulWidget {
  @override
  _TeamCreateState createState() => _TeamCreateState();
}

class _TeamCreateState extends State<TeamCreate> {
  final nameController = TextEditingController();
  final colorController = TextEditingController();
  final logoController = TextEditingController();
  final imagesController = TextEditingController();
  int createTeamCurrentStep = 0;
  final createTeamTotalSteps = 3;
  

  bool _isLoading = false;

  void createTeam() async {
    print("createGame");
    Map<String, dynamic> createEventResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {      
      Map<String, dynamic> locationInput = {
        "latitude": AppModel().currentPosition.latitude,
        "longitude": AppModel().currentPosition.longitude,
      };
      print("locationInputCheck: " + locationInput.toString());                                  
     
      
        Map<String, dynamic> createTeamInput = {
          'name': nameController.text.trim(),
          'color': colorController.text.trim(),
          'logo': logoController.text.trim(),
          'images': imagesController.text.trim(),

          
          
        };
        Map<String, dynamic> createdTeamResp = await TeamCommand().createTeam(createTeamInput, locationInput);

          print("createdTeamResponse: " + createdTeamResp.toString());
        if (createdTeamResp['success']) {
          //now update view and app models that depend on this data
          print("now update view and app models that depend on this data");
          dynamic createdTeam = createdTeamResp['data'];
          print("createdTeam: " + createdTeam.toString());

          List<dynamic> userParticipants = createdTeam['userParticipants']['data'];
          //find the userParticipant that matches the current user
          dynamic currentUserParticipant;
          dynamic currentUser = UserCommand().getAppModelUser();
          for (var i = 0; i < userParticipants.length; i++) {
            if (userParticipants[i]['user']['_id'] == currentUser['_id']) {
              currentUserParticipant = userParticipants[i];
            }
          }
          TeamCommand().updateModelsWithTeam(createdTeam, currentUserParticipant);

          createEventResponse['success'] = true;
          //navigate home          
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );          
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeamView(teamObject: createdTeam, isMyTeam: true)),
          );          
           
        }
      
      // return createEventResponse;
    } on ApiException catch (e) {
      // return createEventResponse;
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
          child: Column(children: [
        TextField(
          controller: nameController,
          decoration: new InputDecoration.collapsed(hintText: 'Name'),
        ),
        TextField(
          controller: colorController,
          decoration: new InputDecoration.collapsed(hintText: 'Color'),
        ),
        TextField(
          controller: logoController,
          decoration: new InputDecoration.collapsed(hintText: 'Logo'),
        ),
        TextField(
          controller: imagesController,
          decoration: new InputDecoration.collapsed(hintText: 'images'),
        ),
        GestureDetector(
            onTap: () {
              createTeam();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
