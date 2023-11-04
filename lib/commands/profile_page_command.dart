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


 

  void updateUpdatedCards(bool value) {
    print("updateUpdatedCards");
    homePageModel.updatedCards = value;
  }

  Future<void> setTeamCards() async {
    print("setCards()");
    print("set cards for selectedObject: " +
        homePageModel.selectedObjects.toString());
    profilePageModel.teamCards = [];        
    
    for (int i = 0; i < objectList.length; i++) {
      Widget card =
          await BaseCommand().getCard(homePageModel.selectedKey, objectList[i], svgImage);
      homePageModel.cards.add(card);
    }
    homePageModel.cardsLoading = false;
  }
  
  Future<void> setEventCards() async {
    print("setCards()");
    print("set cards for selectedObject: " +
        homePageModel.selectedObjects.toString());
    homePageModel.cards = [];
    homePageModel.cardsLoading = true;
    Svg svgImage = SVGWidgets().getSoccerBallSVGImage();
    final objectList = homePageModel.filteredObjects.isEmpty &&
            !homePageModel.isFilteringEnabled
        ? homePageModel.selectedObjects
        : homePageModel.filteredObjects;
    for (int i = 0; i < objectList.length; i++) {
      Widget card =
          await BaseCommand().getCard(homePageModel.selectedKey, objectList[i], svgImage);
      homePageModel.cards.add(card);
    }
    homePageModel.cardsLoading = false;
  }

 

  

  Future<void> getSelectedObjects(dynamic newSelectedKey) async {
    print("getSelectedEvents");
    print(newSelectedKey);
    List<dynamic> newSelectedObjects = [];
    //get events
    if (BaseCommand().isEventType(newSelectedKey)) {
      String xHoursAgoTimestamp = BaseCommand().xHoursAgoString(
          1); 
      Map<String, dynamic> getEventsOfAllTypesNearLocationResp =
          await EventCommand().getEventsOfTypeNearLocation(
              newSelectedKey, EventFragments().fullEvent(), xHoursAgoTimestamp);
      print("getEventsOfAllTypesNearLocationResp: " +
          getEventsOfAllTypesNearLocationResp.toString());
      if (getEventsOfAllTypesNearLocationResp['success']) {
        newSelectedObjects = getEventsOfAllTypesNearLocationResp['data'];
        homePageModel.selectedObjects = newSelectedObjects;
      }
    }

    if (newSelectedKey == Constants.PICKUP) {
      print("check games: ");
      print(eventsModel.games);
      if (eventsModel.games.isEmpty) {
        eventsModel.games = newSelectedObjects;
      }
    } else if (newSelectedKey == Constants.TEAM) {
      String oneYearAgoTimestamp = BaseCommand().xHoursAgoString(
          8760); 
      print("oneYearAgoTimestamppppp: " + oneYearAgoTimestamp);
      Map<String, dynamic> getAllTeamsResp = await TeamCommand()
          .getAllTeams(oneYearAgoTimestamp, TeamFragments().fullTeam());
      print("getAllTeamsRespppp: " + getAllTeamsResp.toString());
      if (getAllTeamsResp['success']) {
        newSelectedObjects = getAllTeamsResp['data'];
        homePageModel.selectedObjects = newSelectedObjects;
        appModel.teams = newSelectedObjects;
      }
    } else if (newSelectedKey == Constants.PLAYER) {
      print("check players: ");
      Map<String, dynamic> getPlayersNearLocationResp =
          await PlayerCommand().getPlayersNearLocation();
      print("getPlayersNearLocationResp: " +
          getPlayersNearLocationResp.toString());
      if (getPlayersNearLocationResp['success']) {
        List<dynamic> players = getPlayersNearLocationResp['data'];
        print("playerssss length: ");
        print(players.length);
        //remove the current user from the list
        players.removeWhere(
            (element) => element['_id'] == appModel.currentUser['_id']);
        appModel.players = players;
        appModel.playersNearMe = players;
        print("appModel.players.length: " + appModel.players.length.toString());
      }
      homePageModel.selectedObjects = appModel.players;
    } else if (newSelectedKey == Constants.TRAINING) {
      print("check training: ");
      print(eventsModel.trainings);
      if (eventsModel.trainings.length == 0) {
        eventsModel.trainings = newSelectedObjects;
      }
    } else if (newSelectedKey == Constants.TRYOUT) {
      print("check tryout: ");
      print(eventsModel.tryouts);
      if (eventsModel.tryouts.length == 0) {
        eventsModel.tryouts = newSelectedObjects;
      }
      homePageModel.selectedObjects = eventsModel.tryouts;
    } else if (newSelectedKey == Constants.TOURNAMENT) {
      print("check tournament: ");
      print(eventsModel.tournaments);
      if (eventsModel.tournaments.length == 0) {
        eventsModel.tournaments = newSelectedObjects;
      }
      homePageModel.selectedObjects = eventsModel.tournaments;
    } else if (newSelectedKey == Constants.LEAGUE) {
      print("check league: ");
      print(eventsModel.leagues);
      if (eventsModel.leagues.length == 0) {
        eventsModel.leagues = newSelectedObjects;
      }
      homePageModel.selectedObjects = eventsModel.leagues;
    } else if (newSelectedKey == Constants.FRIEND) {
      print("check friend: ");
      print(appModel.friends);
      homePageModel.selectedObjects = appModel.friends;
    } else if (newSelectedKey == Constants.MYEVENTS) {
      print("check my events: ");
      print("appModel.currentUser: " + appModel.currentUser.toString());
      String xHoursAgoTimestamp = BaseCommand().xHoursAgoString(1);
      dynamic allUserEventParticipantsInput = {
        "userId": appModel.currentUser['_id'],
        "startTime": xHoursAgoTimestamp,
        "eventFragment": EventFragments().userEventParticipants()
      };
      Map<String, dynamic> getAllUserEventParticipantsResp =
          await EventCommand()
              .getAllUserEventParticipants(allUserEventParticipantsInput);
      print("getAllUserEventParticipantsResp: " +
          getAllUserEventParticipantsResp.toString());
      if (getAllUserEventParticipantsResp['success']) {
        newSelectedObjects = getAllUserEventParticipantsResp['data'];
        homePageModel.selectedObjects = newSelectedObjects;
        appModel.myEvents = newSelectedObjects;
      }
    } else if (newSelectedKey == Constants.MYTEAMS) {
      print("check my teams: ");
      print(appModel.myTeams);
      Map<String, dynamic> getAllTeamUserParticipantsResp = await TeamCommand()
          .getAllTeamUserParticipants(
              appModel.currentUser['_id'], TeamFragments().fullTeam());
      print("getAllTeamUserParticipantsResp: " +
          getAllTeamUserParticipantsResp.toString());
      if (getAllTeamUserParticipantsResp['success']) {
        newSelectedObjects = getAllTeamUserParticipantsResp['data'];
        homePageModel.selectedObjects = newSelectedObjects;
        appModel.myTeams = newSelectedObjects;
      }
    }
  }
}
