import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Event.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class EventCommand extends BaseCommand {

  

 Future<Map<String, dynamic>> createEvent(Map<String, dynamic> userInput ) async{
     print("createEvent");
    Map<String, dynamic> createEventResponse = {"success": false, "message": "Default Error"};
    try {
      Event event = Event(name: userInput['name'], price: userInput['price'], location: userInput['location'], images: userInput['images'], type: userInput['type']);
      final request = ModelMutations.create(event);
      print("request");
      final response = await Amplify.API.mutate(request: request).response;
      print("response");

      Event? createdEvent = response.data;
      if (createdEvent != null) {
      createEventResponse["success"] = true;
      createEventResponse["messasge"] = "Successfully Created Event";
      createEventResponse["data"] = createdEvent;
      }
      

      print('Mutation result: ' );
      print(createdEvent);
      return createEventResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createEventResponse;
    }
  }

  

 

}