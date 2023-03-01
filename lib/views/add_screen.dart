import 'package:amplify_api/amplify_api.dart';
import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/Buttons/basic_elevated_button.dart';
import '../../commands/location_command.dart';

class AddScreen extends StatefulWidget {
  @override
  _AddScreenState createState() => _AddScreenState();
}

class _AddScreenState extends State<AddScreen> {
  List events = [
    'Pickup Game',
    'Tournament',
    'Training',
    'League',
    'Tryout',
    
  ];

  bool _isLoading = false;  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Column(children: [
        
        
        GestureDetector(
            onTap: () {
              // createLocation();
            },
            child: Text("tap me")),
      ])),
    );
  }
}
