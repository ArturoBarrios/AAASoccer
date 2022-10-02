import 'base_command.dart';
import 'refresh_posts_command.dart';
import 'event_command.dart';
import '../models/home_page_model.dart';
import '../models/events_model.dart';
import 'package:flutter/foundation.dart';


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
    // homePageModel.toggleEvent(key);   
    // homePageModel.enabledSelections.forEach((element) { 
    //     element['enabled'] = false;
    //     homePageModel.selectedKey = element['key'];
    //     // index +=1;
    // });    
    
    print("checkkkkk");
    print(homePageModel.enabledSelections2);

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
    switch(homePageModel.selectedKey){
      case "0":
        print("check games: ");
        print(eventsModel.games);
        homePageModel.selectedObjects= eventsModel.games;
        break;
      case "6":
      print("niceeeee");
        homePageModel.selectedObjects = eventsModel.trainings;
        break;      
      default:
        // homePageModel.selectedEvents = EventsModel().games;
        break;
    }
    
    
    
    
  }
}

