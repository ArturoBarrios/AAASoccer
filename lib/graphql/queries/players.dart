import '../fragments/user_fragments.dart';

class PlayerQueries {
  String getUserPlayer(String id)
   {
      String getUserPlayer = """
        query getUserPlayer {
          findUser(id: $id) {
            data {      
             ${(UserFragments().fullUser())}
            }
          }
        }
      """;

      return getUserPlayer;
   }

    String getUserPlayers()
    {
        String getUserPlayers = """
          query getUserPlayers {
            allUsers {
              data {                               
                  ${(UserFragments().fullUser())}                                                          
                  }
                }
              }
          """;

          return getUserPlayers;

    }

  
}
