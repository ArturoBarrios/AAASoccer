import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import '../../commands/tournament_command.dart';
import '../../constants.dart';
import '../../svg_widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../models/pageModels/app_model.dart';
import '../../commands/event_command.dart';
import '../../views/tournament/view.dart';

class TournamentCard extends StatefulWidget {
  const TournamentCard(
      {Key? key,
      required this.tournamentObject,
      required this.svgImage,
      required this.userEventDetails})
      : super(key: key);
  final Map<String, dynamic> tournamentObject;
  final Svg svgImage;
  final double bevel = 10.0;
  final dynamic userEventDetails;

  @override
  State<TournamentCard> createState() => _TournamentCard();
}

void tournamentClicked() {
  print("Tournament Clicked");
}

Future<void> sendEventRequest(dynamic tournamentObject) async {
  print("send event request for event: :" + tournamentObject.toString());

  await EventCommand()
      .sendOrganizerTournamentRequest(tournamentObject, "PLAYER");
}

class _TournamentCard extends State<TournamentCard> {
  final bool _isPressed = false;
  final Color color = Colors.grey.shade200;

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.orange.shade500,
      textStyle: const TextStyle(fontSize: 20));
  final imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555";

  List<int>? selectedRequestTypeIndexes;
  List requestUserTypes = [
    Constants.PLAYER.toString(),
    Constants.ORGANIZER.toString(),
    Constants.MANAGER.toString(),
    Constants.MAINCOACH.toString(),
    Constants.ASSISTANTCOACH.toString(),
    Constants.REF.toString(),
  ];

  List<String> selectedRequestTypeObjects = [];

  requestTypeSelected(List<int>? indexes) {
    print("requestTypeSelected: " + indexes.toString());
    selectedRequestTypeIndexes = indexes;
    for (int i = 0; i < indexes!.length; i++) {
      selectedRequestTypeObjects.add(requestUserTypes[indexes[i]]);
    }
  }

  Future<void> sendEventRequest() async {
    print("sendEventRequest");
    print("selectedRequestTypeObjects.length: " +
        selectedRequestTypeObjects.length.toString());
    print(
        "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    print("send player event request");
    for (int i = 0; i < selectedRequestTypeObjects.length; i++) {
      await EventCommand().sendOrganizerEventRequest(
          widget.tournamentObject,
          selectedRequestTypeObjects[i],
          Constants.TOURNAMENTREQUEST.toString());
    }
  }

  Future<Map<String, dynamic>> archiveTournament(
      dynamic tournamentObject) async {
    print("archiveTournament()");
    // dynamic mainEvent = TournamentCommand().getMainTournamentEvent(tournamentObject);
    Map<String, dynamic> archiveTournamentResponse =
        await EventCommand().archiveEvent(tournamentObject);

    return archiveTournamentResponse;
  }

  @override
  Widget build(BuildContext context) {
    print("tournament_card widget name: ");
    print(widget.tournamentObject.toString());
    return Listener(
        child: GestureDetector(
      onTap: () {
        showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return TournamentView(tournament: widget.tournamentObject);
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
                    text: widget.userEventDetails['mainEvent']['name'],
                    svgImage: widget.svgImage,
                    subtitle:
                        "test subtitle", //widget.tournamentObject['description'],
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
                      titleText:
                          'Are you sure you want to delete this tournament?',
                      contentText: '',
                      onPositiveClick: () {
                        print("onPositiveClick: ");
                        Navigator.of(context).pop();
                        archiveTournament(widget.tournamentObject);
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
            !widget.userEventDetails['isMine']
                ? Container(
                    height: 20,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20.0),
                      child: GestureDetector(
                          onTap: () async {
                            print("onTap: ");
                            List<int>? requestIndexes =
                                await showAnimatedDialog<dynamic>(
                              context: context,
                              barrierDismissible: true,
                              builder: (BuildContext context) {
                                return ClassicListDialogWidget<dynamic>(
                                    selectedIndexes: selectedRequestTypeIndexes,
                                    titleText: 'Choose User Type',
                                    positiveText: "Send Request",
                                    listType: ListType.multiSelect,
                                    activeColor: Colors.green,
                                    dataList: requestUserTypes);
                              },
                              animationType: DialogTransitionType.size,
                              curve: Curves.linear,
                            );

                            selectedRequestTypeIndexes =
                                requestIndexes ?? selectedRequestTypeIndexes;
                            print(
                                'selectedIndex:${selectedRequestTypeIndexes?.toString()}');
                            await requestTypeSelected(
                                selectedRequestTypeIndexes);
                            await sendEventRequest();
                          },
                          child: Text("Send Request")),
                    ),
                  )
                : Text("Join Your Game")
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
