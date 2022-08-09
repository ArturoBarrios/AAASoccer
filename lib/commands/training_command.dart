import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Training.dart';
import 'package:amplify_flutter/amplify_flutter.dart';
import '../commands/event_command.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '../models/app_model.dart';

class TrainingCommand extends BaseCommand {
  Future<Map<String, dynamic>> createTraining(
      Map<String, dynamic> trainingInput,
      Map<String, dynamic> eventInput) async {
    print("createTraining");
    Map<String, dynamic> createTrainingResponse = {
      "success": false,
      "message": "Default Error",
      "data": null
    };
    try {
      Map<String, dynamic> createEventResp =
          await EventCommand().createEvent(eventInput);
      if (createEventResp["success"]) {
        FaunaResponse eventFaunaResult = createEventResp["data"];
        Map<String, dynamic> eventResult = eventFaunaResult.asMap();
        print("event before creating Training: ");
        print(eventResult['resource']['ref']['@ref']['id']);
          final createDocument = Create(
            Collection('Training'),
            Obj({
              'data': {                
                'events': Ref(Collection("Event"),
                    eventResult['resource']['ref']['@ref']['id']),
              }
            }),
          );
          FaunaResponse result = await AppModel().faunaClient.query(createDocument);
          print("response: ");
          print(result.toJson());
          createTrainingResponse["success"] = true;
          createTrainingResponse["message"] = "Training Created";
          createTrainingResponse["data"] = result;

        
      }

      return createTrainingResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createTrainingResponse;
    }
  }
}
