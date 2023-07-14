import 'package:flutter/material.dart';
import 'dart:math';

class Team {
  final String name;
  final int seed;

  Team(this.name, this.seed);
}

class Match {
  final Team team1;
  final Team team2;
  bool isComplete = false;
  String result = '';

  Match(this.team1, this.team2);
}



class BracketWidget extends StatefulWidget {
  final dynamic bracketDetails;

  const BracketWidget({required this.bracketDetails});

  @override
  _BracketWidgetState createState() => _BracketWidgetState();
}

class _BracketWidgetState extends State<BracketWidget> {
  bool _isLoading = true;  
  List<dynamic> eventOrders = [];

  void simulateMatchResult(Match match, String result) {
    setState(() {
      match.isComplete = true;
      match.result = result;
    });
  }

  void loadInitialData() {
  print("loadInitialData");
  print("widget.bracketDetails: " + widget.bracketDetails.toString());

  eventOrders = widget.bracketDetails['eventOrders']['data'];
  print("eventOrders: " + eventOrders.toString());
  //order eventOrders by eventOrders['order']
  eventOrders.sort((a, b) => a['order'].compareTo(b['order']));

  // Get the initial number of teams
  // int initialTeamCount = widget.bracketDetails['numberOfTeams'];
  // print("initialTeamCount: " + initialTeamCount.toString());

  // int roundsLeft = (initialTeamCount == 2) ? 1 : (initialTeamCount ~/ 2);
  // print("roundsLeft: " + roundsLeft.toString());

  // for (int i = 0; i < roundsLeft; i++) {
  //   // Adjust teamCount calculation to handle the 'Final' case
  //   int teamCount = (i == roundsLeft - 1) ? 2 : pow(2, (roundsLeft - i)).toInt();

  //   // Adjust roundName calculation to handle the 'Final' case
  //   String roundName = (i == roundsLeft - 1) ? 'Final' : 'Round of $teamCount';

  //   List<Match> matches = [];
  //   for (int j = 0; j < teamCount ~/ 2; j++) {
  //     // Create random team names
  //     String team1Name = 'Team ${(i * teamCount) + (j * 2) + 1}';
  //     String team2Name = 'Team ${(i * teamCount) + (j * 2) + 2}';
      
  //     Team team1 = Team(team1Name, (j * 2) + 1);
  //     Team team2 = Team(team2Name, (j * 2) + 2);
  //     matches.add(Match(team1, team2));
  //   }

  //   rounds.add(Round(roundName, matches));
  // }

  setState(() {
    _isLoading = false;
  });
  print("done loading initial data");

}

@override
  void initState() {
    super.initState();
    print("BracketWidget initState");    
    loadInitialData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Bracket'),
      ),
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Container(
              margin: EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: eventOrders.length,
                itemBuilder: (context, eventIndex) {
                  dynamic eventOrder = eventOrders[eventIndex];
                  int round = eventOrder['order'];
                  dynamic game = eventOrder['event']['games']['data'].length>0 ? 
                  eventOrder['event']['games']['data'][0] : null;
                  dynamic team1 = game != null ? 
                    game['hometeam'] : null;
                  dynamic team2 = game != null ? 
                    game['awayteam'] : null;
                  print("event in ListView: " + eventOrder.toString());
                  print("round: " + round.toString());
                  print("game: " + game.toString());
                  print("team1: " + team1.toString());
                  print("team2: " + team2.toString());
                  return Column(
                    children: [
                      Text(
                        round.toString(),
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 16.0),                      
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                            color: false ? Colors.green : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  team1!= null ? team1['name'] : "No Team",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  team2!= null ? team2['name'] : "No Team",
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              if (game != null)
                                Text(
                                  game['homescore'].toString()+ "-"+ 
                                    game['awayscore'].toString() ,
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                              if(game == null)
                              Text("no match played"),
                                // ElevatedButton(
                                //   onPressed: () => simulateMatchResult(match, 'Result'),
                                //   child: Text('Simulate Result'),
                                // ),
                            ],
                          ),
                        ),
                      
                      SizedBox(height: 24.0),
                    ],
                  );
                },
              ),
            ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: BracketWidget(bracketDetails: 'Sample Bracket'),
  ));
}
