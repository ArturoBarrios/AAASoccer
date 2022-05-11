import 'package:flutter/material.dart';

class BasicElevatedButton extends StatefulWidget {
  const BasicElevatedButton({Key? key}) : super(key: key);

  @override
  State<BasicElevatedButton> createState() => _BasicElevatedButton();
}


class _BasicElevatedButton extends State<BasicElevatedButton> {
 bool visible = false;
  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle =
        ElevatedButton.styleFrom(textStyle: const TextStyle(fontSize: 20));

    return SizedBox(
          height: 30,
          child: ElevatedButton(
            style: buttonStyle,
            onPressed: () {visible = !visible;},
            child: 
              const Text('Enabled'),
        )   
    );
  }
}