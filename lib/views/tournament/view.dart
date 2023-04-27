import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../commands/event_command.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/headers.dart';
import '../../constants.dart';
import '../../components/events_calendar.dart';

class TournamentView extends StatefulWidget with EventMixin{
  TournamentView(
      {Key? key, required this.userEventDetails, required this.tournament})
      : super(key: key);

  final dynamic userEventDetails;
  final dynamic tournament;

  @override
  _TournamentViewState createState() => _TournamentViewState();
}

class _TournamentViewState extends State<TournamentView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  bool _isLoading = false;

  List<dynamic> tournamentEvents = [];

  void goBack() {
    Navigator.pop(context);
  }

  List paymentChoices = [
    "Apply to All",
    "Apply to Team(s)"
    "Apply to Player(s)"
  ];
  int? selectPaymentIndex = 0;
  //send player request for main tournament event
  //should add player as a free agent
  //should also handle sending team request
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
          widget.tournament,
          selectedRequestTypeObjects[i],
          Constants.TOURNAMENTREQUEST.toString());
    }
  }

  @override
  void initState() {
    print("initState");
    tournamentEvents = widget.tournament['events']['data'];
    //remove event where isMainEvent and type==TOURNAMENT
    // for (int i = 0; i < tournamentEvents.length; i++) {
    //   dynamic tournamentEvent = tournamentEvents[i];
    //   if (tournamentEvent['isMainEvent'] &&
    //       tournamentEvent['type'] == "TOURNAMENT") {
    //     tournamentEvents.remove(tournamentEvent);
    //   }
    // }
    print("tournamentEvents: " + tournamentEvents.toString());
  }

  @override
  Widget build(BuildContext context) {
    // print("TournamentView build() widget.tournament: " +
    //     widget.tournament.toString());
    return Scaffold(
      appBar: Headers().getBackHeader(context, "Tournament"),
      body: SingleChildScrollView(
        child: Center(
          child: Expanded(
            child: Column(
              children: [
                Container(
                  height: 500,
                  child: EventsCalendar(testText: "test", events: ""),
                ),
                !widget.userEventDetails['isMyEvent']
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
                                    dataList: requestUserTypes,
                                  );
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
                            child: Text("Send Request"),
                          ),
                        ),
                      )
                    : Container(),
                    //add payment to tournament
                    Container(
                        height: 20,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(20.0),
                          child: GestureDetector(
                            onTap: () async {
                              print("onTap: ");
                              int? paymentOptionIndex =
                                  await showAnimatedDialog<int>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return ClassicListDialogWidget<dynamic>(
                                    selectedIndex: selectPaymentIndex,
                                    titleText: 'Payment Option',
                                    positiveText: "Next",
                                    listType: ListType.singleSelect,
                                    activeColor: Colors.green,
                                    dataList: paymentChoices,                                    
                                  );
                                },
                                animationType: DialogTransitionType.size,
                                curve: Curves.linear,
                              );


                              
                              print(
                                  'selectedIndex:${selectedRequestTypeIndexes?.toString()}');
                              await requestTypeSelected(
                                  selectedRequestTypeIndexes);
                              await sendEventRequest();
                            },
                            child: Text("Add Payment"),
                          ),
                        ),
                      )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
