import 'base_command.dart';
import 'refresh_posts_command.dart';


class HomePageCommand extends BaseCommand {

  void cardTapped(){
    print("opencard");
    homePageModel.isDialogueViewOpened = !homePageModel.isDialogueViewOpened ? true : false;
    
  }

  void closeCard(){
    print("closeCard");
    homePageModel.isDialogueViewOpened = false;
  }  
}

