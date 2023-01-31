import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../../svg_widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../commands/game_command.dart';
import '../../commands/event_command.dart';
import '../../views/game/view.dart';
import '../../assets/icons/plus.svg';

class PickupCard2 extends StatefulWidget {
  const PickupCard2(
      {Key? key, required this.eventObject, required this.svgImage, required this.isMyEvent })
      : super(key: key);
  final Map<String, dynamic> eventObject;
  final Svg svgImage;
  final bool isMyEvent;
  final double bevel = 10.0;

  @override
  State<PickupCard2> createState() => _PickupCard2();
}

void pickupClicked() {
  print("Pickup Clicked");
}

Future<Map<String, dynamic>> archivePickup(dynamic gameObject) async {
  print("archivePickup for gameobject: $gameObject");
  Map<String, dynamic> archivePickupResp = {
    "success": false,
    "message": "Pickup deleted successfully"
  };
  Map<String, dynamic> archivePickupResponse = await GameCommand()
      .archiveGame(gameObject['event']['_id'], gameObject["_id"]);
  print("archivePickupResponse: $archivePickupResponse");
  if (archivePickupResponse["success"]) {
    archivePickupResp["success"] = true;
  }

  return archivePickupResp;
}
Future<Map<String, dynamic>> removePickup(dynamic gameObject) async {
  print("removePickup for gameobject: $gameObject");
  Map<String, dynamic> removePickupResp = {
    "success": false,
    "message": "Pickup removed successfully"
  };
  Map<String, dynamic> removePickupRespResponse = await GameCommand()
      .removeGame(gameObject["_id"], gameObject["games"]["data"][0]["_id"]);
  print("removePickupRespResponse: $removePickupRespResponse");
  if (removePickupRespResponse["success"]) {
    removePickupRespResponse["success"] = true;
  }

  return removePickupRespResponse;
}

class _PickupCard2 extends State<PickupCard2> {
  final bool _isPressed = false;
  final Color color = Colors.grey.shade200;

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.orange.shade500,
      textStyle: const TextStyle(fontSize: 20));
  final imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555";
  @override
  Widget build(BuildContext context) {
    print("widget name: ");
    print(widget.eventObject.toString());
    return Listener(
        child: GestureDetector(
      onTap: () {
        showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return PickupView(isMyEvent: widget.isMyEvent);
          },
          animationType: DialogTransitionType.slideFromBottom,
          curve: Curves.fastOutSlowIn,
          duration: Duration(seconds: 1),
        );
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
            boxShadow: [
              BoxShadow(
                blurRadius: 10.0,
                offset: -Offset(10.0 / 2, 10.0 / 2),
                color: Colors.white,
              ),
            ],
          ),
          child: Row(children: [
            Container(
                child: InnerNeumorphicCardFb1(
                  //todo IDK you may have to change this.....
                    text: widget.eventObject.containsKey("event") ? widget.eventObject['event']['name'] : widget.eventObject['name'],
                    svgImage: widget.svgImage,
                    subtitle:
                        widget.eventObject.containsKey("event") ? widget.eventObject['event']['name'] : widget.eventObject['name'], //widget.eventObject['description'],
                    onPressed: () {
                      print("inside container onPressed");
                    })),
                  // if(widget.isMyEvent)                                        
                    GestureDetector(
                      onTap: () {
                        showAnimatedDialog(
                          context: context,
                          barrierDismissible: true,
                          builder: (BuildContext context) {
                            return ClassicGeneralDialogWidget(
                              titleText: 'Are you sure you want to delete this event?',
                              contentText: '',
                              onPositiveClick: () {
                                Navigator.of(context).pop();
                                //delete event aaa
                                print(widget.eventObject.toString());
                                archivePickup(widget.eventObject);
                                // removePickup(widget.eventObject);
                              },
                              onNegativeClick: () {
                                Navigator.of(context).pop();
                              },
                            );
                          },
                          animationType: DialogTransitionType.slideFromBottom,
                          curve: Curves.fastOutSlowIn,
                          duration: Duration(seconds: 1),
                        );
                      },
                      child: Container(
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: Image(
                            width: 20,
                            height: 20,
                            image: SVGWidgets().deleteSVGImage(),
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                    IconButton(
            icon: const Icon(Icons.account_circle),
            tooltip: 'Go to the next page',
            onPressed: () {
              //send event request
              print("send event request for event: : ${widget.eventObject}");
              EventCommand().sendOrganizerEventRequest(widget.eventObject);                
            },
          ),
            // GestureDetector(
            //   onTap: () {
            //     //send event request
            //     // print("send event request");
            //     // EventCommand().sendOrganizerEventRequest(widget.eventObject);                
            //   },
            //   child: Container(
            //     child: ClipRRect(
            //       borderRadius: BorderRadius.circular(20.0),
            //       child: Image(
            //         width: 20,
            //         height: 20,
            //         image: SVGWidgets().plusCircleOutline(),
            //         color: Colors.white,
            //       ),
            //     ),
            //   ),
            // ),
          ])),
    ));
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
