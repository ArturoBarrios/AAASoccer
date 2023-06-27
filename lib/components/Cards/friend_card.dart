import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/commands/user_command.dart';
import '../../svg_widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../commands/game_command.dart';
import '../../views/player/view.dart';
import '../../views/send_player_request_view.dart';
import '../profile.dart';

class FriendCard extends StatefulWidget {
  const FriendCard(
      {Key? key, required this.friendObject, required this.svgImage})
      : super(key: key);
  final Map<String, dynamic> friendObject;
  final Svg svgImage;
  final double bevel = 10.0;

  @override
  State<FriendCard> createState() => _FriendCard();
}

void friendClicked() {
  print("Friend Clicked");
}

Future<Map<String, dynamic>> removeFriend(dynamic friendObject) async {
  print("removeFriend()");
  print("friendObject: $friendObject");
  Map<String, dynamic> deleteFriendResp = {
    "success": false,
    "message": "Friend deleted successfully"
  };
  Map<String, dynamic> removeFriendResp = await UserCommand().removeFriend(friendObject);
  
  print("removeFriendResp: $removeFriendResp");
  if (removeFriendResp["success"]) {
    print("friend removed successfully");
    deleteFriendResp["success"] = true;
  }
  

  return deleteFriendResp;
}



class _FriendCard extends State<FriendCard> {
  final bool _isPressed = false;
  final Color color = Colors.grey.shade200;
  

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.orange.shade500,
      textStyle: const TextStyle(fontSize: 20));
  final imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555";

      goToPlayer() {
    print("goToPlayer");
    dynamic profileDetails = {
      "user": widget.friendObject['user'],
      "isMine": false,
    };
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Profile(
                profileDetails: profileDetails,
              )),
    );
  }

  
  @override
  Widget build(BuildContext context) {
    print("widget name: ");
    print(widget.friendObject.toString());
    return Listener(
        child: GestureDetector(
      onTap: () {
        goToPlayer();
        // showAnimatedDialog(
        //   context: context,
        //   barrierDismissible: true,
        //   builder: (BuildContext context) {
        //     return PlayerView(userPlayerObject: widget.friendObject);
        //   },
        //   animationType: DialogTransitionType.slideFromBottom,
        //   curve: Curves.fastOutSlowIn,
        //   duration: Duration(seconds: 1),
        // );
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
                    text: widget.friendObject['user']['email'],
                    svgImage: widget.svgImage,
                    subtitle:
                        "test subtitle", //widget.friendObject['description'],
                    onPressed: () {
                      print("inside container onPressed");
                    })),  
                GestureDetector(
                  onTap: () {
                    //potentially show dialogue
                    //with different request options
                    showAnimatedDialog(
                      context: context,
                      barrierDismissible: true,
                      builder: (BuildContext context) {
                        return SendPlayerRequestView(playerObject: widget.friendObject);
                      },
                      animationType: DialogTransitionType.scale,
                      curve: Curves.fastOutSlowIn,
                      duration: Duration(seconds: 1),
                    );
                    // UserCommand().sendFriendRequest(                    
                    //     widget.playerObject['user']
                    // );
                  },
                  child: Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: const Icon(Icons.rocket_launch_rounded)
                    ),
                  ),
                ),          
            GestureDetector(
              onTap: ()async  {
                await UserCommand().removeFriend(widget.friendObject);
                
                // UserCommand().sendFriendRequest(widget.friendObject);
              },
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: const Icon(Icons.person_remove_sharp),
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
