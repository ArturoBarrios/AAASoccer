import '../fragments/event_fragments.dart';

class GameQueries {
  String getGames(bool pickup, String eventFragment) {
    String getGames = """
        query GetGames {
          allGames(pickup: $pickup) {
            data {      
              _id
              pickup
              event{
                  ${eventFragment}

              }  

            }
          }
        }
      """;

    return getGames;
  }

  String getEventGame(String id) {
    String getGame = """
        query getEvent {
          findEventByID(id: $id) {                           
            ${EventFragments().fullEvent()}              
          }          
        }
      """;

    return getGame;
  }
    String getGame(String id) {
    String getGame = """
        query getGame {
          findGameByID(id: $id) {
             
              _id
              pickup
              event{
                  ${EventFragments().fullEvent()}
              } 
            }
          
        }
      """;

    return getGame;
  }
}
