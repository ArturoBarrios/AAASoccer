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
            child: 
            
              BasicElevatedButton())

        ]),
        
    ));
  }
}


// new GestureDetector(
    //     onTap: (){
    //       print("Container clicked");
    //     },
    //     child: new Container(
    //       width: 500.0,
    //       padding: new EdgeInsets.fromLTRB(20.0, 40.0, 20.0, 40.0),
    //       color: Colors.green,
    //       child: new Column(
    //           children: [
    //             new Text("Ableitungen"),
    //           ]
    //       ),
    //     )
    // );


