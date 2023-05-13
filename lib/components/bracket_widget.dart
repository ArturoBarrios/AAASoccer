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

class Round {
  final String roundName;
  final List<Match> matches;

  Round(this.roundName, this.matches);
}

class BracketWidget extends StatefulWidget {
  final dynamic bracketDetails;

  const BracketWidget({required this.bracketDetails});

  @override
  _BracketWidgetState createState() => _BracketWidgetState();
}

class _BracketWidgetState extends State<BracketWidget> {
  bool _isLoading = true;
  List<Round> rounds = [];

  @override
  void initState() {
    super.initState();
    print("BracketWidget initState");
    loadInitialData();
  }

void loadInitialData() {
  print("loadInitialData");
  // Predefined list of team counts
  List<int> roundCounts = [32, 16, 8, 4, 2];
  Random random = Random();
  int initialTeamCount = roundCounts[random.nextInt(roundCounts.length)];
  print("initialTeamCount: $initialTeamCount");

  List<Team> teams = List.generate(initialTeamCount, (index) => Team('Team ${index + 1}', index + 1));
  teams.sort((a, b) => a.seed.compareTo(b.seed));

  int roundsLeft = (log(initialTeamCount) / log(2)).ceil();

  if (roundsLeft <= 1) {
    rounds.add(Round('Final', [Match(teams.first, teams.last)]));
  } else {
    for (int i = 0; i < roundsLeft; i++) {
      int teamCount = pow(2, roundsLeft - i).toInt();
      String roundName = (i == roundsLeft - 1) ? 'Final' : 'Round of $teamCount';

      List<Match> matches = [];
      for (int j = 0; j < teamCount ~/ 2; j++) {
        Team team1 = teams[j];
        Team team2 = teams[teamCount - j - 1];
        matches.add(Match(team1, team2));
      }

      rounds.add(Round(roundName, matches));
    }
  }

  setState(() {
    _isLoading = false;
  });
  print("done loading initial data");
}




  void simulateMatchResult(Match match, String result) {
    setState(() {
      match.isComplete = true;
      match.result = result;
    });
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
                itemCount: rounds.length,
                itemBuilder: (context, roundIndex) {
                  return Column(
                    children: [
                      Text(
                        rounds[roundIndex].roundName,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0,
                        ),
                      ),
                      SizedBox(height: 16.0),
                      ...rounds[roundIndex].matches.map(
                        (match) => Container(
                          padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(8.0),
                            color: match.isComplete ? Colors.green : null,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  match.team1.name,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              Expanded(
                                child: Text(
                                  match.team2.name,
                                  style: TextStyle(fontSize: 16.0),
                                ),
                              ),
                              SizedBox(width: 8.0),
                              if (match.isComplete)
                                Text(
                                  match.result,
                                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                                ),
                              if (!match.isComplete)
                                ElevatedButton(
                                  onPressed: () => simulateMatchResult(match, 'Result'),
                                  child: Text('Simulate Result'),
                                ),
                            ],
                          ),
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
