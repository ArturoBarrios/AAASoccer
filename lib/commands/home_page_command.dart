import 'base_command.dart';
import 'refresh_posts_command.dart';
import '../models/home_page_model.dart';
import '../models/event_types_model.dart';
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

  void eventTypeTapped(int key){
    print("eventTypeTapped");
    print(homePageModel.enabledEvents[key]['enabled']);
    homePageModel.toggleEvent(key);
    // homePageModel.enabledEvents[key]['enabled'] = !homePageModel.enabledEvents[key]['enabled'];
    
    print("checkkkkk");
    print(homePageModel.enabledEvents[key]['enabled']);
    
  }
}

