import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../commands/event_command.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/Mixins/payment_mixin.dart';
import '../../components/headers.dart';
import '../../constants.dart';
import '../../components/events_calendar.dart';

class TournamentView extends StatefulWidget with EventMixin, PaymentMixin{
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
  dynamic priceObject;
  List<dynamic> tournamentEvents = [];

  

  
  //send player request for main tournament event
  //should add player as a free agent
  //should also handle sending team request


   void goBack() {
    Navigator.pop(context);
  }

  void loadEventPayment() {
    priceObject = widget.userEventDetails['mainEvent']['price'];
  }

  @override
  void initState() {
    print("initState");    
    tournamentEvents = widget.tournament['events']['data'];
    loadEventPayment();
    widget.loadEventInfo(widget.userEventDetails['mainEvent']);
    widget.setupPlayerList();
    widget.setupTeamList();
    _isLoading = false;
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
                widget.getParticipationRolesWidget(),
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
                                    selectedIndexes: widget.selectedRequestTypeIndexes,
                                    titleText: 'Choose User Type',
                                    positiveText: "Send Request",
                                    listType: ListType.multiSelect,
                                    activeColor: Colors.green,
                                    dataList: widget.requestUserTypes,
                                  );
                                },
                                animationType: DialogTransitionType.size,
                                curve: Curves.linear,
                              );

                              widget.selectedRequestTypeIndexes =
                                  requestIndexes ?? widget.selectedRequestTypeIndexes;
                              print(
                                  'selectedIndex:${widget.selectedRequestTypeIndexes?.toString()}');
                              await widget.requestTypeSelected(
                                  widget.selectedRequestTypeIndexes);
                              await widget.sendEventRequest(widget.userEventDetails['mainEvent']);
                            },
                            child: Text("Send Non Player Request"),
                          ),
                        ),
                      )
                    : Container(),
                    Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    widget.getPriceWidget(widget.userEventDetails),
                    // Text(
                    //     "Price: \$${(double.parse(priceObject['amount']) / 100).toStringAsFixed(2)}"),
                    widget.userEventDetails['isMyEvent']
                        ? ElevatedButton(
                            onPressed: () {
                              // Add button onPressed logic here
                            },
                            child: Text('Update Payment'),
                          )
                        : Container(),
                  ],
                ),
                 //join game gesture detector for now
                widget.getJoinGameWidget(context, widget.userEventDetails, widget.userEventDetails['mainEvent'], widget.userObject),
                widget.getChatWidget(context, true, false),

                widget.userEventDetails['isMyEvent'] ?                
                  widget.sendPlayersRequestWidget(context)
                  : widget.sendOrganizerPlayerEventRequest(context),                
                widget.userEventDetails['isMyEvent'] ?                
                  widget.sendTeamsRequestWidget(context)
                  : widget.sendEventRequestForMyTeamWidget(context),                

                 
              ],
            ),
          ),
        ),
      ),
    );
  }
}
