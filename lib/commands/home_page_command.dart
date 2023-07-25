import 'package:flutter/material.dart';
import 'package:soccermadeeasy/commands/player_command.dart';
import 'package:soccermadeeasy/commands/team_command.dart';
import 'package:soccermadeeasy/commands/tournament_command.dart';


import 'base_command.dart';
import 'league_command.dart';
import 'refresh_posts_command.dart';
import 'event_command.dart';
import '../models/home_page_model.dart';
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
import '../components/Cards/friend_card.dart';
import 'package:flutter_svg_provider/flutter_svg_provider.dart';
import 'package:soccermadeeasy/svg_widgets.dart';


class HomePageCommand extends BaseCommand {

  void testUpdateText() {
    homePageModel.testText = "testingggggg";
  }

  void cardTapped(){
    print("opencard");
    homePageModel.isDialogueViewOpened = !homePageModel.isDialogueViewOpened ? true : false;
    
  }

  void closeCard(){
    print("closeCard");
    homePageModel.isDialogueViewOpened = false;
  }    

  Future<Widget> getCard(
      String selectedKey, dynamic selectedObject, Svg svgImage) async {
    
    
    print("getCard()");
    print("selectedKey: " + selectedKey);
    print("selectedObject: " + selectedObject.toString());

    Widget card = Text(
        "null"); //PickupCard2(gameObject: selectedObject, svgImage: svgImage, isMyEvent: isMyEvent);

    if (selectedKey == Constants.PICKUP) {
      print("selected pickup: " + selectedObject.toString());
      print("before getEventDetails");
      //first approach
      // dynamic game = selectedObject['games']['data'][0];
      // game['event'] = selectedObject;
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
      //process tournament data for card
      // TournamentCommand().currateTournamentData(selectedObject);
      print("else if tournament");
      print("selectedObject: " + selectedObject.toString());
      dynamic getEventDetailsResp =
          await EventCommand().getUserEventDetails([selectedObject]);
      // getEventDetailsResp['groupStage'] = selectedObject['groupStage'];
      
      // getEventDetailsResp['tournamentStage'] = selectedObject['tournamentStage'];
      
      card = TournamentCard(
          tournamentObject: selectedObject,
          svgImage: svgImage,
          userEventDetails: getEventDetailsResp);
    } else if (selectedKey == Constants.LEAGUE) {
      //process league data for card
      // LeagueCommand().currateLeagueData(selectedObject);
      dynamic getEventDetailsResp =
          await EventCommand().getUserEventDetails(selectedObject['events']['data']);
      card = LeagueCard(
          leagueObject: selectedObject,
          svgImage: svgImage,
          userEventDetails: getEventDetailsResp);
    } else if (selectedKey == Constants.PLAYER) {
      dynamic playerDetails = await PlayerCommand().getUserPlayerDetails(selectedObject);
      card = PlayerCard(playerObject: selectedObject, playerDetails: playerDetails, svgImage: svgImage);
    } else if (selectedKey == Constants.TEAM) {            
      dynamic userTeamDetails = await TeamCommand().getUserTeamDetails(selectedObject);
      card = TeamCard(
          teamObject: selectedObject, svgImage: svgImage, userTeamDetails: userTeamDetails);
    } else if (selectedKey == Constants.MYTEAMS){
      print("selectedKey == MYTEAMS");
      print("selectedObject: " + selectedObject.toString());
      dynamic team = selectedObject['team'];
      dynamic userTeamDetails = await TeamCommand().getUserTeamDetails(team);      
      print("teammmmmm: " + team.toString());
      print("userTeamDetails: " + userTeamDetails.toString());
      card = TeamCard(
          teamObject: team, svgImage: svgImage, userTeamDetails: userTeamDetails);
    }
    else if (selectedKey == Constants.FRIEND) {
      card = FriendCard(friendObject: selectedObject, svgImage: svgImage);
    } 
    //My Events
    else if (selectedKey == Constants.MYEVENTS) {
      print("MYEVENTS");
      if (selectedObject['event']['type'].toString() 
        == "GAME") {
        print("TYPE GAME");

        dynamic getEventDetailsResp =
            await EventCommand().getUserEventDetails([selectedObject['event']]);
        print("getEventDetailsResp: " + getEventDetailsResp.toString());
        card = PickupCard2(
            gameObject: selectedObject['event'],
            svgImage: svgImage,
            userEventDetails: getEventDetailsResp);
      } else if (selectedObject['event']['type'].toString() 
        == "TRAINING") {
        print("selectedObject['event']['trainings']: " +
            selectedObject['event']['trainings'].toString());
        dynamic getEventDetailsResp =
            await EventCommand().getUserEventDetails([selectedObject['event']]);
        card = TrainingCard(
            trainingObject: selectedObject['event'],
            svgImage: svgImage,
            userEventDetails: getEventDetailsResp);
      
      } else if (selectedObject['event']['type'].toString() 
        == "TRYOUT") {
        dynamic getEventDetailsResp =
            await EventCommand().getUserEventDetails([selectedObject['event']]);
        card = TryoutCard(
            tryoutObject: selectedObject['event'],
            svgImage: svgImage,
            userEventDetails: getEventDetailsResp);
      }      
      else if (selectedObject['event']['type'].toString() 
      == "TOURNAMENT") {
        String tournamentId = selectedObject['event']['tournaments']['data'][0]['_id'];
        dynamic findTournamentByIdResp =
            await TournamentCommand().findTournamentById(tournamentId);
        if (findTournamentByIdResp['success']) {
          dynamic tournament = findTournamentByIdResp['data'];
          dynamic getEventDetailsResp = await EventCommand()
              .getUserEventDetails(tournament['events']['data']);
          print("tournament['groupStage']: " + tournament['groupStage'].toString());
          getEventDetailsResp['groupStage'] = tournament['groupStage'];
          card = TournamentCard(
              tournamentObject: tournament,
              svgImage: svgImage,
              userEventDetails: getEventDetailsResp);
           
        }
      }
      else if (selectedObject['event']['type'].toString()
       == "LEAGUE") {
        String leagueId = selectedObject['event']['leagues']['data'][0]['_id'];
        dynamic findLeagueByIdResp =
            await LeagueCommand().findLeagueById(leagueId);
        if (findLeagueByIdResp['success']) {
          dynamic league = findLeagueByIdResp['data'];
          dynamic getEventDetailsResp = await EventCommand()
              .getUserEventDetails(league['events']['data']);
          card = LeagueCard(
              leagueObject: league,
              svgImage: svgImage,
              userEventDetails: getEventDetailsResp);
        }       
      }
    }

    return card;
  }

  Future<void> setCards() async{
    print("setCards()");    
    homePageModel.cards = [];
    homePageModel.cardsLoading = true;
    Svg svgImage = SVGWidgets().getSoccerBallSVGImage();
    for(int i = 0;i<homePageModel.selectedObjects.length;i++){
      Widget card = await getCard(homePageModel.selectedKey, homePageModel.selectedObjects[i], svgImage);
      homePageModel.cards.add(card);

    }
    homePageModel.cardsLoading = false;
  }

  Future<void> eventTypeTapped(String key) async{
    print("eventTypeTapped");
    print(key);
    print(homePageModel.enabledSelections2[key]['enabled']);    
    homePageModel.enabledSelections2.forEach((k, v) => {
      homePageModel.enabledSelections2[k]['enabled'] = false
    });
    homePageModel.enabledSelections2[key]['enabled'] = !homePageModel.enabledSelections2[key]['enabled'];
    homePageModel.selectedKey = key;    
    getSelectedObjects();
    
    
  }

  void addPlayerToObjectSelection(dynamic object){
    print("addPlayerToObjectSelection");
    if(!homePageModel.userObjectSelections.contains(object)){
      homePageModel.userObjectSelections.add(object);    
    }
    print("homePageModel.userObjectSelections: "+homePageModel.userObjectSelections.toString());      
  }
  
  void removePlayerToObjectSelection(dynamic object){
    print("removePlayerToObjectSelection");
    print(object);
    if(homePageModel.userObjectSelections.contains(object)){
      homePageModel.userObjectSelections.remove(object);    
    }
    print("homePageModel.userObjectSelections: "+homePageModel.userObjectSelections.toString());
    
  }

  void toggleEvent(int index){
  }

  void getSelectedObjects(){
    print("getSelectedEvents");    
    print(homePageModel.selectedKey);
    // homePageModel.selectedEvents = EventsModel().games;
    // find key from homePageModel.enabledEvents where enabled is true
    
    // HomePageModel.enabledEvents
    // if(Constants.LEAGUE=="kjkj")
      
      if(homePageModel.selectedKey==Constants.PICKUP){
        print("check games: ");
        print(eventsModel.games);
        homePageModel.selectedObjects = eventsModel.games;
      }
      else if(homePageModel.selectedKey==Constants.TEAM){
        print("check teams: ");
        print(appModel.teams);
        homePageModel.selectedObjects = appModel.teams;      
      }
      else if(homePageModel.selectedKey==Constants.PLAYER){
        print("check players: ");
        print("appModel.players.length: "+appModel.players.length.toString());
        homePageModel.selectedObjects = appModel.players;
      }      
      else if(homePageModel.selectedKey==Constants.TRAINING){
        print("check training: ");
        print(eventsModel.trainings);
        homePageModel.selectedObjects = eventsModel.trainings;
      }
      else if(homePageModel.selectedKey==Constants.TRYOUT){
        print("check tryout: ");
        print(eventsModel.tryouts);
        homePageModel.selectedObjects = eventsModel.tryouts;
      }
      else if(homePageModel.selectedKey==Constants.TOURNAMENT){
        print("check tournament: ");
        print(eventsModel.tournaments);
        homePageModel.selectedObjects = eventsModel.tournaments;
      }
      else if(homePageModel.selectedKey==Constants.LEAGUE){
        print("check league: ");
        print(eventsModel.leagues);
        homePageModel.selectedObjects = eventsModel.leagues;
      }
      else if(homePageModel.selectedKey==Constants.FRIEND){
        print("check friend: ");
        print(appModel.friends);
        homePageModel.selectedObjects = appModel.friends;
      }
      else if(homePageModel.selectedKey==Constants.MYEVENTS){
        print("check my events: ");
        print(appModel.myEvents);
        homePageModel.selectedObjects = appModel.myEvents;
      }
      else if(homePageModel.selectedKey==Constants.MYTEAMS){
        print("check my teams: ");
        print(appModel.myTeams);

        homePageModel.selectedObjects = appModel.myTeams;
      }
      
      

      
      
      
    }    
  

  
}

