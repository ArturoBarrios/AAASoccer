import 'package:flutter/material.dart';
import '../components/profile.dart';
import '../../views/chat/view.dart';

class Headers extends StatefulWidget {
  const Headers({Key? key}) : super(key: key);

  @override
  State<Headers> createState() => _Headers();


AppBar getMainHeader(BuildContext context){
  AppBar appBar = AppBar(
        elevation: 2,
        centerTitle: false,
        title: new Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text("Find Soccer Near You")),
        backgroundColor: Colors.orange.shade500,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_active),
            tooltip: 'Notifications',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return ChatView();
                },
              ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.message),
            tooltip: 'Messages',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return ChatView();
                },
              ));
            },
          ),
          IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Go to the next page',
            onPressed: () {
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Profile();
                },
              ));
            },
          ),
        ],
      );

      return appBar;
}

AppBar getBackHeader(BuildContext context){
  AppBar appBar = AppBar(
        elevation: 2,
        centerTitle: false,
        title: new Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: 
             IconButton(
                icon: const Icon(Icons.keyboard_backspace_sharp),
                tooltip: 'Notifications',
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
        backgroundColor: Colors.orange.shade500,
        actions: <Widget>[
        
        ],
      );

      return appBar;

}
  

  
}




class _Headers extends State<Headers> {
  void onTapMenu(){

  }
  final title="Jefferson";
  final upperTitle = "Welcome back,";
  
  @override
  Widget build(BuildContext context) {
    return AppBar(
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
              Navigator.push(context, MaterialPageRoute<void>(
                builder: (BuildContext context) {
                  return Profile();
                },
              ));
            },
          ),
        ],
      );
  }
}
