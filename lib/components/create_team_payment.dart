import 'package:flutter/material.dart';

class CreateTeamPayment extends StatefulWidget {
  @override
  _CreateTeamPayment createState() => _CreateTeamPayment();
  bool withPayment = false;
}

class _CreateTeamPayment extends State<CreateTeamPayment> {
  // State variables go here

  @override
  Widget build(BuildContext context) {
    // Build method goes here
    
      return Container(
      child: Column(children: [
          
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Join With Team Payment?"), 
            Checkbox(              
              value: widget.withPayment, 
              onChanged: (bool? value) {    
                  setState(() {            
                      widget.withPayment = value!;                
                  });                               
              },
              
            ),
          ]
        ),
      ]),
    );
    
  }
}
