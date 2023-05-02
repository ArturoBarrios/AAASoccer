import 'package:flutter/material.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/components/Mixins/event_mixin.dart';
import '../../svg_widgets.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import '../../commands/game_command.dart';
import '../../views/game/view.dart';
import '../../views/game/update.dart';
import 'package:soccermadeeasy/constants.dart';

import '../Mixins/event_mixin.dart';

class PickupCard2 extends StatefulWidget with EventMixin {
  PickupCard2(
      {Key? key, required this.gameObject, required this.svgImage, required this.userEventDetails })
      : super(key: key);
  final Map<String, dynamic> gameObject;
  final Svg svgImage;
  final dynamic userEventDetails;
  final double bevel = 10.0;

  @override
  State<PickupCard2> createState() => _PickupCard2();
}

void pickupClicked() {
  print("Pickup Clicked");
}

Future<Map<String, dynamic>> archivePickup(dynamic gameObject) async {
  print("archivePickup for gameobject: $gameObject");
  Map<String, dynamic> archivePickupResp = {
    "success": false,
    "message": "Pickup deleted successfully"
  };
  Map<String, dynamic> archivePickupResponse = await GameCommand()
      .archiveGame(gameObject['event']['_id'], gameObject["_id"]);
  print("archivePickupResponse: $archivePickupResponse");
  if (archivePickupResponse["success"]) {
    archivePickupResp["success"] = true;
  }

  return archivePickupResp;
}
Future<Map<String, dynamic>> removePickup(dynamic gameObject) async {
  print("removePickup for gameobject: $gameObject");
  Map<String, dynamic> removePickupResp = {
    "success": false,
    "message": "Pickup removed successfully"
  };
  Map<String, dynamic> removePickupRespResponse = await GameCommand()
      .removeGame(gameObject["_id"], gameObject["games"]["data"][0]["_id"]);
  print("removePickupRespResponse: $removePickupRespResponse");
  if (removePickupRespResponse["success"]) {
    removePickupRespResponse["success"] = true;
  }

  return removePickupRespResponse;
}


class _PickupCard2 extends State<PickupCard2> {
  // int selectIndex = 0;  
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
    // print("setupPlayerList");
    // playerList = PlayerCommand().getAppModelPlayersNearMe();
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

    

    Future<void> sendEventRequest() async {
      widget.sendEventRequest(widget.gameObject, {0: {}}, widget.requestUserTypes, []);
    // print("sendEventRequest");
    // print("selectedRequestTypeObjects.length: " +
    //     selectedRequestTypeObjects.length.toString());    
    // print(
    //     "selectedRequestTypeObjects: " + selectedRequestTypeObjects.toString());
    // print("send player event request");
    // for(int i = 0;i<selectedRequestTypeObjects.length;i++){
    //   await EventCommand().sendOrganizerEventRequest(widget.gameObject, selectedRequestTypeObjects[i], Constants.GAMEREQUEST.toString());
    // }
    
  }




  final bool _isPressed = false;
  final Color color = Colors.grey.shade200;

  final ButtonStyle style = ElevatedButton.styleFrom(
      primary: Colors.orange.shade500,
      textStyle: const TextStyle(fontSize: 20));
  final imageUrl =
      "https://firebasestorage.googleapis.com/v0/b/flutterbricks-public.appspot.com/o/illustrations%2Fundraw_Working_late_re_0c3y%201.png?alt=media&token=7b880917-2390-4043-88e5-5d58a9d70555";
  @override
  Widget build(BuildContext context) {    
    print("widget: ");
    print("widget.gameObject.toString(): "+widget.gameObject.toString());
    print("widget.isMyEvent.toString(): "+widget.userEventDetails.toString());
    setupPlayerList();

    return Listener(
        child: GestureDetector(
      onTap: () {
        showAnimatedDialog(
          context: context,
          barrierDismissible: true,
          builder: (BuildContext context) {
            return 
            // widget.isMyEvent ? 
              // GameUpdate(game: widget.gameObject);
              // :
              PickupView(userEventDetails: widget.userEventDetails ,game: widget.gameObject);
          },
          animationType: DialogTransitionType.slideFromBottom,
          curve: Curves.fastOutSlowIn,
          duration: Duration(seconds: 0),
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
                  //todo IDK you may have to change this.....
                    text: widget.gameObject['event']['name'], //widget.eventObject.containsKey("event") ? widget.eventObject['event']['name'] : widget.eventObject['name'],
                    svgImage: widget.svgImage,
                    subtitle: widget.gameObject['event']['name']
                        //widget.eventObject.containsKey("event") ? widget.eventObject['event']['name'] : widget.eventObject['name'], //widget.eventObject['description'],
                        ,
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
                              titleText: 'Are you sure you want to delete this event?',
                              contentText: '',
                              onPositiveClick: () {
                                Navigator.of(context).pop();
                                //delete event aaa
                                print(widget.gameObject.toString());
                                archivePickup(widget.gameObject);
                                // removePickup(widget.eventObject);
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
                    !widget.userEventDetails['isMyEvent'] ? 
                    Container(
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
                        await sendEventRequest();
                      },
                      child: Text("Send Request")),
                ),
              )
                    : 
                    Text("Join Your Game")
                    ,

                    widget.userEventDetails['isMyEvent'] ? 
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
                        //uncomment this 
                        // widget.sendPlayersEventRequest();
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
