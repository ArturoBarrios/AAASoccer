import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../../commands/team_command.dart';
import '../../../commands/user_command.dart';
import '../../../components/create_event_payment.dart';
import '../../../components/create_event_request.dart';
import '../../../components/date_time_picker.dart';
import '../../../components/location_search_bar.dart';
import '../../../testing/seeding/team_seeder.dart';
import '../../../testing/seeding/location_seeder.dart';
import '../../../components/profile.dart';
import '../../../models/app_model.dart';

class OrganizerCreate extends StatefulWidget {
  @override
  _OrganizerCreateState createState() => _OrganizerCreateState();
}

class _OrganizerCreateState extends State<OrganizerCreate> {
  final nameController = TextEditingController();
  final colorController = TextEditingController();
  final logoController = TextEditingController();        
  LocationSearchBar locationSearchBar = new LocationSearchBar();
  

  bool _isLoading = false;

  void createOrganization() async {
    print("createOrganization");
    Map<String, dynamic> createOrganizationResponse = {
      "success": false,
      "message": "Default Error"
    };
    try {                       
        Map<String, dynamic> createOrganizationInput = {
          'name': nameController.text.trim(),                                        
          'roles': "{ORGANIZER}",          
        };

        Map<String, dynamic> locationInput = {
          "name": locationSearchBar.address,
          "latitude": locationSearchBar.coordinates.latitude,
          "longitude": locationSearchBar.coordinates.longitude,
        };
      
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
        locationSearchBar,        
        
        GestureDetector(
            onTap: () {
              createOrganization();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
