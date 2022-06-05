import 'package:flutter/material.dart';

class AnimatedDialogue extends StatefulWidget {
  const AnimatedDialogue({Key? key}) : super(key: key);

  @override
  State<AnimatedDialogue> createState() => _AnimatedDialogue();
}

class _AnimatedDialogue extends State<AnimatedDialogue> {
  bool visible = true;
  @override
  Widget build(BuildContext context){
    return AnimatedOpacity(
          // If the widget is visible, animate to 0.0 (invisible).
          // If the widget is hidden, animate to 1.0 (fully visible).
          opacity: visible ? 1.0 : 0.0,
          duration: const Duration(milliseconds: 100),
          // The green box must be a child of the AnimatedOpacity widget.
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.red,
          ),
        );
  }
}