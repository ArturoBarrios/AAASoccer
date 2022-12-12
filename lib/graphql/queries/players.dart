class UserQueries {
  String getPlayer(String id)
   {
      String getPlayer = """
        query getPlayer {
          findPlayer(id: $id) {
            data {      
              _id              
              user{
                  _id
                  name        	
                  phone
                  email
                  username
                  birthdate
                  gender
                  location                                    
              } 
            }
          }
        }
      """;

      return getPlayer;
   }

    String getPlayers()
    {
        String getPlayers = """
          query getPlayers {
            allPlayers {
              data {      
                _id              
                user{
                    _id
                    name        
                    age	
                    phone
                    email
                    username
                    birthdate
                    }
                  }
                }
              }
          """;

          return getPlayers;

    }

  
}
