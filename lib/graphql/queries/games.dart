class GameQueries {
  String getGames(bool pickup) {
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
                  archived
                  deleted    
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
                          archived
                          deleted                      
                      }                
                  }
              }                         
            }
          }
        }
      """;

    return getGames;
  }

  String getGame(String id) {
    String getGame = """
        query getGame {
          findGameByID(id: $id) {
            data {      
              _id
              pickup
              event{
                  name        	
                  _id  
                  type
                  archived
                  deleted    
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
                          archived
                          deleted                      
                      }                
                  }
              } 
            }
          }
        }
      """;

    return getGame;
  }
}
