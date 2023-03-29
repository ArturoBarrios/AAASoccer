import '../fragments/event_fragments.dart';

class GameQueries {
  String getGames(bool pickup) {
    String getGames = """
        query GetGames {
          allGames(pickup: $pickup) {
            data {      
              _id
              pickup
              event{
                  ${EventFragments().fullEvent()}

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
            ${EventFragments().eventGameFragment()}              
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
