import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class SelectIconButton extends StatefulWidget {
  const SelectIconButton(
      {Key? key, required this.title, required this.svgImage})
      : super(key: key);
  final String title;
  final Svg svgImage;
  @override
  State<SelectIconButton> createState() => _SelectIconButton();
}

class _SelectIconButton extends State<SelectIconButton> {
  @override
  Widget build(BuildContext context) {
    return 
       Stack(children: <Widget>[
        SizedBox(
          height: MediaQuery.of(context).size.height * .1,
          width: MediaQuery.of(context).size.width * .4,
          child: ElevatedButton(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                AutoSizeText('${widget.title}',
                    style: TextStyle(fontSize: 25), maxLines: 1)
              ],
            ),
            onPressed: () {},
          ),
        ),
        Image(          
          width: MediaQuery.of(context).size.width * .4,
          height: MediaQuery.of(context).size.height * .1,                          
          image: widget.svgImage,
          color: Colors.white,
              ),
    ]);
  }
}
