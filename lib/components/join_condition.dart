import 'package:flutter/material.dart';

class JoinCondition extends StatefulWidget {
  ValueNotifier<bool> required;
  final String label;

  JoinCondition({bool required = false, required String this.label })
      : required = ValueNotifier(required);

  @override
  _JoinCondition createState() => _JoinCondition();
}

class _JoinCondition extends State<JoinCondition> {
  bool showUpdateButton = false;
  bool requiredOriginal = false;

  void updateEventRequest() {
    print("updateEventRequest");
    setState(() {      
      showUpdateButton = false;
    });
  }
  
  void onChanged(bool newValue) {
    print("updateEventRequest");
    setState(() {
      widget.required.value = newValue;
      print("requiredOriginal: " + requiredOriginal.toString());
      print("newValue: " + newValue.toString());
      print("requiredOriginal != newValue: " + (requiredOriginal != newValue).toString());
      if(requiredOriginal.toString() != newValue.toString()){
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
    requiredOriginal = widget.required.value;
  }

  @override
  Widget build(BuildContext context) {    

    return ValueListenableBuilder(
      valueListenable: widget.required,
      builder: (context, bool value, _) {
        return Container(
          child: Column(children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(widget.label),
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
