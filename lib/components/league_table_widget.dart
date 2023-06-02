import 'package:flutter/material.dart';

class LeagueTableWidget extends StatefulWidget {
  final dynamic leagueData;

  LeagueTableWidget({required this.leagueData});

  @override
  _LeagueTableWidgetState createState() => _LeagueTableWidgetState();
}

class _LeagueTableWidgetState extends State<LeagueTableWidget> {
  String selectedYear = '2023';
  final List<String> years = ['2023'];

  List<dynamic> teamDummyData = List<dynamic>.generate(20, (index) {
    return {
      "name": "Team${index + 1}",
      "points": (index + 1) * 3,
      "gamesPlayed": 2,
      "goalsFor": 10,
      "goalAgainst": 6,
      "wins": 2,
      "losses": 0,
      "draws": 0,
    };
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        DropdownButton<String>(
          value: selectedYear,
          items: years.map((String value) {
            return DropdownMenuItem<String>(
              value: value,
              child: Text(value),
            );
          }).toList(),
          onChanged: (String? newValue) {
            setState(() {
              selectedYear = newValue!;
            });
          },
        ),
        ListView.separated(
          shrinkWrap: true, // this is needed
          physics: NeverScrollableScrollPhysics(), // and this!
          itemCount: teamDummyData.length,
          separatorBuilder: (context, index) => Divider(
            color: Colors.grey,
          ),
          itemBuilder: (context, index) {
            var teamData = teamDummyData[index];
            return Padding(
              padding: EdgeInsets.all(8.0),
              child: Row(
                children: [
                  Expanded(child: Text('${index + 1}. ${teamData['name']}')),
                  Expanded(child: Text('${teamData['wins']}')),
                  Expanded(child: Text('${teamData['draws']}')),
                  Expanded(child: Text('${teamData['losses']}')),
                  Expanded(child: Text('${teamData['goalsFor']}')),
                  Expanded(child: Text('${teamData['goalAgainst']}')),
                  Expanded(
                    child: Text('${teamData['goalsFor'] - teamData['goalAgainst']}'),
                  ),
                  Expanded(child: Text('${teamData['points']}')),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
