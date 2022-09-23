
class GameQueries {
   String getGames(bool pickup)
   {
      String getGames = """
        query GetGames {
          allGames(pickup: $pickup) {
            data {      
              _id
              pickup
              event{
                  name        	
                  _id                  
              } 
            }
          }
        }
      """;

      return getGames;
   }

}