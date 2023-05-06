import 'package:flutter/material.dart';
import 'package:auto_size_text/auto_size_text.dart';
// import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/commands/team_command.dart';
import '../Mixins/event_mixin.dart';
import '../../commands/player_command.dart';
import '../../constants.dart';
import '../../svg_widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../commands/game_command.dart';
import '../../views/team/view.dart';

class TeamCard extends StatefulWidget with EventMixin {
   TeamCard(
      {Key? key, required this.teamObject, required this.svgImage,
        required this.userTeamDetails
      })
      : super(key: key);
  final Map<String, dynamic> teamObject;
  final Svg svgImage;
  final double bevel = 10.0;
  final dynamic userTeamDetails;

  @override
  State<TeamCard> createState() => _TeamCard();
}

void teamClicked() {
  print("Team Clicked");
}

Future<Map<String, dynamic>> removeTeam(dynamic teamObject) async {
  print("deleteTeam for gameobject: $teamObject");
  Map<String, dynamic> deleteTeamResp = {
    "success": false,
    "message": "Team deleted successfully"
  };
  Map<String, dynamic> removeTeamResponse = await TeamCommand()
      .removeTeam(teamObject["_id"]);
  // print("deleteTeamResponse: $deleteTeamResponse");
  // if (deleteTeamResponse["success"]) {
  //   deleteTeamResp["success"] = true;
  // }

  return deleteTeamResp;
}

class _TeamCard extends State<TeamCard> {
  final bool _isPressed = false;
  final Color color = Colors.grey.shade200;

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.orange.shade500,
      textStyle: const TextStyle(fontSize: 20));
  final imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555";

  //     int selectIndex = 0;  
  // int chosenRequestType = 0;
  // List requestUserTypes = [
  //   Constants.PLAYER.toString(),
  //   Constants.ORGANIZER.toString(),
  //   Constants.MANAGER.toString(),
  //   Constants.MAINCOACH.toString(),
  //   Constants.ASSISTANTCOACH.toString(),
  //   Constants.REF.toString(),
  // ];
  // List playerList = [];
  // List playersSelectedList = [];
  // List<int>? selectedPlayerIndexes;
  // List<int>? selectedRequestTypeIndexes;
  // List<String> selectedRequestTypeObjects = [];

  void setupPlayerList() {
    widget.setupPlayerList();   
  }

  void playersSelected(List<int> selectedIndexes) {
    widget.playersSelected(selectedIndexes);
    // print("playersSelected: $selectedIndexes");
    // selectedPlayerIndexes = selectedIndexes;
    // playersSelectedList = [];
    // for (int i = 0; i < selectedIndexes.length; i++) {
    //   playersSelectedList.add(playerList[selectedIndexes[i]]);
    // }    
  }

  requestTypeSelected(List<int>? indexes) {
      widget.requestTypeSelected(indexes);
      // print("requestTypeSelected: " + indexes.toString());
      // selectedRequestTypeIndexes = indexes;
      //  for(int i = 0; i < indexes!.length; i++){
      //     selectedRequestTypeObjects.add(requestUserTypes[indexes[i]]);      
      //   }      

    }

    Future<void> sendPlayersTeamRequest() async{
      widget.sendPlayersTeamRequest(widget.teamObject);
      // print("sendPlayersEventRequest");            
      // print("selectedRequestTypeObjects.length: " + selectedRequestTypeObjects.length.toString());      
      // print("playersSelectedList.length: " + playersSelectedList.length.toString());
      // print("selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
      // print("send player event request");
      // for(int i = 0; i< playersSelectedList.length;i++){
      //   await TeamCommand().sendPlayerTeamRequests(playersSelectedList[i],[widget.teamObject], selectedRequestTypeObjects);
      // }
      
    }

    @override
    void initState() {
      super.initState();
     print("initState");
     print("userTeamDetails: " + widget.userTeamDetails.toString());
    }
  @override
  Widget build(BuildContext context) {
    print("build() for TeamCard()");
    print("widget name: ");
    print(widget.teamObject.toString());
    setupPlayerList();
    return Listener(
        child: GestureDetector(
      onTap: () {
        showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return TeamView(teamObject: widget.teamObject, userTeamDetails: widget.userTeamDetails);
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
                    text: widget.teamObject['name'],
                    svgImage: widget.svgImage,
                    subtitle:
                        "test subtitle", //widget.teamObject['description'],
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
                      titleText: 'Are you sure you want to delete this team?',
                      contentText: '',
                      onPositiveClick: () {
                        Navigator.of(context).pop();
                        removeTeam(widget.teamObject);
                       
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
            GestureDetector(
              onTap: () {

                TeamCommand().sendTeamOrganizersRequest(widget.teamObject, "PLAYER");
              },
              child: Container(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(20.0),
                  child: Image(
                    width: 20,
                    height: 20,
                    image: SVGWidgets().getSoccerBallSVGImage(),
                    color: Colors.white,
                  ),
                ),
              ),
            ),

            widget.userTeamDetails['isMine'] ? 
                    Container(
                    height:20,
            child: ClipRRect(
                borderRadius: BorderRadius.circular(20.0),
                child:         GestureDetector(
          onTap: () async {
            print("onTap: ");
            
            List<int>? playerIndexes = await showAnimatedDialog<dynamic>(
              context: context,
              barrierDismissible: true,
              builder: (BuildContext context) {
                return ClassicListDialogWidget<dynamic>(
                    selectedIndexes: widget.selectedPlayerIndexes,
                    titleText: 'Choose Players',
                    listType: ListType.multiSelect,
                    positiveText: "Next",
                    // onPositiveClick: () async{
                    //   print("onPositiveClick: " );
                    //   print("selectIndex: " + index.toString());
                    //   //navigation add
                     
                    // },
                    activeColor: Colors.green,
                    dataList: widget.playerList);
              },
              animationType: DialogTransitionType.size,
              curve: Curves.linear,
            );
            widget.selectedPlayerIndexes = playerIndexes ?? widget.selectedPlayerIndexes;
            print('selectedIndex:${widget.selectedPlayerIndexes?.toString()}');
            playersSelected(widget.selectedPlayerIndexes!);
            
            if(widget.playersSelectedList.length > 0){
              List<int>? requestIndexes = await showAnimatedDialog<dynamic>(
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

                        widget.selectedRequestTypeIndexes = requestIndexes ?? widget.selectedRequestTypeIndexes;
                        print('selectedIndex:${widget.selectedRequestTypeIndexes?.toString()}');
                        requestTypeSelected(widget.selectedRequestTypeIndexes);
                        sendPlayersTeamRequest();
            }
          },


          child: Text("Invite Players")
                  ),
                ),
          ) : Container(),

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
