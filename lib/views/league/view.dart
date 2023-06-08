import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';

import '../../commands/event_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/Mixins/payment_mixin.dart';
import '../../components/events_calendar.dart';
import '../../components/headers.dart';
import '../../components/league_table_widget.dart';
import '../../components/players_list_widget.dart';
import '../../components/teams_list_widget.dart';
import '../../constants.dart';
import '../tournament/view.dart';

class LeagueView extends StatefulWidget with EventMixin, PaymentMixin {
  LeagueView({Key? key, required this.league})
      : super(key: key);

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

  bool _isLoading = true;
  dynamic priceObject;
  dynamic leagueEvents = [];
  dynamic userEventDetails;
  dynamic playerListWidgetDetails;
  dynamic teamListWidgetDetails;

  void updateChatsList(dynamic createdChat){
    setState(() {
      userEventDetails['mainEvent']['chats']['data'].add(createdChat);      
    });
  }

  void goBack() {
    Navigator.pop(context);
  }

  void loadEventPayment() {
    priceObject = userEventDetails['mainEvent']['price'];
  }

  Future<void> loadInitialData() async {
    print("loadInitialData() in LeagueView");
    await widget.setupTeamList();
    widget.setupMyTeams();
    
    dynamic getEventDetailsResp =  
        EventCommand().getUserEventDetails(widget.league['events']['data']);
    widget.setupRequestWidgetData(getEventDetailsResp);
    leagueEvents = widget.league['events']['data'];
    widget.setupPlayerList();
    playerListWidgetDetails =
        await widget.getPlayerListWidgetDetails(getEventDetailsResp);
        teamListWidgetDetails = await widget.getTeamListWidgetDetails(getEventDetailsResp);
    setState(() {
      userEventDetails = getEventDetailsResp;
      _isLoading = false;
    });
    loadEventPayment();    
  }

  @override
  void initState() {
    print("initState");
    loadInitialData();
    
    print("finish initState");
  }

  @override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: Headers().getBackHeader(context, "League"),
    body: !_isLoading 
      ? SingleChildScrollView(
          child: Column(children: [
            widget.getParticipationRolesWidget(),
            Container(
              height: 500,
              child: EventsCalendar(testText: "test", events: ""),
            ),
            !userEventDetails['isMine']
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
                              userEventDetails['mainEvent'], {0: {}}, widget.requestUserTypes, []);
                        },
                        child: Text("Send Request")),
                  ),
                )
              : Container(),
              InkWell(
      onTap: () {
        // Handle navigation to tournament view here
        // You can use Navigator.push to navigate to the tournament view

         showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return TournamentView(tournament: widget.league['tournaments']['data'][0]);
          },
          animationType: DialogTransitionType.slideFromBottom,
          curve: Curves.fastOutSlowIn,
          duration: Duration(seconds: 1),
        );
      },
      child: Container(
        padding: EdgeInsets.all(16.0),
        color: Colors.blue,
        child: Text(
          'View Tournament',
          style: TextStyle(color: Colors.white, fontSize: 16.0),
        ),
      ),
    ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                widget.getPriceWidget(userEventDetails),
                userEventDetails['isMine']
                  ? ElevatedButton(
                      onPressed: () {
                        // Add button onPressed logic here
                      },
                      child: Text('Update Payment'),
                    )
                  : Container(),
              ],
            ),
              if (userEventDetails['isMine'])
              widget.createEventRequestWidget,
              if (userEventDetails['isMine'])
              widget.createEventPaymentWidget,
              if (userEventDetails['isMine'])
              widget.createTeamRequestWidget,
              if (userEventDetails['isMine'])
              widget.createTeamPaymentWidget,


            widget.getChatWidget(context, true, false, userEventDetails, updateChatsList),
            PlayerList(
                              playersDetails: playerListWidgetDetails),
            TeamsListWidget(
                              teamsDetails: teamListWidgetDetails),
            widget.sendPlayersRequestWidget(context, userEventDetails),
            widget.sendTeamsRequestWidget(context, userEventDetails),
            LeagueTableWidget(leagueData: [],),
          ])
        )
      : Container(
          height: double.infinity,
          width: double.infinity,
          child: Align(
            alignment: Alignment.center,
            child: LoadingScreen(
                currentDotColor: Colors.white,
                defaultDotColor: Colors.black,
                numDots: 10),
          ),
        ),
  );
}

}
