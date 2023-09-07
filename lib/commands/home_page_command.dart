import 'package:flutter/material.dart';
import 'package:soccermadeeasy/commands/player_command.dart';
import 'package:soccermadeeasy/commands/team_command.dart';
import 'package:soccermadeeasy/commands/tournament_command.dart';
import 'package:soccermadeeasy/commands/user_command.dart';

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
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/svg_widgets.dart';

class HomePageCommand extends BaseCommand {
  void testUpdateText() {
    homePageModel.testText = "testingggggg";
  }

  void cardTapped() {
    print("opencard");
    homePageModel.isDialogueViewOpened =
        !homePageModel.isDialogueViewOpened ? true : false;
  }

  void closeCard() {
    print("closeCard");
    homePageModel.isDialogueViewOpened = false;
  }

  Future<Widget> getCard(
      dynamic selectedKey, dynamic selectedObject, Svg svgImage) async {
    print("getCard()");
    print("selectedKey: " + selectedKey.toString());
    print("selectedObject: " + selectedObject.toString());

    Widget card = Text(
        "null"); //PickupCard2(gameObject: selectedObject, svgImage: svgImage, isMyEvent: isMyEvent);

    if (selectedKey == Constants.PICKUP) {
      print("selected pickup: " + selectedObject.toString());
      print("before getEventDetails");
      //first approach
      dynamic getEventDetailsResp =
          await EventCommand().getUserEventDetails([selectedObject]);
      print("after getEventDetails");
      card = PickupCard2(
          gameObject: selectedObject,
          svgImage: svgImage,
          userEventDetails: getEventDetailsResp);
    } else if (selectedKey == Constants.TRAINING) {
      dynamic getEventDetailsResp =
          await EventCommand().getUserEventDetails([selectedObject]);
      card = TrainingCard(
          trainingObject: selectedObject,
          svgImage: svgImage,
          userEventDetails: getEventDetailsResp);
    } else if (selectedKey == Constants.TRYOUT) {
      print("selected tryout");
      dynamic getEventDetailsResp =
          await EventCommand().getUserEventDetails([selectedObject]);
      card = TryoutCard(
          tryoutObject: selectedObject,
          svgImage: svgImage,
          userEventDetails: getEventDetailsResp);
    } else if (selectedKey == Constants.TOURNAMENT) {
      print("selectedObject: " + selectedObject.toString());
      dynamic getEventDetailsResp =
          await EventCommand().getUserEventDetails([selectedObject]);

      card = TournamentCard(
          tournamentObject: selectedObject,
          svgImage: svgImage,
          userEventDetails: getEventDetailsResp);
    } else if (selectedKey == Constants.LEAGUE) {
      dynamic getEventDetailsResp =
          await EventCommand().getUserEventDetails([selectedObject]);
      card = LeagueCard(
          leagueObject: selectedObject,
          svgImage: svgImage,
          userEventDetails: getEventDetailsResp);
    } else if (selectedKey == Constants.PLAYER) {
      dynamic playerDetails =
          await UserCommand().getUserDetails(selectedObject);
      card = PlayerCard(
          playerObject: selectedObject,
          playerDetails: playerDetails,
          svgImage: svgImage);
    } else if (selectedKey == Constants.TEAM) {
      dynamic userTeamDetails =
          await TeamCommand().getUserTeamDetails(selectedObject);
      card = TeamCard(
          teamObject: selectedObject,
          svgImage: svgImage,
          userTeamDetails: userTeamDetails);
    } else if (selectedKey == Constants.MYTEAMS) {
      print("selectedKey == MYTEAMS");
      print("selectedObject: " + selectedObject.toString());
      dynamic team = selectedObject['team'];
      dynamic userTeamDetails = await TeamCommand().getUserTeamDetails(team);
      print("teammmmmm: " + team.toString());
      print("userTeamDetails: " + userTeamDetails.toString());
      card = TeamCard(
          teamObject: team,
          svgImage: svgImage,
          userTeamDetails: userTeamDetails);
    }
    //My Events
    else if (selectedKey == Constants.MYEVENTS) {
      dynamic event = null;

      print("MYEVENTS");
      print(selectedObject['event']);
      if (selectedObject['event'] == null) {
      } else if (selectedObject['event']['type'].toString() == "GAME") {
        print("TYPE GAME");

        dynamic getEventDetailsResp =
            await EventCommand().getUserEventDetails([selectedObject['event']]);
        print("getEventDetailsResp: " + getEventDetailsResp.toString());
        card = PickupCard2(
            gameObject: selectedObject['event'],
            svgImage: svgImage,
            userEventDetails: getEventDetailsResp);
      } else if (selectedObject['event']['type'].toString() == "TRAINING") {
        print("selectedObject['event']['trainings']: " +
            selectedObject['event']['trainings'].toString());
        dynamic getEventDetailsResp =
            await EventCommand().getUserEventDetails([selectedObject['event']]);
        card = TrainingCard(
            trainingObject: selectedObject['event'],
            svgImage: svgImage,
            userEventDetails: getEventDetailsResp);
      } else if (selectedObject['event']['type'].toString() == "TRYOUT") {
        dynamic getEventDetailsResp =
            await EventCommand().getUserEventDetails([selectedObject['event']]);
        card = TryoutCard(
            tryoutObject: selectedObject['event'],
            svgImage: svgImage,
            userEventDetails: getEventDetailsResp);
      } else if (selectedObject['event']['type'].toString() == "TOURNAMENT") {
        dynamic getEventDetailsResp =
            await EventCommand().getUserEventDetails([selectedObject['event']]);
        card = TournamentCard(
            tournamentObject: selectedObject['event'],
            svgImage: svgImage,
            userEventDetails: getEventDetailsResp);
      } else if (selectedObject['event']['type'].toString() == "LEAGUE") {
        dynamic getEventDetailsResp =
            await EventCommand().getUserEventDetails([selectedObject['event']]);
        card = LeagueCard(
            leagueObject: selectedObject['event'],
            svgImage: svgImage,
            userEventDetails: getEventDetailsResp);
      }
    }

    return card;
  }

  void updateUpdatedCards(bool value) {
    print("updateUpdatedCards");
    homePageModel.updatedCards = value;
  }

  Future<void> setCards() async {
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
          await getCard(homePageModel.selectedKey, objectList[i], svgImage);
      homePageModel.cards.add(card);
    }
    homePageModel.cardsLoading = false;
  }

  void filterObjects(List dynamic) {
    homePageModel.filteredObjects = dynamic;
  }

  void changeFilteringStatus(bool value) {
    homePageModel.isFilteringEnabled = value;
  }

  Future<void> eventTypeTapped(dynamic key) async {
    print("eventTypeTapped");
    print(key);
    print(homePageModel.enabledSelections2[key]['enabled']);
    homePageModel.enabledSelections2.forEach(
        (k, v) => {homePageModel.enabledSelections2[k]['enabled'] = false});
    homePageModel.enabledSelections2[key]['enabled'] =
        !homePageModel.enabledSelections2[key]['enabled'];
    homePageModel.selectedKey = key;
    await getSelectedObjects(key);
  }

  void addPlayerToObjectSelection(dynamic object) {
    print("addPlayerToObjectSelection");
    if (!homePageModel.userObjectSelections.contains(object)) {
      homePageModel.userObjectSelections.add(object);
    }
    print("homePageModel.userObjectSelections: " +
        homePageModel.userObjectSelections.toString());
  }

  void removePlayerToObjectSelection(dynamic object) {
    print("removePlayerToObjectSelection");
    print(object);
    if (homePageModel.userObjectSelections.contains(object)) {
      homePageModel.userObjectSelections.remove(object);
    }
    print("homePageModel.userObjectSelections: " +
        homePageModel.userObjectSelections.toString());
  }

  Future<void> getSelectedObjects(dynamic newSelectedKey) async {
    print("getSelectedEvents");
    print(newSelectedKey);
    List<dynamic> newSelectedObjects = [];
    //get events
    if (BaseCommand().isEventType(newSelectedKey)) {
      String xHoursAgoTimestamp = BaseCommand().xHoursAgoString(
          1); //homePageModel.enabledSelections2[newSelectedKey]['currentTimestamp'];
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
          8760); //homePageModel.enabledSelections2[newSelectedKey]['currentTimestamp'];
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
