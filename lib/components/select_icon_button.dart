import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/views/home.dart';
import '../commands/home_page_command.dart';
import '../constants.dart';
import '../models/pageModels/home_page_model.dart';
import '../styles/colors.dart';
import '../styles/font_sizes.dart';

class SelectIconButton extends StatefulWidget {
   SelectIconButton(
      {Key? key,
      required this.eventObject,
      required this.svgImage,
      required this.index,      
      this.onTapEvent,
      this.showNew
      })
      : super(key: key);
  final dynamic eventObject;
  final Svg svgImage;
  final double bevel = 10.0;
  final int index;
  final VoidCallback? onTapEvent;
   bool? showNew;

  @override
  State<SelectIconButton> createState() => _SelectIconButton();
}

class _SelectIconButton extends State<SelectIconButton> {
  final bool _isPressed = false;
  final Color color = Colors.grey.shade200;
  final Color selectedColor = Colors.orange.shade500;

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.orange.shade500,
      textStyle: const TextStyle(fontSize: 20));
  final imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555";
  @override
  Widget build(BuildContext context) {
    print("eventObject: " + widget.eventObject.toString());
    print("eventObjectKey: " + widget.index.toString());

    final double cardWidth = MediaQuery.of(context).size.width * .2;
    final double cardHeight = MediaQuery.of(context).size.height * .1;
    final double cardImageWidth = cardWidth * .2;
    final double cardImageHeight = cardHeight * .2;

    print("showNew: " + widget.showNew.toString());
    return GestureDetector(
        onTap: () async {
          print("onTap EventType");
          widget.onTapEvent?.call();
          await HomePageCommand().eventTypeTapped(widget.eventObject['key']);
          await HomePageCommand().setCards();
          if(widget.eventObject['key'] == Constants.REQUESTSRECEIVED){
            print("niceeeeeeeeeeeeee");
            widget.showNew = false;
          }
        },
        child: Container(
          width: cardWidth,
          height: cardHeight,
          padding: const EdgeInsets.all(15.0),
          color: Colors.transparent,
          child: 
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image(
                width: cardImageWidth,
                height: cardImageHeight,
                image: widget.svgImage,
                color: widget.eventObject['enabled']
                    ? AppColors.tsnLightGreen
                    : AppColors.tsnGrey,
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    widget.eventObject['name'],
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.tsnDarkGrey,
                      fontWeight: FontWeight.bold,
                      fontSize: FontSizes.xxs(context),
                    ),
                  ),
                  (widget.showNew != null && widget.showNew! )? 
                  Container(
                    margin: EdgeInsets.only(
                        left: 0), // Adjust space between text and dot
                    width: 10, // Size of the red dot
                    height: 10,
                    decoration: BoxDecoration(
                      color: AppColors.tsnRed, // Color of the dot
                      shape: BoxShape.circle,
                    ),
                  ) : Container(),
                  
                ],
              ),
            ],
          ),
        ));
  }
}

class InnerNeumorphicCardFb1 extends StatelessWidget {
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
