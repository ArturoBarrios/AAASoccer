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
              location{
                _id
                latitude
                longitude
              }
              events{
                data{
                  _id
                  archived
                  deleted
                  name
                  isMainEvent
                  type
                  games{
                    data{
                      _id
                      pickup
                    }
                  }

                }                
              }
              stripeCustomers{
                data{
                  _id
                  customerId
                }
              }
              friends{   
                data{
                  _id
                  user{
                    _id
                    name
                    email   
                    OSPID                
                  }                  
                }                  
              }
              teams{
                data{
                  _id
                  name
                }
              } 
              sentMessages{
                data{
                  _id
                }
                
              }      
              chats{
                data{
                  _id
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
              location{
                _id
                latitude
                longitude
              }
              events{
                data{
                  _id
                  archived
                  deleted
                  name
                  isMainEvent
                  type
                }
              }
              friends{   
                data{
                  _id
                  user{
                    _id
                    name
                    email   
                    OSPID                
                  }                  
                }                  
              }
              stripeCustomers{
                data{
                  _id
                  customerId
                }
              }
              teams{
                data{
                  _id
                  name
                }
              }     
              sentMessages{
                data{
                  _id
                }
                
              }      
              chats{
                data{
                  _id
                }
              }    
              sentMessages{
                data{
                  _id
                }
                
              }      
              chats{
                data{
                  _id
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

 String removeEventFromUser(
      Map<String, dynamic> eventInput, Map<String, dynamic> userInput ) {
    String addPlayerToEvent = """      
      mutation {
        updateUser(id: ${userInput['_id']}, data: {          
          events: {
            disconnect: ${eventInput['_id']}
          }
        }) {
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
                data{
                  _id
                  user{
                    _id
                    name
                    email   
                    OSPID                
                  }                  
                }                  
              }
              teams{
                data{
                  _id
                  name
                }
              }      
              sentMessages{
                data{
                  _id
                }
                
              }      
              chats{
                data{
                  _id
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

    return addPlayerToEvent;
  }
  
 

  
}
