import 'package:flutter/material.dart';
import '../../svg_widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../commands/requests_command.dart';
import '../Mixins/request_mixin.dart';

class EventRequestCard extends StatefulWidget with RequestMixin {
  const EventRequestCard(
      {Key? key,
      required this.eventRequestObject,
      required this.type,
      required this.didSendRequest})
      : super(key: key);
  final Map<String, dynamic> eventRequestObject;
  final String type;
  final bool didSendRequest;

  @override
  State<EventRequestCard> createState() => _EventRequestCard();
}

void pickupClicked() {
  print("Pickup Clicked");
}

Future<Map<String, dynamic>> deletePickup(dynamic gameObject) async {
  print("deletePickup for gameobject: $gameObject");
  Map<String, dynamic> deletePickupResp = {
    "success": false,
    "message": "Pickup deleted successfully"
  };
  // Map<String, dynamic> deletePickupResponse = await GameCommand()
  //     .deleteGame(gameObject["friend"]["_id"], gameObject["_id"]);
  // print("deletePickupResponse: $deletePickupResponse");
  // if (deletePickupResponse["success"]) {
  //   deletePickupResp["success"] = true;
  // }

  return deletePickupResp;
}

class _EventRequestCard extends State<EventRequestCard> {
  final bool _isPressed = false;
  final Color color = Colors.grey.shade200;

  void goToEvent(BuildContext context) {
    dynamic event = widget.eventRequestObject["event"];
    widget.goToEvent(context, event);
  }

  void goToPlayer(BuildContext context) {
    dynamic senderUser = widget.eventRequestObject['sender'];
    widget.goToPlayer(context, senderUser);
  }

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.orange.shade500,
      textStyle: const TextStyle(fontSize: 20));
  final imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555";
  @override
  Widget build(BuildContext context) {
    print("EventRequestCard Build()");
    print("widget name: ");
    print(widget.eventRequestObject.toString());
    String typeProcessed = widget.type[0].toUpperCase() +
        widget.type.substring(1, (widget.type.length - 7)).toLowerCase();
    return Listener(
        child: GestureDetector(
      onTap: () {},
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
                    text: typeProcessed +
                        " Request(" +
                        widget.eventRequestObject['event']['name'] +
                        ")",
                    subtitle: widget.didSendRequest
                        ? "sent to " +
                            widget.eventRequestObject['receivers']['data'][0]
                                    ['email']
                                .toString() +
                            " for " +
                            (widget.eventRequestObject['team'] == null
                                ? "player"
                                : "team " +
                                    widget.eventRequestObject['team']['name']
                                        .toString())
                        : "sent by " +
                            widget.eventRequestObject['sender']['email']
                                .toString() +
                            " for " +
                            (widget.eventRequestObject['team'] == null
                                ? "player"
                                : "team " +
                                    widget.eventRequestObject['team']['name']
                                        .toString()),
                    onPressed: () {
                      print("inside container onPressed");
                    })),
            GestureDetector(
              onTap: () {
                showAnimatedDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return ClassicGeneralDialogWidget(
                      titleText: 'Are you sure you want to delete this friend?',
                      contentText: '',
                      onPositiveClick: () {
                        Navigator.of(context).pop();
                        //delete friend aaa
                        print(widget.eventRequestObject.toString());
                        deletePickup(widget.eventRequestObject);
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
            GestureDetector(
              onTap: () {
                print(widget.eventRequestObject.toString());
                RequestsCommand()
                    .updateEventRequests(widget.eventRequestObject);
              },
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    width: 20,
                    height: 20,
                    image: SVGWidgets().getSoccerBallSVGImage(),
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ])),
    ));
  }
}

class InnerNeumorphicCardFb1 extends StatelessWidget {
  final String text;
  final String subtitle;
  final Function() onPressed;

  const InnerNeumorphicCardFb1(
      {required this.text,
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
            // Image(
            //   width: MediaQuery.of(context).size.width * .4,
            //   height: MediaQuery.of(context).size.height * .1,
            //   image: svgImage,
            //   color: Colors.white,
            // ),
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
