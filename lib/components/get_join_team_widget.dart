import 'dart:developer';

import 'package:flutter/material.dart';

import '../commands/base_command.dart';
import '../commands/event_command.dart';
import '../commands/team_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../views/chats/create.dart';
import '../views/game/view.dart';
import 'Dialogues/animated_dialogu.dart';
import 'Mixins/team_mixin.dart';
import 'card_form_screen.dart';

class GetJoinTeamWidget extends StatefulWidget with TeamMixin {
  final dynamic team;
  final dynamic user;
  final List<dynamic> roles;
  final bool isMine;
  final dynamic price;
  final String amountRemaining;

  GetJoinTeamWidget({
    required this.team,
    required this.user,
    required this.roles,
    required this.isMine,
    required this.price,
    required this.amountRemaining,
  });

  @override
  _GetJoinTeamWidgetState createState() => _GetJoinTeamWidgetState();
}

class _GetJoinTeamWidgetState extends State<GetJoinTeamWidget> {
  // dynamic userObject;

  // List<String> participationRoles = [];

  dynamic getTeamJoinConditions(dynamic joinConditions) {
    print("getTeamJoinConditions");
    print("joinConditions: " + joinConditions.toString());
    dynamic joinConditionResp = null;
    joinConditions.forEach((joinCondition) {
      print("joinCondition: " + joinCondition.toString());
      if (joinCondition['forEvent'] == null) {
        joinConditionResp = joinCondition;
      }
    });

    return joinConditionResp;
  }

  String addRoleToRoles(String addRole) {
    String rolesString = "{";
    //get roles
    widget.roles.forEach((element) {
      rolesString += element + ",";
    });
    //add new role
    rolesString += addRole;
    rolesString += "}";

    return rolesString;
  }

  void goToTeam() {
    Navigator.pop(context);
  }

  void purchaseTeam(
      BuildContext context, dynamic team, List<dynamic> roles) async {
    dynamic subscriptionDetails = {
      "price": widget.team['price'],
      "objectToPurchase": widget.team,
      "objectType": Constants.TEAM,
      "roles": BaseCommand().stringifyRoles(roles),
      "forRole": Constants.PLAYER,
    };

    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardFormScreen(
                paymentDetails: subscriptionDetails,
                callbackFunction: goToTeam,
              )),
    );
    // await AdaptyPaymentService().makePurchase();
  }

  void leaveTeam(String roles, String roleToLeave) {
    // if (roles == "{}") {
    //   UserCommand().leaveTeam(team, roles);
    // } else {
    //   TeamCommand().updateTeamUserParticipant(team, roles);
    // }
    // print("removeTeam");
    // print("roles: " + roles.toString());
    // UserCommand().leaveTeam(team, roles);
  }

  Future<void> sendTeamRequest(Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList) async {
    print("sendTeamRequest");

    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic requestChosen = primaryList[mainIndex];
      await TeamCommand().sendTeamOrganizersRequest(widget.team, requestChosen);
    });
  }

  List requestUserTypes = [
    Constants.PLAYER.toString(),
    Constants.ORGANIZER.toString(),
    Constants.MANAGER.toString(),
    Constants.MAINCOACH.toString(),
    Constants.ASSISTANTCOACH.toString(),
    Constants.REF.toString(),
  ];

  Container sendTeamRequestContainer() {
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
                        details: {"title": "Send Player Events Request"},
                        items: primaryList,
                        singleSelect: false,
                        secondaryItems: secondaryList,
                        goToFunctions: []);
                  },
                );
                if (result.isNotEmpty) {
                  await sendTeamRequest(result, primaryList, secondaryList);
                }
                // List<int>? requestIndexes =
                //     await showAnimatedDialog<dynamic>(
                //   context: context,
                //   barrierDismissible: true,
                //   builder: (BuildContext context) {
                //     return ClassicListDialogWidget<dynamic>(
                //         selectedIndexes: widget.selectedRequestTypeIndexes,
                //         titleText: 'Choose User Type',
                //         positiveText: "Send Request",
                //         listType: ListType.multiSelect,
                //         activeColor: Colors.green,
                //         dataList: widget.requestUserTypes);
                //   },
                //   animationType: DialogTransitionType.size,
                //   curve: Curves.linear,
                // );

                // await sendTeamRequest();
              },
              child: Text("Request to Join")),
        ));
  }

  Container getJoinTeamWidget(BuildContext context) {
    print("getJoinTeamWidget");

    dynamic teamJoinCondition =
        getTeamJoinConditions(widget.team['joinConditions']['data']);
    print("teamJoinCondition: " + teamJoinCondition.toString());
    print("rolesss: " + widget.roles.toString());
    List<dynamic> existingRoles = widget.roles;
    //if not already a player
    if (!widget.roles.contains("PLAYER")) {
      String roles = addRoleToRoles("PLAYER");
      if (widget.isMine) {
        return Container(
            child: GestureDetector(
          onTap: () async {
            print("onTap Join My Team");
            dynamic chooseRoleDialog =
                await widget.chooseRolesDialogue(context);
            if (chooseRoleDialog != null) {
              print("chooseRoleDialog: " + chooseRoleDialog.toString());
              List<dynamic> newRoles = chooseRoleDialog['rolesArray'];
              print("newRoles: " + newRoles.toString());
              String roles = BaseCommand()
                  .addRolesToExistingRoles(existingRoles, newRoles);
              TeamCommand().addUserToTeam(widget.team, widget.user, roles);
            }
          },
          child: Text("Join my Team"),
        ));
      } else {
        //!withPayment&&!withRequest
        if (!teamJoinCondition['withPayment'] &&
            !teamJoinCondition['withRequest']) {
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
                        purchaseTeam(context, widget.team, roles);
                      }
                    },
                    child: Text("Join Team, Pay Now"),
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
                        TeamCommand()
                            .addUserToTeam(widget.team, widget.user, roles);
                      }
                    },
                    child: Text("Join Team, Pay Later"),
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
                  TeamCommand().addUserToTeam(widget.team, widget.user, roles);
                }
              },
              child: Text("Join Team, Pay Later"),
            ));
          }
        }
        //!withPayment&&withRequestt
        else if (!teamJoinCondition['withPayment'] &&
            teamJoinCondition['withRequest']) {
          return sendTeamRequestContainer();
        }
        //withPayment && !withRequest
        else if (teamJoinCondition['withPayment'] &&
            !teamJoinCondition['withRequest']) {
          //if amount is 0

          return Container(
              child: GestureDetector(
            onTap: () async {
              print("withPayment && !withRequest");
              dynamic chooseRoleDialog =
                  await widget.chooseRolesDialogue(context);
              if (chooseRoleDialog != null) {
                print("chooseRoleDialog: " + chooseRoleDialog.toString());
                List<dynamic> roles = chooseRoleDialog['rolesArray'];
                // BaseCommand().stringifyRoles(roles);
                print("roles: " + roles.toString());
                purchaseTeam(context, widget.team, roles);
              }
            },
            child: Text("Pay to Join Team"),
          ));
        }
        //withPayment && withRequest
        //find request element, else send request
        else {
          print("elseeee");
          print("userObject['requestsSent']: ${widget.user['requestsSent']}");
          //check team request status
          dynamic requestElementObject;
          widget.user['requestsSent']['data'].forEach((requestElement) {
            print("requestElement: $requestElement");
            print("team: " + widget.team.toString());
            if (requestElement['type'] != 'TEAMREQUEST' &&
                requestElement['team']['_id'] == widget.team['_id']) {
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
                      purchaseTeam(context, widget.team, roles);
                    }
                  },
                  child: Text("Pay to Join Team"),
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
              return sendTeamRequestContainer();
              // return sendEventRequestForMyTeamWidget(
              //     context, userObjectDetails);
            }
          } else {
            return sendTeamRequestContainer();
            // return sendEventRequestForMyTeamWidget(context, userObjectDetails);
          }
        }
      }
    } else {
      return Container(
          child: GestureDetector(
        onTap: () {
          print("onTap Leave Team");
          String roleToLeave = "PLAYER";
          // leaveTeam(roles, roleToLeave);
        },
        child: Text("Leave Team"),
      ));
    }
  }

  void loadInitialData() {
    // userObject = UserCommand().getAppModelUser();
    // team = widget.userObjectDetails['team'];
  }

  @override
  void initState() {
    super.initState();
    print("initState() GetJoinTeamWidget");
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return getJoinTeamWidget(context);
  }
}
