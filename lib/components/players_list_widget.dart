import 'package:flutter/material.dart';

import '../commands/base_command.dart';

class PlayerList extends StatefulWidget {
  final dynamic playersDetails;

  PlayerList({required this.playersDetails});

  @override
  _PlayerListState createState() => _PlayerListState();
}

class _PlayerListState extends State<PlayerList> {
  bool _isExpanded = false;
  List<String> _selectedUserTypes = ["PLAYER"]; // Default selection: "PLAYER"
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
    List<String> selectedTypes = _selectedUserTypes.isNotEmpty
        ? _selectedUserTypes
        : _userTypes;

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
            _isExpanded ? 'Showing Selected' : 'Showing All',
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
                        if (!_selectedUserTypes.contains(userType)) {
                          _selectedUserTypes.add(userType);
                        }
                      } else {
                        _selectedUserTypes.remove(userType);
                      }
                    });
                  },
                  selected: _selectedUserTypes.contains(userType),
                );
              }).toList(),
            ),
          ),
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            'Showing ${selectedTypes.toString()}',
            style: TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Flexible(
          child: SingleChildScrollView(
            child: Column(
              children: widget.playersDetails['userParticipants']
                  .where((userParticipant) {
                List<String> userRoles = getUserRoles(userParticipant);
                print("userRoles: " + userRoles.toString());
                bool hasSelectedRoles = selectedTypes.any((type) => userRoles.contains(type));
                print("hasSelectedRoles: " + hasSelectedRoles.toString());
                return hasSelectedRoles;
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
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            // You can call a function here to handle user deletion
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
