import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/app_model.dart';
import 'Loading/loading_screen.dart';

class LeagueTableWidget extends StatefulWidget {
  final Map<String, dynamic> userEventDetails;

  LeagueTableWidget({required this.userEventDetails});

  @override
  _LeagueTableWidgetState createState() => _LeagueTableWidgetState();
}

class _LeagueTableWidgetState extends State<LeagueTableWidget> {
  String selectedYear = '2023';
  final List<String> years = ['2023'];
  bool _isLoading = true;

  dynamic leagueTableData = [];
  // List<dynamic> teamDummyData = List<dynamic>.generate(20, (index) {
  //   return {
  //     "name": "Team${index + 1}",
  //     "points": (index + 1) * 3,
  //     "gamesPlayed": 2,
  //     "goalsFor": 10,
  //     "goalAgainst": 6,
  //     "wins": 2,
  //     "losses": 0,
  //     "draws": 0,
  //   };
  // });

  dynamic getLeagueTableData() {
    print("getLeagueTableData()");
    dynamic leagueTableDataResp = {};
    leagueTableDataResp['data'] = [];
    print("userEventDetails: " + widget.userEventDetails.toString());
    int numberOfTeams = widget.userEventDetails['league']['numberOfTeams'];
    print("numberOfTeams: " + numberOfTeams.toString());
    print("userEventDetails['mainEvent']['teams']: " +
        widget.userEventDetails['mainEvent']['teams'].toString());
    leagueTableDataResp['numberOfTeamsInLeague'] = numberOfTeams;
    for (var i = 0;
        i < widget.userEventDetails['mainEvent']['teams']['data'].length;
        i++) {
      dynamic team = widget.userEventDetails['mainEvent']['teams']['data'][i];
      dynamic teamData = {
        'name': team['name'],
        "points": (i + 1) * 3,
        "gamesPlayed": 2,
        "goalsFor": 10,
        "goalAgainst": 6,
        "wins": 2,
        "losses": 0,
        "draws": 0,
      };
      leagueTableDataResp['data'].add(teamData);
    }
    leagueTableDataResp["columns"] = [
      "name",
      "points",
      "gamesPlayed",
      "goalsFor",
      "goalAgainst",
      "wins",
      "losses",
      "draws"
    ];

    print("leagueTableDataResp: " + leagueTableDataResp.toString());

    return leagueTableDataResp;
  }

  void loadInitialData() {
    print("loadInitialData LeagueTableWidget()");

    setState(() {
      leagueTableData = getLeagueTableData();
      _isLoading = false;
    });
  }

  @override
  initState() {
    super.initState();
    // loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    dynamic userEventDetails = context.watch<AppModel>().userEventDetails;
    loadInitialData();

    return _isLoading
        ? Container(
            height: double.infinity,
            width: double.infinity,
            child: Align(
              alignment: Alignment.center,
              child: LoadingScreen(
                  currentDotColor: Colors.white,
                  defaultDotColor: Colors.black,
                  numDots: 10),
            ),
          )
        : Column(
            children: [              
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Row(
                  children:
                      leagueTableData['columns'].map<Widget>((String column) {
                    return Expanded(
                      child: Text(
                        column,
                        textAlign: TextAlign.center,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                    );
                  }).toList(),
                ),
              ),
              ListView.separated(
                shrinkWrap: true, // this is needed
                physics: NeverScrollableScrollPhysics(), // and this!
                itemCount: leagueTableData['numberOfTeamsInLeague'],
                separatorBuilder: (context, index) => Divider(
                  color: Colors.grey,
                ),
                itemBuilder: (context, index) {
                  dynamic teamData = index < leagueTableData['data'].length
                      ? leagueTableData['data'][index]
                      : {};

                  return Padding(
                    padding: EdgeInsets.all(8.0),
                    child: Row(
                      children: leagueTableData['columns']
                          .map<Widget>((String column) {
                        String data = teamData.containsKey(column)
                            ? teamData[column].toString()
                            : "-";
                        return Expanded(child: Text(data));
                      }).toList(),
                    ),
                  );
                },
              ),
            ],
          );
  }
}
