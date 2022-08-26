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
        Documents(Collection('Game')),
        size: 10,
        sources: true,
      );
    
      FaunaResponse result = await AppModel().faunaClient.query(paginateGames);
      print("getGames response: ");
      print(result.asMap());//["resource"]["data"][0]["@ref"]["collection"]["@ref"]["id"].runtimeType);
      getGamesResp["success"] = true;
      getGamesResp["message"] = "Games retrieved";
      getGamesResp["data"] = [{"name": "Game 1"}];
      return getGamesResp;
    } on Exception catch (e) {
      print('getGames Query failed: $e');
      return getGamesResp;

    }

  }

}