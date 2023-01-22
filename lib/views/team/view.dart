import 'package:flutter/material.dart';

class TeamView extends StatefulWidget {
  const TeamView(
      {Key? key, required this.teamObject})
      : super(key: key);
  final Map<String, dynamic> teamObject;

  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {   
  bool _isLoading = false;

  void goBack(){
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    print("build() in TeamView");
    print("teamObject: "+widget.teamObject.toString());
    return Scaffold(
      body: Center(
          child: Column(children: [
        
        GestureDetector(
            onTap: () {
              goBack();
            },
            child: Text("Back to Home")),
      ])),
    );
  }
}
