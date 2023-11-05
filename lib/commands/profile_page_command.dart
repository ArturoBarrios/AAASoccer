import 'package:flutter/material.dart';
import 'package:soccermadeeasy/commands/player_command.dart';
import 'package:soccermadeeasy/commands/team_command.dart';
import 'package:soccermadeeasy/commands/tournament_command.dart';
import 'package:soccermadeeasy/commands/user_command.dart';
import 'package:soccermadeeasy/styles/colors.dart';

import '../components/Cards/tsn_player_card.dart';
import '../components/Cards/tsn_team_card.dart';
import '../components/Cards/tsn_tournament_card.dart';
import '../components/Cards/tsn_training_card.dart';
import '../components/Cards/tsn_tryout_card.dart';
import '../models/enums/EventType.dart';
import '../graphql/fragments/event_fragments.dart';
import '../graphql/fragments/team_fragments.dart';
import 'base_command.dart';
import 'league_command.dart';
import 'refresh_posts_command.dart';
import 'event_command.dart';
import '../models/pageModels/home_page_model.dart';
import '../models/events_model.dart';
import 'package:flutter/foundation.dart';
import '../constants.dart';
import '../components/Cards/pickup_card2.dart';
import '../components/Cards/player_card.dart';
import '../components/Cards/training_card.dart';
import '../components/Cards/tryout_card.dart';
import '../components/Cards/tournament_card.dart';
import '../components/Cards/league_card.dart';
import '../components/Cards/team_card.dart';
import '../components/Cards/tsn_pickup_card.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/svg_widgets.dart';

class ProfilePageCommand extends BaseCommand {  


 Svg svgImage = SVGWidgets().getSoccerBallSVGImage();

  void updateUpdatedCards(bool value) {
    print("updateUpdatedCards");
    homePageModel.updatedCards = value;
  }

  Future<void> setTeams() async{
     print("profilePageModel.teamUserParticipants: " +
        profilePageModel.teamUserParticipants.toString());
    if (profilePageModel.teamUserParticipants!.isNotEmpty) {
      profilePageModel.teams = profilePageModel.teamUserParticipants!
          .where((participantMap) => participantMap.containsKey('team'))
          .map((participantMap) => participantMap['team'])
          .toList();
    }
    print("profilePageModel.teams: " + profilePageModel.teams.toString());
  }
  
  Future<void> setEvents() async{
    profilePageModel.events = profilePageModel.eventUserParticipants
          .where((participantMap) =>
              participantMap.containsKey('event') &&
              participantMap['event'] != null
              &&participantMap['event']['isMainEvent'])
          .map((participantMap) => participantMap['event'])
          .toList();
    }



  Future<void> setTeamCards() async {
    print("setTeamCards()");
    
    profilePageModel.teamCards = [];        
    
    for (int i = 0; i < profilePageModel.teamUserParticipants.length; i++) {
      Widget card =
          await BaseCommand().getCard(Constants.TEAM, profilePageModel.teams[i], svgImage);
      profilePageModel.teamCards.add(card);
    }
    profilePageModel.teamCardsLoading = false;    
    print("setTeamCards() done: " + profilePageModel.teamCards.toString());
  }
  
  Future<void> setEventCards() async {
    print("setEventCards()");
    profilePageModel.eventCards = [];        
    
    for (int i = 0; i < profilePageModel.events.length; i++) {
      print("profilePageModel.events[i]['type']: "+ profilePageModel.events[i]['type'].toString());
      print("profilePageModel.events[i]: "+ profilePageModel.events[i].toString());
      dynamic cardType = Constants.PICKUP;
      if(profilePageModel.events[i]['type'] == EventType.TRYOUT){
        cardType = Constants.TRYOUT;
      } else if(profilePageModel.events[i]['type'] == EventType.TRAINING){
        cardType = Constants.TRAINING;
      } else if(profilePageModel.events[i]['type'] == EventType.TOURNAMENT){
        cardType = Constants.TOURNAMENT;
      } else if(profilePageModel.events[i]['type'] == EventType.LEAGUE){
        cardType = Constants.LEAGUE;
      }
      Widget card =
          await BaseCommand().getCard(cardType, profilePageModel.events[i], svgImage);
      profilePageModel.eventCards.add(card);
    }
    profilePageModel.eventCardsLoading = false;
    print("setEventCards() done: " + profilePageModel.eventCards.toString());
  }


}
