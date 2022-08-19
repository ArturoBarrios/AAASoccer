import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import '/models/app_model.dart';

class GameQueries {
   Future<Map<String, dynamic>> getGames() async {
    print("getGames");
    Map<String, dynamic> getGamesResp = {
      "success": false,
      "message": "Something went wrong with getting games",
      "data": null,
    };

    try{
      final paginateGames = Paginate(
        Collection('Game'),
        size: 10,
      );
    
      FaunaResponse result = await AppModel().faunaClient.query(paginateGames);
      print("getGames response: ");
      print(result.toJson());
      getGamesResp["success"] = true;
      getGamesResp["message"] = "Games retrieved";
      getGamesResp["data"] = result;
      return getGamesResp;
    } on Exception catch (e) {
      print('getGames Query failed: $e');
      return getGamesResp;

    }

  }

}