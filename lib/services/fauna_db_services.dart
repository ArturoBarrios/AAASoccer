
import 'package:faunadb_http/faunadb_http.dart';
import 'package:faunadb_http/query.dart';
import 'package:flutter/cupertino.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import '../models/app_model.dart';
import '../graphql/queries/games.dart';

class FaunaDBServices {
  /// Determine the current position of the device.
  ///
  /// When the location services are not enabled or permissions
  /// are denied the `Future` will return an error.
  Future<Map<String, dynamic>> createFaunaClient() async {
    print("createFaunaClient");
    Map<String, dynamic> createFaunaClientResponse = {
      "success": false,
    };

    
    await initHiveForFlutter();
  final HttpLink httpLink = HttpLink(
    'https://neat-sunfish-45.hasura.app/v1/graphql',
  );

  final AuthLink authLink = AuthLink(
    getToken: () async => 'Bearer fnAEwyiZocACT1B4JJ2YkT2yPqdbIBgQz55x7a-0',
  );

    final Link link = authLink.concat(httpLink);
    ValueNotifier<GraphQLClient> client = ValueNotifier(
      GraphQLClient(
        link: link,
        // The default store is the InMemoryStore, which does NOT persist to disk
        cache: GraphQLCache(store: InMemoryStore()),
      ),
    );
    print("graphQL client: ");
    print(client);
    
    createFaunaClientResponse["success"] = true;
    createFaunaClientResponse["message"] = "Fauna Client Created";
    createFaunaClientResponse["client"] = client;
    // createFaunaClientResponse["faunaClient"] = faunaClient;

    return createFaunaClientResponse;
  }

  Future<Map<String, dynamic>> retrieveInitialModels() async {
    print("fauna_db_services.dart: retrieveInitialModels");
    Map<String, dynamic> retrieveInitialModelsResponse = {
      "success": false,
      "message": "Default Error",
      "data": Map<String, dynamic>()
    };

    Map<String, dynamic> getGames = {"success": "false"};//await GameQueries().getGames();
    if(getGames['success']){
      print("retrieved games successfully from fauna db");
      retrieveInitialModelsResponse["success"] = true;
      retrieveInitialModelsResponse["message"] = "Games retrieved";
      retrieveInitialModelsResponse["data"]["games"] = getGames["data"];
    }

    

    return retrieveInitialModelsResponse;
  }
}
