import 'package:flutter/material.dart';

class CreateEventPayment extends StatefulWidget {
  @override
  _CreateEventPayment createState() => _CreateEventPayment();
  bool withPayment = false;
}

class _CreateEventPayment extends State<CreateEventPayment> {
  // State variables go here

  @override
  Widget build(BuildContext context) {
    // Build method goes here
    
      return Container(
      child: Column(children: [
          
        Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text("Join With Payment?"), 
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
