import 'package:flutter/material.dart';
import 'package:soccermadeeasy/components/profile.dart';

import '../commands/base_command.dart';
import '../commands/event_command.dart';
import '../commands/team_command.dart';
import '../constants.dart';
import 'Dialogues/animated_dialogu.dart';

class PlayerList extends StatefulWidget {
  final dynamic playersDetails;

  PlayerList({required this.playersDetails});

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  bool _isExpanded = true;
  String _selectedUserType = "PLAYER"; // Default selection: "PLAYER"
  List<String> _userTypes = [
    "PLAYER",
    "ORGANIZER",
    "MAINCOACH",
    "MANAGER",
    "ASSISTANTCOACH",
    "REF"
  ];
  List requestUserTypes = [
    Constants.PLAYER.toString(),
    Constants.ORGANIZER.toString(),
    Constants.MANAGER.toString(),
    Constants.MAINCOACH.toString(),
    Constants.ASSISTANTCOACH.toString(),
    Constants.REF.toString(),
  ];
  void _showPlayerDetailsDialog(BuildContext context, String userName) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Player Details'),
          content: Text('This is ' + userName + '.'),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }

  Future<void> removePlayerRole(dynamic user) async {
    print("removePlayerRoler");

    int index = widget.playersDetails['userParticipants'].indexWhere(
        (userParticipant) => userParticipant['user']['_id'] == user['_id']);
    print("indexWhere:" + index.toString());
    if (index != -1) {
      print("in ifff");
      // Replace item at found index
      dynamic userParticipantRemoved =
          widget.playersDetails['userParticipants'].removeAt(index);

      List<String> userRoles = getUserRoles(userParticipantRemoved);
      print("userRoles before remove: " + userRoles.toString());
      userRoles.remove(_selectedUserType);
      print("userRoles after remove: " + userRoles.toString());
      String newRolesString = BaseCommand().stringifyRoles(userRoles);
      if (widget.playersDetails['team'] != null) {
        dynamic removeUsersFromTeamResp = await TeamCommand()
            .updateTeamUserParticipant(userParticipantRemoved, newRolesString);
        print("removeUsersFromTeamResp: " + removeUsersFromTeamResp.toString());
        if (removeUsersFromTeamResp['success']) {
          print("successfully removed user role from TeamUserParticipant;");
          dynamic teamUserParticipant = removeUsersFromTeamResp['data'];
          setState(() {
            widget.playersDetails['userParticipants'].add(teamUserParticipant);
          });
          print("done");
        }
      } else {
        dynamic removeUsersFromEventResp = await EventCommand()
            .updateEventUserParticipant(userParticipantRemoved, newRolesString);
        print(
            "removeUsersFromEventResp: " + removeUsersFromEventResp.toString());
        if (removeUsersFromEventResp['success']) {
          print("successfully removed user role from EventUserParticipant;");
          dynamic eventUserParticipant = removeUsersFromEventResp['data'];
          setState(() {
            widget.playersDetails['userParticipants'].add(eventUserParticipant);
          });
          print("done");
        }
      }
    }
  }

  Future<void> updatePlayerRequest(
    dynamic user,
    Map<int, dynamic> indexes,
    List<dynamic> primaryList,
  ) async {
    print("updatePlayerRequest");
    print("user: " + user.toString());
    print("indexes: " + indexes.toString());
    print("primaryList: " + primaryList.toString());

    int index = widget.playersDetails['userParticipants'].indexWhere(
        (userParticipant) => userParticipant['user']['_id'] == user['_id']);
    print("indexWhere:" + index.toString());
    dynamic userParticipantRemoved =
        widget.playersDetails['userParticipants'].removeAt(index);
    List<String> userRoles = getUserRoles(userParticipantRemoved);
    indexes.forEach((mainIndex, secondaryIndexes) async {
      userRoles.add(primaryList[mainIndex]);
    });
    String newRolesString = BaseCommand().stringifyRoles(userRoles);
    if (widget.playersDetails['team'] != null) {
      dynamic updateUserParticipantResp = await TeamCommand()
          .updateTeamUserParticipant(userParticipantRemoved, newRolesString);
      print(
          "updateUserParticipantResp: " + updateUserParticipantResp.toString());
      if (updateUserParticipantResp['success']) {
        print("successfully updated Team User participant");
        dynamic teamUserParticipant = updateUserParticipantResp['data'];
        setState(() {
          widget.playersDetails['userParticipants'].add(teamUserParticipant);
        });
        String currentlySelectedUserType = _selectedUserType;
        print("done adding back to widget.palyersDetails['userParticipants']");
      }
    } else {
      dynamic updateUserParticipantResp = await EventCommand()
          .updateEventUserParticipant(userParticipantRemoved, newRolesString);
      print(
          "updateUserParticipantResp: " + updateUserParticipantResp.toString());
      if (updateUserParticipantResp['success']) {
        print("successfully updated Event User participant");
        dynamic eventUserParticipant = updateUserParticipantResp['data'];
        setState(() {
          widget.playersDetails['userParticipants'].add(eventUserParticipant);
        });
        String currentlySelectedUserType = _selectedUserType;
        print("done adding back to widget.palyersDetails['userParticipants']");
      }
    }
  }

  Future<void> removePlayer(dynamic user) async {
    //remove player from team
    if (widget.playersDetails['team'] != null) {
      dynamic removeUsersFromTeamResp = await TeamCommand()
          .removeUsersFromTeam(widget.playersDetails['team'], [user]);
      print("removeUsersFromTeamResp: " + removeUsersFromTeamResp.toString());
      if (removeUsersFromTeamResp['success']) {
        setState(() {
          widget.playersDetails['userParticipants'].removeWhere(
              (userParticipant) =>
                  userParticipant['user']['_id'] == user['_id']);
        });
      }
    } else {
      dynamic removeUsersFromEventResp = await EventCommand()
          .removeUsersFromEvent(widget.playersDetails['event'], [user]);
      print("removeUsersFromEventResp: " + removeUsersFromEventResp.toString());
      if (removeUsersFromEventResp['success']) {
        setState(() {
          widget.playersDetails['userParticipants'].removeWhere(
              (userParticipant) =>
                  userParticipant['user']['_id'] == user['_id']);
        });
      }
    }
  }

  @override
  void initState() {
    super.initState();
    print("initState PlayerList Widget ");
    print("playerDetails: " + widget.playersDetails.toString());
    print("playerDetails['userParticipants']: " +
        widget.playersDetails['userParticipants'].toString());
  }

  List<String> getUserRoles(dynamic userParticipant) {
    print("getUserRoles(): " + userParticipant.toString());
    List<String> roles = BaseCommand().parseRoles(userParticipant['roles']);
    print("roles: " + roles.toString());
    return roles;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        borderRadius: BorderRadius.circular(5.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextButton(
            onPressed: () {
              setState(() {
                _isExpanded = !_isExpanded;
              });
            },
            child: Text(
              _selectedUserType,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 18,
              ),
            ),
          ),
          if (_isExpanded)
            Container(
              padding: EdgeInsets.all(8.0),
              child: Wrap(
                spacing: 8.0,
                children: _userTypes.map((userType) {
                  return FilterChip(
                    label: Text(userType),
                    onSelected: (isSelected) {
                      setState(() {
                        if (isSelected) {
                          _selectedUserType = userType;
                        }
                      });
                    },
                    selected: _selectedUserType == userType,
                  );
                }).toList(),
              ),
            ),
          Column(
            children: widget.playersDetails['userParticipants']
                .where((userParticipant) {
              List<dynamic> userRoles = getUserRoles(userParticipant);
              return userRoles.contains(_selectedUserType);
            }).map<Widget>((userParticipant) {
              dynamic user = userParticipant['user'];
              dynamic profileDetails = {
                "user": user,
                "isMine": false,
              };
              return 
              InkWell(
                onTap: () {
Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Profile(
                profileDetails: profileDetails,
              )),
    );
                },
                child:
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(user['username']),
                      ),
                      IconButton(
                        icon: Icon(Icons.info),
                        onPressed: () {
                          _showPlayerDetailsDialog(context, user['name']);
                        },
                      ),
                      // ...other icons and actions...
                    ],
                  ),
                ),
              )

                
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

}
