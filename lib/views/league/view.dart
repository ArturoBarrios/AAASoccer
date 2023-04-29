import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import '../../commands/event_command.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/Mixins/payment_mixin.dart';
import '../../components/events_calendar.dart';
import '../../components/headers.dart';
import '../../constants.dart';

class LeagueView extends StatefulWidget with EventMixin, PaymentMixin {
  LeagueView({Key? key, required this.userEventDetails, required this.league})
      : super(key: key);

  final dynamic userEventDetails;
  final dynamic league;

  @override
  _LeagueViewState createState() => _LeagueViewState();
}

class _LeagueViewState extends State<LeagueView> {
  final nameController = TextEditingController();
  final imageController = TextEditingController();
  final secondaryNameController = TextEditingController();
  final addressController = TextEditingController();
  final surfaceController = TextEditingController();
  final fieldSizeController = TextEditingController();
  final privateController = TextEditingController();

  bool _isLoading = false;
  dynamic priceObject;
  dynamic leagueEvents = [];

  void goBack() {
    Navigator.pop(context);
  }

  void loadEventPayment() {
    priceObject = widget.userEventDetails['mainEvent']['price'];
  }

  @override
  void initState() {
    print("initState");
    leagueEvents = widget.league['events']['data'];
    loadEventPayment();
    widget.loadEventInfo(widget.userEventDetails['mainEvent']);
    widget.setupPlayerList();
    _isLoading = false;
    // leagueEvents = widget.league['events']['data'];
    // //remove event where isMainEvent and type==TOURNAMENT
    // for (int i = 0; i < leagueEvents.length; i++) {
    //   dynamic leagueEvent = leagueEvents[i];
    //   if (leagueEvent['isMainEvent'] &&
    //       leagueEvent['type'] == "LEAGUE") {
    //     leagueEvents.remove(leagueEvent);
    //   }
    // }
    print("finish initState");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: Headers().getBackHeader(context, "League"),
      body: Center(
          child: Column(children: [
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
                                selectedIndexes:
                                    widget.selectedRequestTypeIndexes,
                                titleText: 'Choose User Type',
                                positiveText: "Send Request",
                                listType: ListType.multiSelect,
                                activeColor: Colors.green,
                                dataList: widget.requestUserTypes);
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
                        await widget.sendEventRequest(
                            widget.userEventDetails['mainEvent'],
                            Constants.LEAGUEREQUEST.toString());
                      },
                      child: Text("Send Request")),
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
        widget.getJoinGameWidget(context, widget.userEventDetails,
            widget.userEventDetails['mainEvent'], widget.userObject),
        widget.getChatWidget(context, true, false),
        widget.userEventDetails['isMyEvent']
            ? widget.sendPlayersRequestWidget(context)
            : Container(),
      ])),
    );
  }
}
