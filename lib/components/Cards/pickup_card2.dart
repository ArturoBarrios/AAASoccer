import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';

class PickupCard2 extends StatefulWidget {
  const PickupCard2(
      {Key? key, required this.eventObject, required this.svgImage})
      : super(key: key);
  final Map<String,dynamic> eventObject;  
  final Svg svgImage;
  final double bevel = 10.0;  

  @override
  State<PickupCard2> createState() => _PickupCard2();
}

class _PickupCard2 extends State<PickupCard2> {
  final bool _isPressed = false;
    final Color color = Colors.grey.shade200;    
  
  final ButtonStyle style =
        ElevatedButton.styleFrom(primary: Colors.orange.shade500, textStyle: const TextStyle(fontSize: 20));
  final imageUrl = "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555";
  @override
  Widget build(BuildContext context) {

    return Listener(
      child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: EdgeInsets.all(12.5),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10.0 * 1),
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  color,
                  color,
                  color,
                  color,
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
                    BoxShadow(
                      blurRadius: 10.0,
                      offset: -Offset(10.0/2, 10.0/2),
                      color: Colors.white,
                    ),
                    BoxShadow(
                      blurRadius: widget.bevel,
                      offset: Offset(10.0/7, 10.0/7),
                      color: Colors.black38,
                    )
                  ],
          ),
          child: Container(
              child: InnerNeumorphicCardFb1(
                  text: widget.eventObject['name'],
                  svgImage:
                      widget.eventObject['image'],
                  subtitle: widget.eventObject['description'],
                  onPressed: () {
                    
                  }))),
    );
  }

}

class InnerNeumorphicCardFb1 extends StatelessWidget {
  final String text;
  final Svg svgImage;
  final String subtitle;
  final Function() onPressed;

  const InnerNeumorphicCardFb1(
      {required this.text,
      required this.svgImage,
      required this.subtitle,
      required this.onPressed,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        width: 150,
        height: 150,
        padding: const EdgeInsets.all(15.0),
       
        child: Column(
          children: [
            Image(          
          width: MediaQuery.of(context).size.width * .4,
          height: MediaQuery.of(context).size.height * .1,                          
          image: svgImage,
          color: Colors.white,
              ),
            // Image.network(imageUrl, height: 59, fit: BoxFit.cover),
            const Spacer(),
            Text(text,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                )),
            const SizedBox(
              height: 5,
            ),
            Text(
              subtitle,
              textAlign: TextAlign.center,
              style: const TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.normal,
                  fontSize: 12),
            ),
            const SizedBox(
              height: 10,
            ),
          ],
        ),
      ),
    );
  }
}

