import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../commands/team_command.dart';

class TeamCreate extends StatefulWidget {
  @override
  _TeamCreateState createState() => _TeamCreateState();
}

class _TeamCreateState extends State<TeamCreate> {
  final nameController = TextEditingController();
  final colorController = TextEditingController();
  final logoController = TextEditingController();
  final imagesController = TextEditingController();
  

  bool _isLoading = false;

  Future<Map<String, dynamic>> createTeam() async {
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

          
          
        };
        Map<String, dynamic> createdTeam =
            await TeamCommand().createTeam(createTeamInput);

        if (createdTeam['success']) {
          createEventResponse['success'] = true;
        }
      
      return createEventResponse;
    } on ApiException catch (e) {
      return createEventResponse;
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
