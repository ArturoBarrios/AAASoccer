import 'package:flutter/material.dart';
import 'package:flutter_animated_dialog/flutter_animated_dialog.dart';
import 'package:soccermadeeasy/views/request/view.dart';

import '../../commands/base_command.dart';
import '../../commands/event_command.dart';
import '../../commands/game_command.dart';
import '../../commands/images_command.dart';
import '../../commands/player_command.dart';
import '../../commands/requests_command.dart';
import '../../commands/team_command.dart';
import '../../commands/user_command.dart';
import '../../constants.dart';
import '../../views/chats/create.dart';
import '../Dialogues/animated_dialogu.dart';
import '../card_form_screen.dart';
import '../create_event_payment.dart';
import '../create_event_request.dart';
import '../create_team_payment.dart';
import '../create_team_request.dart';

mixin TeamMixin {
  
Future<dynamic> chooseRolesDialogue(BuildContext context)async{
      dynamic chooseRolesDialogueResp = {};   
      List<dynamic> primaryList = TeamCommand().getTeamUserRoles();
      List<dynamic> secondaryList = [];
      Map<int, dynamic> result = await showDialog(
        context: context,
        builder: (BuildContext context) {          
          return AnimatedDialog(
              details: {"title": "Choose Team Role"},
              items: primaryList,
              singleSelect: false,
              secondaryItems: secondaryList,
              goToFunctions: []);
        },
      );
      if (result.isNotEmpty) {
        print('Selected items: $result');                 
        List<dynamic> rolesArray = [];
        result.forEach((mainIndex, secondaryIndex){
          rolesArray.add(primaryList[mainIndex]);
        });
        chooseRolesDialogueResp['rolesArray'] = rolesArray;
        return chooseRolesDialogueResp;  
      }
      else{
        return null;
      }
    
           
    
  }

}
