class UserQueries {
  String getUser(String email){
    String getUser = """
      query getUser {
          getUser(email: "${email}") {      
              _id      
              name        	
              phone
              email
              username
              birthdate
              gender
              events{
                data{
                  _id
                  name
                  isMainEvent
                }
              }
              friends{                
                  _id
                  name
                  email                
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
    """;
  
    return getUser;
  }
 

  
}
