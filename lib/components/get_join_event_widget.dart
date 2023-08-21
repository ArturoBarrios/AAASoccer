import 'package:flutter/material.dart';

import '../commands/base_command.dart';
import '../commands/event_command.dart';
import '../commands/team_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../views/chats/create.dart';
import '../views/game/view.dart';
import 'Dialogues/animated_dialogu.dart';
import 'Mixins/event_mixin.dart';
import 'card_form_screen.dart';

class GetJoinEventWidget extends StatefulWidget with EventMixin {
  final Map<String, dynamic> userObjectDetails;

  GetJoinEventWidget({required this.userObjectDetails});

  @override
  _GetJoinEventWidgetState createState() => _GetJoinEventWidgetState();
}

class _GetJoinEventWidgetState extends State<GetJoinEventWidget> {
  dynamic userObject;
  dynamic event;  
  String roles = "";

  List requestUserTypes = [
    Constants.PLAYER.toString(),
    Constants.ORGANIZER.toString(),
    Constants.MANAGER.toString(),
    Constants.MAINCOACH.toString(),
    Constants.ASSISTANTCOACH.toString(),
    Constants.REF.toString(),
  ];


  dynamic getEventJoinConditions(dynamic joinConditions){
    print("getEventJoinConditions");
    print("joinConditions: "+joinConditions.toString());
    dynamic joinConditionResp = null;
    joinConditions.forEach((joinCondition) {
      print("joinCondition: "+ joinCondition.toString());
      if(joinCondition['forTeam']!=null){
        print("in ifffff");
        joinConditionResp = joinCondition;
      }
      
    });

    return joinConditionResp;

  }

  void goToEvent(){
    print("goToEvent");
    Navigator.pop(context);
    // BaseCommand().popToHome(context);
  }

  void purchaseEvent(BuildContext context, dynamic event, List<dynamic> roles,
      dynamic userObjectDetails) async {
    print("purchaseEvent");
    String rolesString = BaseCommand().stringifyRoles(roles);
     dynamic subscriptionDetails = {
      "price": userObjectDetails['mainEvent']['price'],
      "objectToPurchase": userObjectDetails['mainEvent'],
      "objectType": Constants.EVENT,    
      "roles": rolesString,  
      "forRole": Constants.PLAYER,
    };
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardFormScreen(
              paymentDetails: subscriptionDetails,
              callbackFunction: goToEvent,
              )),
    );

  }

  Future<void> removeUserFromEvent(dynamic event, dynamic userObject) async{
    dynamic removeUserFromEventResp = await 
      EventCommand().removeUserFromEvent(event, userObject);
    //remove event from user and user from event
    if(removeUserFromEventResp['success']){
      print("removeUserFromEventResp: "+removeUserFromEventResp.toString());
      dynamic eventToRemove = removeUserFromEventResp['data'];
      EventCommand().updateViewModelsWithEvent(eventToRemove, false);
      // setState(() {
      //   event['userParticipants']['data'].removeWhere((element) => element['user']['_id']==userObject['_id']);
      //   widget.userObjectDetails['roles'] = [];        
      // }); 
    }

  }

  String getRequestType(eventObject) {
    String type = "GAMEREQUEST";
    if (eventObject['type'] == "GAME") {
      type = "GAMEREQUEST";
    } else if (eventObject['type'] == "LEAGUE") {
      type = "LEAGUEREQUEST";
    } else if (eventObject['type'] == "TOURNAMENT") {
      type = "TOURNAMENTREQUEST";
    } else if (eventObject['type'] == "TRAINING") {
      type = "TRAININGREQUEST";
    } else if (eventObject['type'] == "TRYOUT") {
      type = "TRYOUTREQUEST";
    }
    return type;
  }

  //send organizers event request
  Future<void> sendEventRequest(dynamic eventObject, Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList) async {
    print("sendEventRequest");
    print("primaryList: " + primaryList.toString());
    print("secondaryList: " + secondaryList.toString());
    String requestType = getRequestType(eventObject);

    indexes.forEach((mainIndex, secondaryIndexesThatIsNull) async {
      dynamic role = primaryList[mainIndex];
      await EventCommand()
          .sendOrganizerEventRequest(eventObject, role, requestType);
    });

    // for (int i = 0; i < selectedRequestTypeObjects.length; i++) {
    //   await EventCommand().sendOrganizerEventRequest(
    //       eventObject, selectedRequestTypeObjects[i], requestType);
    // }
  }

  Container sendOrganizerPlayerEventRequest(
      BuildContext context, dynamic userObjectDetails) {
    return Container(
      height: 20,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20.0),
        child: GestureDetector(
            onTap: () async {
              List<dynamic> primaryList = requestUserTypes;
              List<dynamic> secondaryList = [];
              Map<int, dynamic> result = await showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AnimatedDialog(
                      details: {"title": "Send Organizer Player Event Request"},
                      items: primaryList,
                      singleSelect: false,
                      secondaryItems: secondaryList,
                      goToFunctions: []);
                },
              );
              if (result.isNotEmpty) {
                print('Selected items: $result');
                // await requestTypeSelected(selectedRequestTypeIndexes);
                await sendEventRequest(userObjectDetails['mainEvent'], result,
                    primaryList, secondaryList);
              }
            },
            child: Container(
              width: 200,
              height: 50,
              color: Colors.green,
              child: Center(child: Text("Send Player Request")),
            )),
      ),
    );
  }






  Container getJoinEventWidget(BuildContext context) {
    print("getJoinEventWidget()");
    dynamic eventJoinCondition = getEventJoinConditions(event['joinConditions']['data']);
    print("eventJoinCondition: "+eventJoinCondition.toString());
    print("rolesss: "+ widget.userObjectDetails['roles'].toString());
    List<dynamic> existingRoles = widget.userObjectDetails['roles'];
    //if not already a player
    if (!widget.userObjectDetails['roles'].contains("PLAYER")) {
      // String roles = addRoleToRoles("PLAYER");
      if (widget.userObjectDetails['isMine']) {
        return Container(
            child: GestureDetector(
          onTap: () async {
            print("onTap Join My Game");
            dynamic chooseRoleDialog = await widget.chooseRolesDialogue(context);
            if(chooseRoleDialog != null){
              print("chooseRoleDialog: "+chooseRoleDialog.toString());
              List<dynamic> newRoles = chooseRoleDialog['rolesArray'];                        
              print("newRoles: "+newRoles.toString());             
              String roles = BaseCommand().addRolesToExistingRoles(existingRoles, newRoles);                         
              EventCommand().addUserToEvent(event, userObject, roles);
            }
            
          },
          child: Text("Join my Game"),
        ));
      } else {
        //!withPayment&&!withRequest
        if (!eventJoinCondition['withPayment'] &&
            !eventJoinCondition['withRequest']) {
          //price exists(join with paying or not paying)
          if (widget.userObjectDetails['price'] != null) {
            return Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  GestureDetector(
                    onTap: () async{
                      print("!withPayment&&!withRequest");
                      dynamic chooseRoleDialog = await widget.chooseRolesDialogue(context);
                      if(chooseRoleDialog != null){
                        print("chooseRoleDialog: "+chooseRoleDialog.toString());
                        List<dynamic> roles = chooseRoleDialog['rolesArray'];                        
                        print("roles: "+roles.toString());
                        purchaseEvent(context, event, roles, widget.userObjectDetails);
                      }
                    },
                    child: Text("Join Game, Pay Now"),
                  ),
                  Container(
                      child: GestureDetector(
                    onTap: () async {
                      print("!withPayment&&!withRequest");
                      dynamic chooseRoleDialog = await widget.chooseRolesDialogue(context);
                      if(chooseRoleDialog != null){
                        print("chooseRoleDialog: "+chooseRoleDialog.toString());
                        List<dynamic> newRoles = chooseRoleDialog['rolesArray'];
                        String roles = BaseCommand().addRolesToExistingRoles(existingRoles, newRoles);                        
                        print("roles: "+roles.toString());
                        // purchaseEvent(context, event, roles, widget.userObjectDetails);
                        EventCommand().addUserToEvent(event, userObject, roles);
                      }
                    },
                    child: Text("Join Gameeee, Pay Later"),
                  ))
                ]));
          }
          //price does not exist
          else {
            return Container(
                child: GestureDetector(
              onTap: () async {
                print("!withPayment&&!withRequest");                
                dynamic chooseRoleDialog = await widget.chooseRolesDialogue(context);
                if(chooseRoleDialog != null){
                  print("chooseRoleDialog: "+chooseRoleDialog.toString());
                  List<dynamic> newRoles = chooseRoleDialog['rolesArray'];
                  String roles = BaseCommand().addRolesToExistingRoles(existingRoles, newRoles);                        
                  print("roles: "+roles.toString());                  
                  EventCommand().addUserToEvent(event, userObject, roles);
                }
              },
              child: Text("Join Game, Pay Later"),
            ));
          }
        }
        //!withPayment&&withRequestt
        else if (!eventJoinCondition['withPayment'] &&
            eventJoinCondition['withRequest']) {
          return sendOrganizerPlayerEventRequest(context, widget.userObjectDetails);
        }
        //withPayment && !withRequest
        else if (eventJoinCondition['withPayment'] &&
            !eventJoinCondition['withRequest']) {
          //if amount is 0

          return Container(
              child: GestureDetector(
            onTap: () async{
              print("withPayment && !withRequest");
              dynamic chooseRoleDialog = await widget.chooseRolesDialogue(context);
              if(chooseRoleDialog != null){
                print("chooseRoleDialog: "+chooseRoleDialog.toString());
                List<dynamic> roles = chooseRoleDialog['rolesArray'];
                // BaseCommand().stringifyRoles(roles);
                print("roles: "+roles.toString());
                purchaseEvent(context, event, roles, widget.userObjectDetails);
              }              
            },
            child: Text("Pay to Join Game"),
          ));
        }
        //withPayment && withRequest
        //find request element, else send request
        else {
          print("elseeee");
          print("userObject['requestsSent']: ${userObject['requestsSent']}");
          //check event request status
          dynamic requestElementObject;
          userObject['requestsSent']['data'].forEach((requestElement) {
            print("requestElement: $requestElement");
            print("event: " + event.toString());
            if (requestElement['type'] != 'TEAMREQUEST' &&
                requestElement['event']['_id'] == event['_id']) {
              requestElementObject = requestElement;
            }
          });
          if (requestElementObject != null) {
            print("requestElementObject['status']: " +
                requestElementObject['status'].toString());
            if (requestElementObject['status'].toString() == "ACCEPTED") {
              //if not paid off
              if ((double.parse(widget.userObjectDetails['amountRemaining']) / 100)
                      .toStringAsFixed(2) !=
                  "0.00") {
                return Container(
                    child: GestureDetector(
                  onTap: () async{
                    print("withPayment && withRequest");
                    dynamic chooseRoleDialog = await widget.chooseRolesDialogue(context);
                      if(chooseRoleDialog != null){
                        print("chooseRoleDialog: "+chooseRoleDialog.toString());
                        List<String> roles = chooseRoleDialog['rolesArray'];
                        // BaseCommand().stringifyRoles(roles);
                        print("roles: "+roles.toString());
                        purchaseEvent(context, event, roles, widget.userObjectDetails);
                      }                    
                  },
                  child: Text("Pay to Join Game"),
                ));
              }
              //paid off
              else {
                return Container();
              }
            } else if (requestElementObject['status'].toString() == "PENDING") {
              return Container(
                  child: GestureDetector(
                onTap: () {
                  print("WAITING FOR REQUEST TO BE ACCEPTED");
                },
                child: Text("Request Pending"),
              ));
            } else {
              return sendOrganizerPlayerEventRequest(
                  context, widget.userObjectDetails);

            }
          } else {
            return sendOrganizerPlayerEventRequest(context, widget.userObjectDetails);

          }
        }
      }
    } else {
      return Container(
          child: GestureDetector(
        onTap: () async {
          print("onTap Leave Game");
          print("onTap Join My Game");
          dynamic chooseRoleDialog = await widget.chooseRolesDialogue(context);
          if(chooseRoleDialog != null){
            print("chooseRoleDialog: "+chooseRoleDialog.toString());
            List<String> roles = chooseRoleDialog['rolesArray'];
            // BaseCommand().stringifyRoles(roles);
            print("roles: "+roles.toString());
            removeUserFromEvent(event, userObject);                        
          }                    
            
        },
        child: Text("Leave Game"),
      ));
    }
  }
 

  

  void loadInitialData() {
    userObject = UserCommand().getAppModelUser();
    event = widget.userObjectDetails['mainEvent'];
  }

  @override
  void initState() {
    super.initState();
    print("initState() GetJoinEventWidget");
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return getJoinEventWidget(context);
  }
}
