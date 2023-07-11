import 'package:flutter/material.dart';

import '../commands/event_command.dart';
import '../commands/team_command.dart';
import '../commands/user_command.dart';
import '../constants.dart';
import '../views/chats/create.dart';
import '../views/game/view.dart';
import 'Dialogues/animated_dialogu.dart';
import 'card_form_screen.dart';

class GetJoinTeamWidget extends StatefulWidget {
  final Map<String, dynamic> userObjectDetails;

  GetJoinTeamWidget({required this.userObjectDetails});

  @override
  _GetJoinTeamWidgetState createState() => _GetJoinTeamWidgetState();
}

class _GetJoinTeamWidgetState extends State<GetJoinTeamWidget> {
  dynamic userObject;
  dynamic team;
  List<String> participationRoles = [];

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
    String roles = "{";
    //get roles
    participationRoles.forEach((element) {
      roles += element + ",";
    });
    //add new role
    roles += addRole;
    roles += "}";

    return roles;
  }

  void purchaseTeam(BuildContext context, dynamic team, String roles,
      dynamic userObjectDetails) async {
    dynamic subscriptionDetails = {
      "price": userObjectDetails['team']['price'],
      "objectToPurchase": team,
      "objectType": Constants.TEAM,      
    };
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => CardFormScreen(
              paymentDetails: subscriptionDetails)),
    );
    // await AdaptyPaymentService().makePurchase();
  }

  Future<void> sendTeamRequest(Map<int, dynamic> indexes,
      List<dynamic> primaryList, List<dynamic> secondaryList) async {
    print("sendTeamRequest");

    indexes.forEach((mainIndex, secondaryIndexes) async {
      dynamic requestChosen = primaryList[mainIndex];
      await TeamCommand().sendTeamOrganizersRequest(team, requestChosen);
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
                  await sendTeamRequest(result, primaryList, secondaryList );                 
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

  Container getJoinTeamWidget(BuildContext context, dynamic userObjectDetails) {
    print("getJoinTeamWidget");
    print(
        "userObjectDetails['roles']: " + userObjectDetails['roles'].toString());
    dynamic teamJoinCondition =
        getTeamJoinConditions(team['joinConditions']['data']);
    print("teamJoinCondition: " + teamJoinCondition.toString());
    //if not already a player
    if (!userObjectDetails['roles'].contains("PLAYER")) {
      String roles = addRoleToRoles("PLAYER");
      if (userObjectDetails['isMine']) {
        return Container(
            child: GestureDetector(
          onTap: () {
            print("onTap Join My Team");
            TeamCommand().addUserToTeam(team, userObject, roles);
          },
          child: Text("Join my Team"),
        ));
      } else {
        //!withPayment&&!withRequest
        if (!teamJoinCondition['withPayment'] &&
            !teamJoinCondition['withRequest']) {
          //price exists(join with paying or not paying)
          if (userObjectDetails['price'] != null) {
            return Container(
                child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                  GestureDetector(
                    onTap: () {
                      print("!withPayment&&!withRequest");
                      purchaseTeam(context, team, roles, userObjectDetails);
                    },
                    child: Text("Join Team, Pay Now"),
                  ),
                  Container(
                      child: GestureDetector(
                    onTap: () {
                      print("!withPayment&&!withRequest");
                      TeamCommand().addUserToTeam(team, userObject, roles);
                    },
                    child: Text("Join Team, Pay Later"),
                  ))
                ]));
          }
          //price does not exist
          else {
            return Container(
                child: GestureDetector(
              onTap: () {
                print("!withPayment&&!withRequest");
                TeamCommand().addUserToTeam(team, userObject, roles);
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
            onTap: () {
              print("withPayment && !withRequest");
              purchaseTeam(context, team, roles, userObjectDetails);
            },
            child: Text("Pay to Join Team"),
          ));
        }
        //withPayment && withRequest
        //find request element, else send request
        else {
          print("elseeee");
          print("userObject['requestsSent']: ${userObject['requestsSent']}");
          //check team request status
          dynamic requestElementObject;
          userObject['requestsSent']['data'].forEach((requestElement) {
            print("requestElement: $requestElement");
            print("team: " + team.toString());
            if (requestElement['type'] != 'TEAMREQUEST' &&
                requestElement['team']['_id'] == team['_id']) {
              requestElementObject = requestElement;
            }
          });
          if (requestElementObject != null) {
            print("requestElementObject['status']: " +
                requestElementObject['status'].toString());
            if (requestElementObject['status'].toString() == "ACCEPTED") {
              //if not paid off
              if ((double.parse(userObjectDetails['amountRemaining']) / 100)
                      .toStringAsFixed(2) !=
                  "0.00") {
                return Container(
                    child: GestureDetector(
                  onTap: () {
                    print("withPayment && withRequest");
                    purchaseTeam(context, team, roles, userObjectDetails);
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
        },
        child: Text("Leave Team"),
      ));
    }
  }

  void loadInitialData() {
    userObject = UserCommand().getAppModelUser();
    team = widget.userObjectDetails['team'];
  }

  @override
  void initState() {
    super.initState();
    print("initState() GetJoinTeamWidget");
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return getJoinTeamWidget(context, widget.userObjectDetails);
  }
}
