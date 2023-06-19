import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/components/group_stage_widget.dart';
import '../../commands/event_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/Mixins/payment_mixin.dart';
import '../../components/bracket_widget.dart';
import '../../components/chats_list_widget.dart';
import '../../components/create_event_payment.dart';
import '../../components/create_event_request.dart';
import '../../components/create_team_payment.dart';
import '../../components/create_team_request.dart';
import '../../components/headers.dart';
import '../../components/players_list_widget.dart';
import '../../components/price_widget.dart';
import '../../components/teams_list_widget.dart';
import '../../components/update_view_form.dart';
import '../../constants.dart';
import '../../components/events_calendar.dart';

class TournamentView extends StatefulWidget with EventMixin, PaymentMixin {
  TournamentView({Key? key, required this.tournament}) : super(key: key);

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

  bool _isLoading = true;
  dynamic priceObject;
  List<dynamic> tournamentEvents = [];
  dynamic userEventDetails;  
  dynamic teamListWidgetDetails;

  //send player request for main tournament event
  //should add player as a free agent
  //should also handle sending team request

  
  

  void goBack() {
    Navigator.pop(context);
  }

  void loadEventPayment() {
    priceObject = userEventDetails['mainEvent']['price'];
  }

  

  

  Future<void> loadInitialData() async {
    print("loadInitialData() in TournamentView");
    tournamentEvents = widget.tournament['events']['data'];
    widget.setupTeamList();
    widget.setupMyTeams();

    dynamic getEventDetailsResp = await 
        EventCommand().getUserEventDetails(widget.tournament['events']['data']);
    getEventDetailsResp['groupStage'] = widget.tournament['groupStage'];
    widget.setupRequestWidgetData(getEventDetailsResp);
    getEventDetailsResp['tournamentStage'] =
        widget.tournament['tournamentStage'];
    widget.setupPlayerList();    
    teamListWidgetDetails = await widget.getTeamListWidgetDetails(getEventDetailsResp);
    setState(() {
      userEventDetails = getEventDetailsResp;
      _isLoading = false;
    });
    print("userEventDetails: " + userEventDetails.toString());
    print("loadInitialData() finished!");
    print("loadEventPayment() in loadInitialData()");
    loadEventPayment();
    print("loadEventPayment() finished in loadInitialData()");
  }

  @override
  void initState() {
    print("initState");
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    // print("TournamentView build() widget.tournament: " +
    //     widget.tournament.toString());
    return Scaffold(
      appBar: Headers().getBackHeader(context, "Tournament"),
      body: !_isLoading
          ? SingleChildScrollView(
              child: Center(
                child: Expanded(
                  child: Column(
                    children: [
                      widget.getParticipationRolesWidget(),
                      Container(
                        height: 500,
                        child: EventsCalendar(
                            testText: "test",
                            events: userEventDetails['allEvents']),
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
                                          dataList: widget.requestUserTypes,
                                        );
                                      },
                                      animationType: DialogTransitionType.size,
                                      curve: Curves.linear,
                                    );

                                    widget.selectedRequestTypeIndexes =
                                        requestIndexes ??
                                            widget.selectedRequestTypeIndexes;
                                    print(
                                        'selectedIndex:${widget.selectedRequestTypeIndexes?.toString()}');
                                    await widget.requestTypeSelected(
                                        widget.selectedRequestTypeIndexes);
                                    await widget.sendEventRequest(
                                        userEventDetails['mainEvent'],
                                        {0: {}},
                                        widget.requestUserTypes,
                                        []);
                                  },
                                  child: Text("Send Non Player Request"),
                                ),
                              ),
                            )
                          : Container(),                          
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     PriceWidget(userEventDetails: userEventDetails, teamPrice: false, eventPrice: true)                                                    
                      //   ],
                      // ),
                      // Row(
                      //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      //   children: [
                      //     PriceWidget(userEventDetails: userEventDetails, teamPrice: true, eventPrice: false)                          
                      //   ],
                      // ),

                      UpdateViewForm(userObjectDetails: userEventDetails),

                      
                      
                          // PlayerList(
                          //     playersDetails: playerListWidgetDetails),
                        
                      
                      // TeamsListWidget(
                      //         teamsDetails: teamListWidgetDetails),
                      
                      // widget.sendPlayersRequestWidget(context, userEventDetails),

                      // widget.sendTeamsRequestWidget(context, userEventDetails),

                      Container(
                        height: 400, // Provide a fixed height here
                        child: GroupStageWidget(
                            groupData: userEventDetails['groupStage'],
                            teams: userEventDetails['teams']),
                      ),
                      Container(
                        height: 400, // Provide a fixed height here
                        child: BracketWidget(
                            bracketDetails:
                                userEventDetails['tournamentStage']),
                      ),
                    ],
                  ),
                ),
              ),
            )
          : Container(
              height: double.infinity,
              width: double.infinity,
              child: Align(
                alignment: Alignment.center,
                child:
                    // BottomNav()//for times when user deleted in cognito but still signed into app
                    LoadingScreen(
                        currentDotColor: Colors.white,
                        defaultDotColor: Colors.black,
                        numDots: 10),
              ),
            ),
    );
  }
}
