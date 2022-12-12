import 'base_command.dart';
import 'refresh_posts_command.dart';
import 'event_command.dart';
import '../models/home_page_model.dart';
import '../models/events_model.dart';
import 'package:flutter/foundation.dart';
import '../constants.dart';


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

  void eventTypeTapped(String key){
    print("eventTypeTapped");
    print(key);
    print(homePageModel.enabledSelections2[key]['enabled']);
    HomePageModel().enabledSelections2.forEach((k, v) => {
      homePageModel.enabledSelections2[k]['enabled'] = false
    });
    homePageModel.enabledSelections2[key]['enabled'] = !homePageModel.enabledSelections2[key]['enabled'];
    homePageModel.selectedKey = key;    
    getSelectedObjects();
    
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
        print(appModel.players);
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
      
      

      
      
      
    }    
  

  
}

