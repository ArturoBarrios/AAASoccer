import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:provider/provider.dart';

import '../../commands/base_command.dart';
import '../../commands/event_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/Mixins/images_mixin.dart';
import '../../components/Mixins/payment_mixin.dart';
import '../../components/chats_list_widget.dart';
import '../../components/events_calendar.dart';
import '../../components/headers.dart';
import '../../components/league_table_widget.dart';
import '../../components/object_profile_main_image.dart';
import '../../components/players_list_widget.dart';
import '../../components/teams_list_widget.dart';
import '../../components/update_view_form.dart';
import '../../constants.dart';
import '../../models/app_model.dart';
import '../tournament/view.dart';

class LeagueView extends StatefulWidget with EventMixin, PaymentMixin, ImagesMixin {
  LeagueView({Key? key, required this.league}) : super(key: key);

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

  dynamic objectImageInput = {
    "imageUrl": "",
    "containerType": Constants.IMAGEBANNER,
    "mainEvent": null,
    "isMyEvent": false
  };

  bool _isLoading = true;
  dynamic priceObject;
  dynamic leagueEvents = [];  
  dynamic teamListWidgetDetails;
  dynamic leagueTableData = [];

  void updateChatsList(dynamic createdChat) {
    setState(() {
      dynamic userEventDetails = BaseCommand().getUserEventDetailsModel();
      userEventDetails['mainEvent']['chats']['data'].add(createdChat);
    });
  }

  void goBack() {
    Navigator.pop(context);
  }

  void loadEventPayment() {
    dynamic userEventDetails = BaseCommand().getUserEventDetailsModel();
    priceObject = userEventDetails['mainEvent']['price'];
  }

 


  Future<void> loadInitialData() async {
    print("loadInitialData() in LeagueView");
    await widget.setupTeamList();
    widget.setupMyTeams();

    dynamic getEventDetailsResp = await 
        EventCommand().getUserEventDetails(widget.league['events']['data']);
    dynamic userEventDetails = getEventDetailsResp;
    //setup image
    objectImageInput = await widget.loadEventMainImage(userEventDetails);
    getEventDetailsResp['league'] = widget.league;
    widget.setupRequestWidgetData(getEventDetailsResp);
    leagueEvents = widget.league['events']['data'];
    widget.setupPlayerList();    
    teamListWidgetDetails =
        await widget.getTeamListWidgetDetails(getEventDetailsResp);
    print("mainEvent type: "+ userEventDetails['mainEvent']['type']);    
    BaseCommand().updateUserEventDetailsModel(userEventDetails);
    setState(() {
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
    dynamic userEventDetails = context.watch<AppModel>().userEventDetails;

    return Scaffold(
      appBar: PreferredSize(
    preferredSize: Size.fromHeight(200.0),  // You can adjust the height value as per your requirement.
    child: ObjectProfileMainImage(
          objectImageInput:
              objectImageInput), 
  ),
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
                      return TournamentView(
                          tournament: widget.league['tournaments']['data'][0]);
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
              UpdateViewForm(userObjectDetails: userEventDetails),
              // Row(
              //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
              //   children: [
              //     widget.getPriceWidget(userEventDetails),
              //     userEventDetails['isMine']
              //         ? ElevatedButton(
              //             onPressed: () {
              //               // Add button onPressed logic here
              //             },
              //             child: Text('Update Payment'),
              //           )
              //         : Container(),
              //   ],
              // ),
              // if (userEventDetails['isMine']) widget.createEventRequestWidget,
              // if (userEventDetails['isMine']) widget.createEventPaymentWidget,
              // if (userEventDetails['isMine']) widget.createTeamRequestWidget,
              // if (userEventDetails['isMine']) widget.createTeamPaymentWidget,
              
              // PlayerList(playersDetails: playerListWidgetDetails),
              
              // widget.sendPlayersRequestWidget(context, userEventDetails),
              // widget.sendTeamsRequestWidget(context, userEventDetails),
              
            ]))
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
