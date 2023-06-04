import 'package:flutter/material.dart';

class CreateTeamRequest extends StatefulWidget {
  @override
  _CreateTeamRequest createState() => _CreateTeamRequest();
  bool withRequest = false;
}

class _CreateTeamRequest extends State<CreateTeamRequest> {
  // State variables go here

 

  @override
  Widget build(BuildContext context) {
    // Build method goes here
    
      return Container(
      child: Column(children: [
          Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Join With Request?"), 
            Checkbox(              
              value: widget.withRequest, 
              onChanged: (bool? value) {  
                setState(() {
                  widget.withRequest = value!;                
                });
              },              
            ),
          ]
        ),
        
      ]),
    );
    
  }
}
