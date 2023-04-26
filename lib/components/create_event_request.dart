import 'package:flutter/material.dart';

class CreateEventRequest extends StatefulWidget {
  @override
  _CreateEventRequest createState() => _CreateEventRequest();
  bool withRequest = false;
}

class _CreateEventRequest extends State<CreateEventRequest> {
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
