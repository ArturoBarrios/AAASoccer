import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Event.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';

class EventCommand extends BaseCommand {

  

 Future<Map<String, dynamic>> createEvent(Map<String, dynamic> eventInput ) async{
     print("createEvent");
    Map<String, dynamic> createEventResponse = {"success": false, "message": "Default Error", "data": null};
    try {
      final createDocument = Create(
        Collection('Event'),
        Obj({
          'data': {
            'name': eventInput['name'],
                      
            }
        }),
      );

      FaunaResponse result = await AppModel().faunaClient.query(createDocument);
      print("result: ");
      print(result.toJson());
     
      createEventResponse["success"] = true;
      createEventResponse["message"] = "Event Created";
      createEventResponse["data"] = result;

      return createEventResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createEventResponse;
    }
  }

  

 

}