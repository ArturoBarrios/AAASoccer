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
              phone
              email
              username
              birthdate
              gender
              OSPID
              events{
                data{
                  _id
                  name
                  isMainEvent
                  type
                }
              }
              friends{                                
                  _id
                  name
                  email   
                  OSPID             
              }
              teams{
                data{
                  _id
                  name
                }
              }              
              friendRequests{
                data{
                  _id
                  status
                  requestAttempts
                  sender{
                    _id
                    name
                    email
                  }
                  receiver{
                    _id
                    name
                    email
                  }
                }
              }
              eventRequestsToAccept{
                data{
                  _id
                  status
                  requestAttempts
                  event{
                    _id
                    name
                  }
                }
              } 
              teamRequestsToAccept{
                data{
                  _id
                  status
                  requestAttempts
                  team{
                    _id
                    name
                  }
                }
              }         
                   
                    }
                  }
                }
              }
          """;

          return getPlayers;

    }

  
}
