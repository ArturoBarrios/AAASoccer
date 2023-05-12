import 'package:flutter/material.dart';
import 'dart:math';

class Team {
  final String name;

  Team(this.name);
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
  // Predefined list of team counts
  List<int> teamCounts = [32, 16, 8, 4, 2];

  List<Team> teams = List.generate(teamCounts.first, (index) => Team('Team ${index + 1}'));

  for (int i = 0; i < teamCounts.length; i++) {
    String roundName;
    if (i == teamCounts.length - 1) {
      roundName = 'Finals';
    } else {
      roundName = 'Round of ${teamCounts[i]}';
    }

    rounds.add(Round(roundName, generateMatches(teams)));

    teams = getWinners(rounds.last);
  }

  setState(() {
    _isLoading = false;
  });
}




  List<Match> generateMatches(List<Team> teams) {
    List<Match> matches = [];
    for (int i = 0; i < teams.length; i += 2) {
      matches.add(Match(teams[i], teams[i + 1]));
    }
    return matches;
  }

  List<Team> getWinners(Round round) {
    List<Team> winners = [];
    for (var match in round.matches) {
      winners.add(Team('Winner of ${match.team1.name} vs ${match.team2.name}'));
    }
    return winners;
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
                            color: match.isComplete ? Colors.green : null),
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
                            
