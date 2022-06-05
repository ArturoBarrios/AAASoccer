import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';

class SelectIconButton extends StatefulWidget {
  const SelectIconButton({Key? key}) : super(key: key);

  @override
  State<SelectIconButton> createState() => _SelectIconButton();
}

class _SelectIconButton extends State<SelectIconButton> {
  @override
  Widget build(BuildContext context) {
     return 
     SizedBox(
       height: MediaQuery.of(context).size.height * .1,
       width: MediaQuery.of(context).size.width *.2,
       child: ElevatedButton(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: const <Widget>[
              Icon(Icons.volume_up, size: 20),
                AutoSizeText(
                  'A really long string',
                  style: TextStyle(fontSize: 1),
                  maxLines: 1
                )
              
            ],
          ),
          onPressed: () {},
        ),
    );
  }
}