class UserQueries {
  String getUserByEmail(Map<String, dynamic> userInput ){
    String getUser = """
      query getUser {
          getUser(email: "${userInput['email']}") {      
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
  
  String findUserByID(Map<String, dynamic> userInput ){
    String getUser = """
      query getUser {
            findUserByID(id: "${userInput['user_id']}") {      
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
