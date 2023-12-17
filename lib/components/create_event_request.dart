import 'package:flutter/material.dart';

class CreateEventRequest extends StatefulWidget {
  ValueNotifier<bool> withRequest;

  CreateEventRequest({bool withRequest = false})
      : withRequest = ValueNotifier(withRequest);

  @override
  _CreateEventRequest createState() => _CreateEventRequest();
}

class _CreateEventRequest extends State<CreateEventRequest> {
  bool showUpdateButton = false;
  bool withRequestOriginal = false;

  void updateEventRequest() {
    print("updateEventRequest");
    setState(() {      
      showUpdateButton = false;
    });
  }
  
  void onChanged(bool newValue) {
    print("updateEventRequest");
    setState(() {
      widget.withRequest.value = newValue;
      print("withRequestOriginal: " + withRequestOriginal.toString());
      print("newValue: " + newValue.toString());
      print("withRequestOriginal != newValue: " + (withRequestOriginal != newValue).toString());
      if(withRequestOriginal.toString() != newValue.toString()){
        showUpdateButton = true;
      }   
      else{
        showUpdateButton = false;
      }         
    });
    print("showUpdateButton: " + showUpdateButton.toString());
  }

  @override 
  initState(){
    withRequestOriginal = widget.withRequest.value;
  }

  @override
  Widget build(BuildContext context) {    

    return ValueListenableBuilder(
      valueListenable: widget.withRequest,
      builder: (context, bool value, _) {
        return Container(
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text("Join With Request?"),
                Checkbox(                  
                  value: value,
                  onChanged: (bool? newValue) {
                    onChanged(newValue!);
                    
                    
                  },
                ),
                if(showUpdateButton)
                TextButton(
                  onPressed: () => updateEventRequest(),
                  child: Text(
                    'Confirm Request Update',
                    style: TextStyle(color: Colors.blue),
                  ),
                ),

              ],
            ),
          ]),
        );
      },
    );
  }
}
