import 'package:flutter/material.dart';
import '../models/home_page_model.dart';

class AnimatedDialogue extends StatefulWidget {
  final bool? isVisible;

  const AnimatedDialogue({Key? key, this.isVisible}) : super(key: key);

  @override
  State<AnimatedDialogue> createState() => _AnimatedDialogue();
}

class _AnimatedDialogue extends State<AnimatedDialogue> {
  @override
  Widget build(BuildContext context){
    return AnimatedOpacity(
          // If the widget is visible, animate to 0.0 (invisible).
          // If the widget is hidden, animate to 1.0 (fully visible).
          opacity: widget.isVisible == true ? 1.0 : 0.0,
          duration: const Duration(seconds: 0),
          // The green box must be a child of the AnimatedOpacity widget.
          child: Container(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height,
            color: Colors.red,
            
          ),
        );
  }
}