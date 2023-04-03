import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../../svg_widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../models/user_model.dart';
import '../../commands/user_command.dart';
import '../../views/player/view.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/constants.dart';

class PlayerCard extends StatefulWidget {
  const PlayerCard(
      {Key? key, required this.playerObject, required this.svgImage})
      : super(key: key);
  final Map<String, dynamic> playerObject;
  final Svg svgImage;
  final double bevel = 10.0;

  @override
  State<PlayerCard> createState() => _PlayerCard();
}

void playerClicked() {
  print("Player Clicked");
}

class _PlayerCard extends State<PlayerCard> {
  final bool _isPressed = false;
  final Color color = Colors.grey.shade200;

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.orange.shade500,
      textStyle: const TextStyle(fontSize: 20));
  final imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555";
    int selectIndex = 0;
    int chosenRequestType = 0;
    List requestUserTypes = [
      Constants.PLAYER.toString(),
      Constants.ORGANIZER.toString(),
      Constants.MANAGER.toString(),
      Constants.MAINCOACH.toString(),
      Constants.ASSISTANTCOACH.toString(),
      Constants.REF.toString(),
    ];

    List myEventsToChooseFrom = [];
    List myTeamsToChooseFrom = [];
    List choices = [];

    void setupEventsToChooseFrom() {
      print("setupEventsToChooseFrom");
      List<dynamic> myEvents = UserCommand().getAppModelMyEvents();
      myEventsToChooseFrom = myEvents;
    }

    void setupTeamsToChooseFrom() {
      print("setupTeamsToChooseFrom");
      List<dynamic> myTeams = UserCommand().getAppModelMyTeams();
      myTeamsToChooseFrom = myTeams;
    }

    void setupChoices() {
      setupEventsToChooseFrom();
      setupTeamsToChooseFrom();
      //set choices to be the list of myEventsToChooseFrom and myEventsToChooseFrom
      choices = [...myEventsToChooseFrom, ...myTeamsToChooseFrom];
      print("choices: " + choices.toString());
    }

    List<int>? selectedIndexes;

    eventTeamsSelected(List<int>? indexes) {
      print("eventTeamsSelected: " + indexes.toString());
      selectedIndexes = indexes;
    }
    
  @override
  Widget build(BuildContext context) {
    print("Player card: " + widget.playerObject.toString());
    print("widget name: ");
    print(widget.playerObject.toString());
    setupChoices();

    return Listener(
        child: GestureDetector(
      onTap: () {
        showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return PlayerView(userPlayerObject: widget.playerObject);
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
                    text: widget.playerObject['email'],
                    svgImage: widget.svgImage,
                    subtitle:
                        "test subtitle", //widget.playerObject['description'],
                    onPressed: () {
                      print("inside container onPressed");
                    })),
            GestureDetector(
              onTap: () {
                //potentially show dialogue
                //with different request options
                UserCommand().sendFriendRequest(widget.playerObject);
              },
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: const Icon(Icons.person_add_alt_1)),
              ),
            ),
            GestureDetector(
              onTap: () async {
                List<int>? indexes = await showAnimatedDialog(
                  context: context,
                  barrierDismissible: true,
                  builder: (BuildContext context) {
                    return ClassicListDialogWidget<dynamic>(
                        selectedIndexes: selectedIndexes,
                        titleText: 'Choose Event/Team',
                        positiveText: "Next",
                        listType: ListType.multiSelect,                                                                                                    
                          // showAnimatedDialog<int>(
                          //   context: context,
                          //   barrierDismissible: true,
                          //   builder: (BuildContext context) {
                          //     return ClassicListDialogWidget<dynamic>(
                          //         selectedIndex: selectIndex,
                          //         titleText: 'Choose User Type',
                          //         positiveText: "Send Request",
                          //         listType: ListType.multiSelect,
                          //         onPositiveClick: () {
                          //           // chosenRequestType = requestUserTypes[index!];
                          //           print("Choose User Type: " + selectIndex.toString());
                          //           // sendPlayerRequest();
                          //         },
                          //         activeColor: Colors.green,
                          //         dataList: requestUserTypes);
                          //   },
                          //   animationType: DialogTransitionType.size,
                          //   curve: Curves.linear,
                          // );

                        
                        activeColor: Colors.green,
                        dataList: choices);
                  },
                  animationType: DialogTransitionType.size,
                  curve: Curves.linear,
                );
                selectedIndexes = indexes ?? selectedIndexes;
                print('selectedIndex:${selectedIndexes?.toString()}');
                eventTeamsSelected(selectedIndexes);
              },
              child: Container(
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(20.0),
                    child: const Icon(Icons.send)),
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
