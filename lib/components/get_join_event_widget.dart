import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:soccermadeeasy/strings.dart';

import '../commands/base_command.dart';
import '../commands/event_command.dart';
import '../commands/team_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../styles/colors.dart';
import '../styles/font_sizes.dart';
import '../views/chats/create.dart';
import '../views/game/view.dart';
import 'Buttons/basic_elevated_button.dart';
import 'Dialogues/alert_dialogue.dart';
import 'Dialogues/animated_dialogu.dart';
import 'Dialogues/bug_feedback_dialogue.dart';
import 'Mixins/event_mixin.dart';
import 'card_form_screen.dart';
import 'join_condition.dart';

class GetJoinEventWidget extends StatefulWidget with EventMixin {
  GetJoinEventWidget({
    Key? key,
    required this.mainEvent,
    required this.roles,
    required this.isMine,
    required this.price,
    required this.amountRemaining,
    this.eventRequestJoin,
    this.eventPaymentJoin,
    this.teamRequestJoin,
    this.teamPaymentJoin,
    required this.capacity,
    required this.numberOfPlayers,
    required this.fieldRating,
    required this.hostRating,
  }) : super(key: key);

  final dynamic mainEvent;
  final List<dynamic> roles;
  final JoinCondition? eventRequestJoin;
  final JoinCondition? eventPaymentJoin;
  final JoinCondition? teamRequestJoin;
  final JoinCondition? teamPaymentJoin;
  final bool isMine;
  final dynamic price;
  final String amountRemaining;
  int capacity;
  final int numberOfPlayers;
  final int fieldRating;
  final int hostRating;

  @override
  State<GetJoinEventWidget> createState() => _GetJoinEventWidgetState();
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

  dynamic getEventJoinConditions(dynamic joinConditions) {
    print("getEventJoinConditions");
    print("joinConditions: " + joinConditions.toString());
    dynamic joinConditionResp = null;
    joinConditions.forEach((joinCondition) {
      print("joinCondition: " + joinCondition.toString());
      if (joinCondition['forTeam'] != null) {
        print("in ifffff");
        joinConditionResp = joinCondition;
      }
    });

    return joinConditionResp;
  }

  void goToEvent() {
    print("goToEvent");
    Navigator.pop(context);
    // BaseCommand().popToHome(context);
  }

  void purchaseCheck(BuildContext context, dynamic event){
    print("purchaseCheck");
    print("widget.fieldRating: " + widget.fieldRating.toString());
    print("widget.hostRating: " + widget.hostRating.toString());
    if (widget.fieldRating == -1||widget.hostRating == -1) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialogueWidget(
            title: 'Confirmation',
            body: (widget.fieldRating == -1
                    ? StringConstants.NOFIELDRATINGWARNING + "\n\n"
                    : "") +
                (widget.hostRating == -1
                    ? StringConstants.NOHOSTRATINGWARNING + "\n\n"
                    : ""),
            onConfirmCallback: () async {
              // Logic for confirmation action
             purchaseEvent(context, event);
            },
            onCancelCallback: () {
              // Logic for cancel action
            },
          );
        },
      );
    }
    else{
      purchaseEvent(context, event);

    }

  }

  void purchaseEvent(BuildContext context, dynamic event) async {
    print("purchaseEvent");
     List<dynamic> roles = ["PLAYER"];
              String rolesString = BaseCommand().stringifyRoles(roles);
              dynamic subscriptionDetails = {
                "price": widget.price,
                "objectToPurchase": widget.mainEvent,
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

  Future<void> removeUserFromEvent(dynamic event, dynamic userObject,
      List<String> rolesToRemove, List<dynamic> existingRoles) async {
    List<dynamic> updatedRoles = [];
    // existingRoles.forEach((element) {
    //   if (!rolesToRemove.contains(element)) {
    //     updatedRoles.add(element);
    //   }
    // });
    
    // right now, organizer can't leave event,
    // remove event from user and user from event
    if (updatedRoles.isEmpty) {
      dynamic removeUserFromEventResp =
          await EventCommand().removeUserFromEvent(event, userObject);
      if (removeUserFromEventResp['success']) {
        print("removeUserFromEventResp: " + removeUserFromEventResp.toString());
        dynamic eventToRemove = removeUserFromEventResp['data'];

        EventCommand().updateViewModelsWithEvent(eventToRemove, false);
        setState(() {
          EventCommand().removeUserFromEventPageModel(event, userObject);
        });

      }
    } else {

    }
  }

  Future<void> addUserToEvent(dynamic event, userObject,
      List<dynamic> rolesToAdd, List<dynamic> existingRoles) async {
    List<dynamic> updatedRoles = [];
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

  Container sendOrganizerPlayerEventRequest(BuildContext context) {
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
                await sendEventRequest(
                    widget.mainEvent, result, primaryList, secondaryList);
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

  Widget getJoinEventWidget(BuildContext context) {
    print("getJoinEventWidget()");
    // dynamic eventJoinCondition =
    //     getEventJoinConditions(event['joinConditions']['data']);
    // print("eventJoinCondition: " + eventJoinCondition.toString());

    print("rolesss: " + widget.roles.toString());
    List<dynamic> existingRoles = widget.roles;
    print("aaaaa");

    //expired
    // Assuming widget.mainEvent['endTime'] is a String representing milliseconds since Epoch
    if (widget.mainEvent['endTime'] != null &&
        DateTime.fromMillisecondsSinceEpoch(
                int.parse(widget.mainEvent['endTime']))
            .isBefore(DateTime.now().subtract(Duration(hours: 1)))) {
      return BasicElevatedButton(
        backgroundColor: AppColors.tsnGreyerWhite,
        text: "Expired",
        fontSize: FontSizes.xxs(context),
        onPressed: () async {},
      );
    }

    //capacity(Join waitlist feature)
    else if (widget.numberOfPlayers >= widget.capacity) {
      return BasicElevatedButton(
        backgroundColor: AppColors.tsnGreen,
        text: "Join Waitlist",
        fontSize: FontSizes.xxs(context),
        onPressed: () async {
          // purchaseEvent(context, event);
        },
      );
    }
    //if not already a player
    else if (!widget.roles.contains("PLAYER")) {
      if (widget.isMine) {
        return Container(
            child: GestureDetector(
          onTap: () async {
            dynamic chooseRoleDialog =
                await widget.chooseRolesDialogue(context);
            if (chooseRoleDialog != null) {
              print("chooseRoleDialog: " + chooseRoleDialog.toString());
              List<dynamic> newRoles = chooseRoleDialog['rolesArray'];
              print("newRoles: " + newRoles.toString());
              String roles = BaseCommand()
                  .addRolesToExistingRoles(existingRoles, newRoles);
              EventCommand().addUserToEvent(event, userObject, roles);
            }
          },
          child: Text("Join my Event"),
        ));
      } else {
        //!withPayment&&!withRequest
        // if (!eventJoinCondition['withPayment'] &&
        //     !eventJoinCondition['withRequest']) {
        if (!widget.eventPaymentJoin!.required.value &&
            !widget.eventRequestJoin!.required.value) {
          //price exists(join with paying or not paying)
          if (widget.price != null) {
            return Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  GestureDetector(
                    onTap: () async {
                      print("!withPayment&&!withRequest");
                      dynamic chooseRoleDialog =
                          await widget.chooseRolesDialogue(context);
                      if (chooseRoleDialog != null) {
                        print(
                            "chooseRoleDialog: " + chooseRoleDialog.toString());
                        List<dynamic> roles = chooseRoleDialog['rolesArray'];
                        print("roles: " + roles.toString());
                        // purchaseEvent(context, event);
                        purchaseCheck(context, event);
                      }
                    },
                    child: Text("Join, Pay Now"),
                  ),
                  Container(
                      child: GestureDetector(
                    onTap: () async {
                      print("!withPayment&&!withRequest");
                      dynamic chooseRoleDialog =
                          await widget.chooseRolesDialogue(context);
                      if (chooseRoleDialog != null) {
                        print(
                            "chooseRoleDialog: " + chooseRoleDialog.toString());
                        List<dynamic> newRoles = chooseRoleDialog['rolesArray'];
                        String roles = BaseCommand()
                            .addRolesToExistingRoles(existingRoles, newRoles);
                        print("roles: " + roles.toString());
                        // purchaseEvent(context, event, roles, widget.userObjectDetails);
                        EventCommand().addUserToEvent(event, userObject, roles);
                      }
                    },
                    child: Text("Join, Pay Later"),
                  ))
                ]));
          }
          //price does not exist
          else {
            return Container(
                child: GestureDetector(
              onTap: () async {
                print("!withPayment&&!withRequest");
                dynamic chooseRoleDialog =
                    await widget.chooseRolesDialogue(context);
                if (chooseRoleDialog != null) {
                  print("chooseRoleDialog: " + chooseRoleDialog.toString());
                  List<dynamic> newRoles = chooseRoleDialog['rolesArray'];
                  String roles = BaseCommand()
                      .addRolesToExistingRoles(existingRoles, newRoles);
                  print("roles: " + roles.toString());
                  EventCommand().addUserToEvent(event, userObject, roles);
                }
              },
              child: Text("Join, Pay Later"),
            ));
          }
        }
        //!withPayment&&withRequestt
        else if (!widget.eventPaymentJoin!.required.value &&
            widget.eventRequestJoin!.required.value) {
          return sendOrganizerPlayerEventRequest(context);
        }
        //withPayment && !withRequest
        else if (widget.eventPaymentJoin!.required.value &&
            !widget.eventRequestJoin!.required.value) {
          //if amount is 0

          return BasicElevatedButton(
            backgroundColor: AppColors.tsnGreen,
            text: "Pay to Join Event",
            fontSize: FontSizes.xxs(context),
            onPressed: () async {
              // purchaseEvent(context, event);
              purchaseCheck(context, event);
            },
          );
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
              if ((double.parse(widget.amountRemaining) / 100)
                      .toStringAsFixed(2) !=
                  "0.00") {
                return Container(
                    child: GestureDetector(
                  onTap: () async {
                    print("withPayment && withRequest");
                    dynamic chooseRoleDialog =
                        await widget.chooseRolesDialogue(context);
                    if (chooseRoleDialog != null) {
                      print("chooseRoleDialog: " + chooseRoleDialog.toString());
                      List<String> roles = chooseRoleDialog['rolesArray'];
                      // BaseCommand().stringifyRoles(roles);
                      print("roles: " + roles.toString());
                      purchaseEvent(context, event);
                    }
                  },
                  child: Text("Pay to Join Event"),
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
              return sendOrganizerPlayerEventRequest(context);
            }
          } else {
            return sendOrganizerPlayerEventRequest(context);
          }
        }
      }
    } else {
    return 
    BasicElevatedButton(                                
                backgroundColor:
                    AppColors.tsnRed,
                text: "Leave",
                fontSize: FontSizes.xxs(context),
                onPressed: () async{
                  showDialog(
  context: context,
  builder: (BuildContext context) {
    return AlertDialogueWidget(
      title: 'Confirmation',
      body: StringConstants.LEAVEWARNING,
      onConfirmCallback: () async {
        // Logic for confirmation action
        await removeUserFromEvent(event, userObject, ["PLAYER"], existingRoles);
      },
      onCancelCallback: () {
        // Logic for cancel action
      },
    );
  },
);
                        
                },
              );
    }
  }
  

  void loadInitialData() {
    userObject = UserCommand().getAppModelUser();
    event = widget.mainEvent;
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
