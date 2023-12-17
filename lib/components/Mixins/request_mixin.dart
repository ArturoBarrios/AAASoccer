import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/request/view.dart';

import '../../commands/event_command.dart';
import '../../commands/player_command.dart';
import '../../commands/team_command.dart';
import '../../commands/user_command.dart';
import '../../constants.dart';
import '../../views/game/view.dart';
import '../../views/league/view.dart';
import '../../views/team/view.dart';
import '../../views/tournament/view.dart';
import '../../views/training/view.dart';
import '../../views/tryout/view.dart';
import '../../views/profile/profile.dart';

mixin RequestMixin {
  goToEvent(BuildContext context, dynamic event) {
    print("goToEvent");
    print("event: " + event.toString());
    //what event view should you go to?
    //for training, tryout, league, tournament
    if (event['type'] == Constants.PICKUP) {
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (context) => PickupView(game: event),
      //   ),
      // );
    } else if (event['type'] == Constants.TRYOUT) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TryoutView(event: event),
        ),
      );
    } else if (event['type'] == Constants.TRAINING) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TrainingView(event: event),
        ),
      );
    } else if (event['type'] == Constants.TOURNAMENT) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => TournamentView(tournament: event),
        ),
      );
    } else if (event['type'] == Constants.LEAGUE) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => LeagueView(league: event),
        ),
      );
    }
  }

  goToTeam(BuildContext context, dynamic team) {
    print("goToTeam");
    print("team: " + team.toString());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamView(teamObject: team),
      ),
    );
  }

  goToPlayer(BuildContext context, dynamic user) {
    print("goToPlayer");
    dynamic profileDetails = {
      "user": user,
      "isMine": false,
    };
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Profile(
                user: user
                
              )),
    );
  }
}
