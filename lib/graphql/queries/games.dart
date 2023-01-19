
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
                  type
                  location{
                    data{
                    _id
                    latitude
                    longitude
                    }
                  }
                  eventUserOrganizers{                    
                      users{
                        data{
                          _id
                          name
                        }
                      }    
                      event{                        
                          _id
                          name                        
                      }                
                  }
              }                         
            }
          }
        }
      """;

      return getGames;
   }

}