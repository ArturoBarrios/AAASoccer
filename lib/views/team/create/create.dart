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
  final priceController = TextEditingController();

  CreateEventRequest createEventRequestWidget = new CreateEventRequest();
  CreateEventPayment createEventPaymentWidget = new CreateEventPayment();  
  DateTimePicker dateTimePicker = new DateTimePicker();
  LocationSearchBar locationSearchBar = new LocationSearchBar();
  

  bool _isLoading = false;

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
        };

        Map<String, dynamic> locationInput = {
          "latitude": locationSearchBar.coordinates.latitude,
          "longitude": locationSearchBar.coordinates.longitude,
        };

        Map<String, dynamic> createdTeamResp = await TeamCommand().createTeam(createTeamInput, locationInput);

          print("createdTeamResponse: " + createdTeamResp.toString());
        if (createdTeamResp['success']) {
          //now update view and app models that depend on this data
          print("now update view and app models that depend on this data");
          dynamic createdTeam = createdTeamResp['data'];
          print("createdTeam: " + createdTeam.toString());


          dynamic userTeamDetails = await TeamCommand().getUserTeamDetails(createdTeam);
          

          //navigate home          
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => Home()),
          );          
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => TeamView(teamObject: createdTeam)),
          );          
           
          createEventResponse['success'] = true;
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
        locationSearchBar,
        createEventRequestWidget,
        createEventPaymentWidget,
        dateTimePicker,
        TextField(
          controller: priceController,
          decoration: new InputDecoration.collapsed(hintText: 'Price'),
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
