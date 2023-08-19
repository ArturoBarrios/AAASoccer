import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/commands/team_command.dart';
import '../../commands/event_command.dart';
import '../../commands/player_command.dart';
import '../../components/Loading/loading_screen.dart';
import '../../components/Mixins/event_mixin.dart';
import '../../components/headers.dart';
import '../../components/players_list_widget.dart';
import '../../components/update_view_form.dart';
import '../../components/update_view_team_form.dart';
import '../../constants.dart';

class TeamView extends StatefulWidget with EventMixin {
  TeamView({Key? key, required this.teamObject})
      : super(key: key);
  final Map<String, dynamic> teamObject;
  

  

  @override
  _TeamViewState createState() => _TeamViewState();
}

class _TeamViewState extends State<TeamView> {
  bool _isLoading = true;
  dynamic priceObject;
  dynamic userTeamDetails;
  dynamic playerListWidgetDetails;

  void goBack() {
    Navigator.pop(context);
  }


  void setupPlayerList() {
    widget.setupPlayerList();
  }

  void playersSelected(List<int> selectedIndexes) {
    widget.playersSelected(selectedIndexes);

  }

  requestTypeSelected(List<int>? indexes) {
    widget.requestTypeSelected(indexes);
    // print("requestTypeSelected: " + indexes.toString());
    // selectedRequestTypeIndexes = indexes;
    // for (int i = 0; i < indexes!.length; i++) {
    //   selectedRequestTypeObjects.add(requestUserTypes[indexes[i]]);
    // }    
  }
  

  Future<void> sendPlayersTeamRequest() async {
    
    // widget.sendPlayersTeamRequest(widget.teamObject);
    // print("sendPlayersTeamRequest");
    // print("selectedRequestTypeObjects.length: " +
    //     selectedRequestTypeObjects.length.toString());
    // print(
    //     "playersSelectedList.length: " + playersSelectedList.length.toString());
    // print(
    //     "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    // print("send player team request");
    // for (int i = 0; i < playersSelectedList.length; i++) {
    //   await TeamCommand().sendPlayerTeamRequests(playersSelectedList[i],
    //       [widget.teamObject], selectedRequestTypeObjects);
    // }
  }

  Future<void> sendTeamRequest() async {
    widget.sendTeamRequest(widget.teamObject);
    // print("sendTeamRequest");
    // print("selectedRequestTypeObjects.length: " +
    //     selectedRequestTypeObjects.length.toString());
    // print(
    //     "playersSelectedList.length: " + playersSelectedList.length.toString());
    // print(
    //     "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    // print("send team request");
    // for(int i = 0; i < selectedRequestTypeObjects.length; i++) {
    //   await TeamCommand().sendOrganizerTeamRequest(widget.teamObject, selectedRequestTypeObjects[i]);
    // }
    

  }
   

  void loadEventPayment() {
    priceObject = userTeamDetails['price'];
  }

  void loadInitialData() async {
    print("loadInitialData() in TeamView");
    //wait for 3 seconds
    await Future.delayed(const Duration(seconds: 2));
    print("widget.teamObject "+widget.teamObject['events']['data'].toString());
    dynamic userTeamDetailsResp =  await TeamCommand().getUserTeamDetails(widget.teamObject);
    widget.setupPlayerList();    
    setState(() {
      userTeamDetails = userTeamDetailsResp;
      _isLoading = false;
    });
      print("userTeamDetails: " + userTeamDetails.toString());
      print("userTeamDetails['events']: " + userTeamDetails['events'].toString());
      print("loadInitialData() finished!");
      print("loadEventPayment() in loadInitialData()");
      loadEventPayment();
      print("loadEventPayment() finished in loadInitialData()");

  }


  void updateChatsList(dynamic createdChat){
    setState(() {
      userTeamDetails['team']['chats']['data'].add(createdChat);      
    });
  }
  

  @override 
  void initState() {
    super.initState();
    print("initState()");
    print("loadIinitialData() in initState()");
    loadInitialData();

    print("initState finished!");    
    // print("initState() in TeamView");
    // print("userTeamDetails: " + userTeamDetails.toString());
    
    
  }

  @override
  Widget build(BuildContext context) {
    print("build() in TeamView");
    print("teamObject: " + widget.teamObject.toString());
   return Scaffold(
  appBar: Headers().getBackHeader(context, widget.teamObject['name']),
  body: !_isLoading
      ? SingleChildScrollView(
            child: Center(
              child: Expanded(
                child: Column(
              children: [
              // userTeamDetails['isMine']
              //     ? 
                  Container(
                      height: 20,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(20.0),
                        child: GestureDetector(
                            onTap: () async {
                              print("onTap: ");

                              List<int>? playerIndexes =
                                  await showAnimatedDialog<dynamic>(
                                context: context,
                                barrierDismissible: true,
                                builder: (BuildContext context) {
                                  return ClassicListDialogWidget<dynamic>(
                                      selectedIndexes: widget.selectedPlayerIndexes,
                                      titleText: 'Choose Players',
                                      listType: ListType.multiSelect,
                                      positiveText: "Next",
                                      activeColor: Colors.green,
                                      dataList: widget.playerList);
                                },
                                animationType: DialogTransitionType.size,
                                curve: Curves.linear,
                              );
                              widget.selectedPlayerIndexes =
                                  playerIndexes ?? widget.selectedPlayerIndexes;
                              print(
                                  'selectedIndex:${widget.selectedPlayerIndexes?.toString()}');
                              playersSelected(widget.selectedPlayerIndexes!);

                              if (widget.playersSelectedList.length > 0) {
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
                                        dataList: widget.requestUserTypes);
                                  },
                                  animationType: DialogTransitionType.size,
                                  curve: Curves.linear,
                                );

                                widget.selectedRequestTypeIndexes =
                                    requestIndexes ?? widget.selectedRequestTypeIndexes;
                                print(
                                    'selectedIndex:${widget.selectedRequestTypeIndexes?.toString()}');
                                await requestTypeSelected(widget.selectedRequestTypeIndexes);
                                await sendPlayersTeamRequest();
                              }
                            },
                            child: Text("Invite Players")),
                      ),
                    ),                  
                    UpdateViewTeamForm(userObjectDetails: userTeamDetails),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  widget.getPriceWidget(userTeamDetails),
              userTeamDetails['isMine']
                  ? ElevatedButton(
                      onPressed: () {
                        // Add button onPressed logic here
                      },
                      child: Text('Update Payment'),
                    )
                  : Container(),
            ],
          ),         
        ])),
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
