// migration.dart


import '../commands/event_command.dart';
import '../commands/subscriptions_command.dart';

void main(List<String> arguments) {
  // Connect to your database
  connectToDatabase();

  

  print('Migrations have been run successfully!');
}

Future<void> connectToDatabase() async{
  await createSubscriptions();  
}


Future<void> createSubscriptions() async{
    print("createSubscriptions()");
    Map<String,dynamic> createSubscriptionsResp = await SubscriptionsCommand().createSubscriptionTypes();
    print("createSubscriptionsResp: $createSubscriptionsResp");
    
  }
  

