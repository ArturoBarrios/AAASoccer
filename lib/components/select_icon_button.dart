import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../commands/home_page_command.dart';
import '../models/home_page_model.dart';

class SelectIconButton extends StatefulWidget {
  const SelectIconButton(
      {Key? key, required this.eventObject, required this.svgImage, required this.index})
      : super(key: key);  
  final dynamic eventObject; 
  final Svg svgImage;
  final double bevel = 10.0;  
  final int index;  
  



  @override
  State<SelectIconButton> createState() => _SelectIconButton();
}

class _SelectIconButton extends State<SelectIconButton> {
  final bool _isPressed = false;
    final Color color = Colors.grey.shade200;    
    final Color selectedColor = Colors.orange.shade500;    
  
  final ButtonStyle style =
        ElevatedButton.styleFrom(primary: Colors.orange.shade500, textStyle: const TextStyle(fontSize: 20));
  final imageUrl = "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555";
  @override
  Widget build(BuildContext context) {  
  print("eventObject: " + widget.eventObject.toString());  
  print("eventObjectKey: " + widget.index.toString());
   

    return Listener(
      
      child: GestureDetector(
        onTap: () {
          print("onTap EventType");          
          HomePageCommand().eventTypeTapped(widget.index);

        },
        child: AnimatedContainer(   
                 
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.all(12.5),
          decoration: BoxDecoration(            
            borderRadius: BorderRadius.circular(10.0 * 1),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  widget.eventObject['enabled'] ? selectedColor : color,
                  widget.eventObject['enabled'] ? selectedColor : color,
                  widget.eventObject['enabled'] ? selectedColor : color,
                  widget.eventObject['enabled'] ? selectedColor : color,                  
                ],
                stops: const [
                  0.0,
                  .3,
                  .6,
                  1.0,
                ]),
            boxShadow: _isPressed
                ? null
                : [
                    // BoxShadow(
                    //   blurRadius: 10.0,
                    //   offset: -Offset(10.0/2, 10.0/2),
                    //   color: Colors.white,
                    // ),
                    // BoxShadow(
                    //   blurRadius: widget.bevel,
                    //   offset: Offset(10.0/2, 10.0/2),
                    //   color: Colors.black,
                    // )
                  ],
          ),
          child: Text("test"),
          // Container(
          //     child: 
          //     InnerNeumorphicCardFb1(
          //         text: widget.eventObject['name'],
          //         svgImage:
          //             widget.eventObject['image'],
          //         subtitle: widget.eventObject['description'],
          //         onPressed: () {}))
                  )
                  ),
    );
  }

}

class InnerNeumorphicCardFb1 extends StatefulWidget {
  final String text;
  final Svg svgImage;
  final String subtitle;
  final Function() onPressed;
 @override
  State<SelectIconButton> createState() => _SelectIconButton();

  const InnerNeumorphicCardFb1(
      {required this.text,
      required this.svgImage,
      required this.subtitle,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
  final double cardWidth = MediaQuery.of(context).size.width * .4;
  final double cardHeight = MediaQuery.of(context).size.height * .1;
  final double cardImageWidth = cardWidth * .5;
  final double cardImageHeight = cardHeight * .5;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: cardWidth,
        height: cardHeight,
        padding: const EdgeInsets.all(15.0),
       
        child: Column(
          children: [
            Image(          
          width: cardImageWidth,
          height: cardImageHeight,                          
          image: svgImage,
          color: Colors.white,
              ),
            const Spacer(),
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
           
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.grey,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
            
          ],
        ),
      ),
    );
  }
}

