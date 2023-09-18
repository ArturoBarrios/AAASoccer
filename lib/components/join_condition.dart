import 'package:flutter/material.dart';

class JoinCondition extends StatefulWidget {
  ValueNotifier<bool> withRequest;

  JoinCondition({bool withRequest = false, required String label })
      : withRequest = ValueNotifier(withRequest);

  @override
  _JoinCondition createState() => _JoinCondition();
}

class _JoinCondition extends State<JoinCondition> {
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
