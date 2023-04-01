import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../../svg_widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../commands/game_command.dart';
import '../../commands/requests_command.dart';
import '../../views/team/view.dart';
import '../../assets/icons/plus.svg';

class TeamRequestCard extends StatefulWidget {
  const TeamRequestCard(
      {Key? key, required this.teamRequestObject, required this.svgImage})
      : super(key: key);
  final Map<String, dynamic> teamRequestObject;
  final Svg svgImage;
  final double bevel = 10.0;

  @override
  State<TeamRequestCard> createState() => _TeamRequestCard();
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
  //     .deleteGame(gameObject["team"]["_id"], gameObject["_id"]);
  // print("deletePickupResponse: $deletePickupResponse");
  // if (deletePickupResponse["success"]) {
  //   deletePickupResp["success"] = true;
  // }

  return deletePickupResp;
}

class _TeamRequestCard extends State<TeamRequestCard> {
  final bool _isPressed = false;
  final Color color = Colors.grey.shade200;

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.orange.shade500,
      textStyle: const TextStyle(fontSize: 20));
  final imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555";
  @override
  Widget build(BuildContext context) {
  print("TeamRequestCard Build()");
    print("widget name: ");
    print(widget.teamRequestObject.toString());
    return Listener(
        child: GestureDetector(
      onTap: () {
        showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return TeamView(teamObject: widget.teamRequestObject);
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
                    text: ("join team("+widget.teamRequestObject['name'].toString()+")"),
                    svgImage: widget.svgImage,
                    subtitle:
                        "sent by "+widget.teamRequestObject['sender']['username'].toString()
                        , //widget.teamRequestObject['description'],
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
                      titleText: 'Are you sure you want to delete this team?',
                      contentText: '',
                      onPositiveClick: () {
                        Navigator.of(context).pop();
                        //delete team aaa
                        print(widget.teamRequestObject.toString());
                        deletePickup(widget.teamRequestObject);
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
                //send team request
                print("update team request");
                print(widget.toString());
                RequestsCommand().updateTeamRequests(widget.teamRequestObject);
                
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
        height: 200,
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
