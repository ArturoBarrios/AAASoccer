import 'package:flutter/material.dart';

import '../commands/base_command.dart';
import '../commands/team_command.dart';

class PlayerList extends StatefulWidget {
  final dynamic playersDetails;

  PlayerList({required this.playersDetails});

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  bool _isExpanded = true;
  String _selectedUserType = "PLAYER"; // Default selection: "PLAYER"
  List<String> _userTypes = ["PLAYER", "ORGANIZER", "COACH", "REFEREE"];

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

  Future<void> removePlayerRole(dynamic user) async{
    print("removePlayerRole");
    if(widget.playersDetails['team'] != null){
      int index = widget.playersDetails['userParticipants'].indexWhere((userParticipant) => userParticipant['user']['_id'] == user['_id']);
      print("indexWhere:" + index.toString());
      if (index != -1) {
        print("in ifff");
        // Replace item at found index
        dynamic userParticipantRemoved = widget.playersDetails['userParticipants'].removeAt(index);
        
        List<String> userRoles = getUserRoles(userParticipantRemoved);
        print("userRoles before remove: " + userRoles.toString());
        userRoles.remove(_selectedUserType);
        print("userRoles after remove: " + userRoles.toString());
        String newRolesString = BaseCommand().stringifyRoles(userRoles);        
        dynamic removeUsersFromTeamResp = await TeamCommand().updateTeamUserParticipant(userParticipantRemoved, newRolesString);      
        print("removeUsersFromTeamResp: " + removeUsersFromTeamResp.toString());
        if(removeUsersFromTeamResp['success']){
          dynamic teamUserParticipant = removeUsersFromTeamResp['data'];
          widget.playersDetails['userParticipants'].add(teamUserParticipant);
        }

      }
    }
  }
  
  Future<void> removePlayer(dynamic user) async{
    //remove player from team
    if(widget.playersDetails['team'] != null){
      dynamic removeUsersFromTeamResp = await TeamCommand().removeUsersFromTeam(widget.playersDetails['team'], [user]);      
      print("removeUsersFromTeamResp: " + removeUsersFromTeamResp.toString());
      if(removeUsersFromTeamResp['success']){
        widget.playersDetails['userParticipants'].removeWhere((userParticipant) => userParticipant['user']['_id'] == user['_id']);
      }
    }    
  }

  @override
  void initState() {
    super.initState();
    print("initState PlayerList Widget ");
    print("playerDetails: " + widget.playersDetails.toString());
  }

  List<String> getUserRoles(dynamic userParticipant) {
    print("getUserRoles(): " + userParticipant.toString());
    List<String> roles = BaseCommand().parseRoles(userParticipant['roles']);
    print("roles: " + roles.toString());
    return roles;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
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
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: widget.playersDetails['userParticipants']
                  .where((userParticipant) {
                List<String> userRoles = getUserRoles(userParticipant);
                return userRoles.contains(_selectedUserType);
              }).map<Widget>((userParticipant) {
                dynamic user = userParticipant['user'];
                return Card(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(user['name']),
                        ),
                        IconButton(
                          icon: Icon(Icons.info),
                          onPressed: () {
                            _showPlayerDetailsDialog(context, user['name']);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.group_remove_sharp),
                          onPressed: () {
                            // You can call a function here to handle user deletion
                            removePlayerRole(user);
                          },
                        ),
                        IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // You can call a function here to handle user deletion
                            removePlayer(user);
                          },
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}
