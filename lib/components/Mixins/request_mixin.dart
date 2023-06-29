import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/request/view.dart';

import '../../commands/event_command.dart';
import '../../commands/player_command.dart';
import '../../commands/team_command.dart';
import '../../commands/user_command.dart';
import '../../constants.dart';
import '../../views/game/view.dart';
import '../../views/team/view.dart';
import '../profile.dart';

mixin RequestMixin {

  goToGame(BuildContext context, dynamic event){
    print("goToGame");        
    dynamic eventToNavigateTo = event;
    //what event view should you go to? 
    //for training, tryout, league, tournament
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PickupView(game: event),
      ),
    );
  

  }
  goToTeam(BuildContext context, dynamic team){      
    print("goToTeam");
    print("team: " + team.toString());
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => TeamView(teamObject: team),
      ),
    );
  
  }

  goToPlayer(BuildContext context, dynamic user){
    print("goToPlayer");
    dynamic profileDetails = {
      "user": user,
      "isMine": false,
    };
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => Profile(
                profileDetails: profileDetails,
              )),
    );
  }

  
}
