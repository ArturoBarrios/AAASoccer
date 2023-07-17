import 'package:flutter/material.dart';


class CongratsDialogue extends StatefulWidget {
  CongratsDialogue({Key? key, required this.popToHome}) : super(key: key);

  final Function popToHome;

  @override
  _CongratsDialogueState createState() => _CongratsDialogueState();
}

class _CongratsDialogueState extends State<CongratsDialogue> {

  @override
  Widget build(BuildContext context) {
    return Dialog(
      insetPadding: EdgeInsets.zero,
      child: Stack(
        alignment: Alignment.center,
        children: <Widget>[
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
            ),
            child: Column(
              children: [
                Expanded(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min, // takes minimum space
                      children: [
                        Icon(
                          Icons.event,
                          size: 50.0,
                        ),
                        SizedBox(height: 10),  // add some space between the icon and the text
                        Text(
                          'Congrats!',
                          style: TextStyle(fontSize: 30),
                        ),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: TextButton(
                    child: Text('Back to Event'),
                    onPressed: () {
                      Navigator.of(context).pop(); // closes the dialog
                    },
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            right: 0.0,
            top: 0.0,
            child: TextButton(
              child: Icon(Icons.close),
              onPressed: () {
                Navigator.of(context).pop(); // closes the dialog
                widget.popToHome();                                

              },
            ),
          ),
        ],
      ),
    );
  }
}
