import 'package:flutter/material.dart';

class TeamsListWidget extends StatelessWidget {
  final Map<String, dynamic> teamsDetails;

  TeamsListWidget({required this.teamsDetails});

  @override
  Widget build(BuildContext context) {
    List<dynamic> teams = teamsDetails['teams'] ?? [];

    return ListView.builder(
      itemCount: teams.length,
      itemBuilder: (context, index) {
        String teamName = teams[index]['name'] ?? '';

        return ListTile(
          title: Text(teamName),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.edit),
                onPressed: () {
                  // TODO: Add your button action here.
                },
              ),
              IconButton(
                icon: Icon(Icons.delete),
                onPressed: () {
                  // TODO: Add your button action here.
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
