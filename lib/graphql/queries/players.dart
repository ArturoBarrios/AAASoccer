class UserQueries {
  String getPlayer(String id)
   {
      String getPlayer = """
        query getPlayer {
          findPlayer(id: $id) {
            data {      
              _id              
              user{
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

  
}
