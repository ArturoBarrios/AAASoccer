import 'package:flutter/material.dart';

import '../commands/subscriptions_command.dart';

class PlaygroundWidget extends StatefulWidget {
  @override
  _PlaygroundWidgetState createState() => _PlaygroundWidgetState();
}

class _PlaygroundWidgetState extends State<PlaygroundWidget> {
  // Add your state variables and methods here
  List<String> items = []; // You can replace this with your actual data

  // This is a method to simulate adding more items to the list.
  void addItem() {
    setState(() {
      items.add('New Item ${items.length + 1}');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Playground Widget'),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          TextButton(
            onPressed: () {
              // This is where you'd typically handle the button press.
              // You could, for example, navigate to another screen.
              print('Create Subscription button pressed');              
            },
            child: Text(
              'Create Subscription',
              style: TextStyle(
                color: Colors.blue, // you can customize the color here
              ),
            ),
          )
        ]),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: addItem,
        child: Icon(Icons.add),
      ),
    );
  }
}
