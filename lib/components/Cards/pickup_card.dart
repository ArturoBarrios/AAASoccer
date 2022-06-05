import 'package:flutter/material.dart';
//components
import '../Buttons/basic_elevated_button.dart';

class PickupCard extends StatefulWidget {
  const PickupCard({Key? key}) : super(key: key);

  @override
  State<PickupCard> createState() => _PickupCard();
}

class _PickupCard extends State<PickupCard> {
  bool visible = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      
      height: 150,
      width: MediaQuery.of(context).size.width * 1,
      child: Card(
        color: Colors.red,
        child: Row(children: const <Widget> [
          Text("test"),
          Align(
            alignment: Alignment.bottomCenter,
            child: BasicElevatedButton())

        ]),
        
    ));
  }
}


