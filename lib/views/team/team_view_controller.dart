import '../../commands/base_command.dart';
import '../../commands/team_command.dart';
import '../../components/Mixins/event_mixin.dart';

class TeamViewController extends BaseCommand with EventMixin {
  dynamic priceObject;
  dynamic userTeamDetails;
  dynamic playerListWidgetDetails;

  Future<void> loadInitialData(Map<String, dynamic> teamObject) async {
    print("loadInitialData() in TeamView");
    //wait for 3 seconds
    await Future.delayed(const Duration(seconds: 2));
    print("widget.teamObject ${teamObject['events']['data']}");
    dynamic userTeamDetailsResp =
        await TeamCommand().getUserTeamDetails(teamObject);
    setupPlayerList();

    userTeamDetails = userTeamDetailsResp;

    print("userTeamDetails: $userTeamDetails");
    print("userTeamDetails['events']: ${userTeamDetails['events']}");
    print("loadInitialData() finished!");
    print("loadEventPayment() in loadInitialData()");
    loadEventPayment();
    print("loadEventPayment() finished in loadInitialData()");
  }

  void loadEventPayment() {
    priceObject = userTeamDetails['price'];
  }
}
