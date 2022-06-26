import 'base_command.dart';
import 'package:amplify_api/amplify_api.dart';
import '../models/Training.dart';
import 'package:amplify_flutter/amplify_flutter.dart';

class TrainingCommand extends BaseCommand {


 Future<Map<String, dynamic>> createTraining(Map<String, dynamic> userInput ) async{
     print("createTraining");
    Map<String, dynamic> createTrainingResponse = {"success": false, "message": "Default Error"};
    try {
      Training training = Training(trainingEventId: userInput['trainingEventId']);
      final request = ModelMutations.create(training);
      print("request");
      final response = await Amplify.API.mutate(request: request).response;
      print("response");

      Training? createdTraining = response.data;
      if (createdTraining != null) {
       createTrainingResponse["success"] = true;
      createTrainingResponse["messasge"] = "Successfully Created Training";
      createTrainingResponse["data"] = createdTraining;

      }
      
      print('Mutation result: ' );
      print(createdTraining);
      return createTrainingResponse;
    } on ApiException catch (e) {
      print('Mutation failed: $e');
      return createTrainingResponse;
    }
  }

  

 

}