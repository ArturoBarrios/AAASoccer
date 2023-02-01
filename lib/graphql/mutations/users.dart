class UserMutations {
  String sendFriendRequest(Map<String, dynamic> sendFriendRequestInput) {
    String sendFriendRequestString = """
      mutation {
        createFriendRequest(data: {    
          requestAttempts: 1, 
          status: PENDING,
          sender: {
            connect: "${sendFriendRequestInput['sender_id']}"
          },  
          receiver: {
            connect: "${sendFriendRequestInput['receiver_id']}"
            
          }                       
          }) {
            _id
            status
            requestAttempts
            sender{
              _id
              email
              name              
            }   
            receiver{              
              _id
              email
              name              
            }            
          }   
        }
        """;

    return sendFriendRequestString;
  }

  String updateUser(Map<String, dynamic> userInput) {
    String updateUserString = """      
      mutation {
        updateUser(id: ${userInput['user_id']},
  				data: {            
            OSPID: "${userInput['OSPID']}"                                                                                
          }                      
        ){
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

    return updateUserString;
  }

  String addFriend(
      Map<String, dynamic> userInput, Map<String, dynamic> friendInput) {
    String addFriendString = """      
      mutation {
        updateUser(id: ${userInput['_id']},
  				data: {            
            friends:              
              ${friendInput['_id']}                                                                                 
          }                      
        ){
        _id
        name
        email
        friends{          
            _id
            name
            email          
        }                                        			
  }
}
        """;

    return addFriendString;
  }

  String addEvent(
      Map<String, dynamic> userInput, Map<String, dynamic> eventInput) {
    String addEventString = """      
      mutation {
        updateUser(id: ${userInput['_id']},
  				data: {            
            events: {
              connect: [
                ${eventInput['_id']}                                                                                 
              ]
            }             
          }                      
        ){
        _id
        name
        email
        events{      
          data{    
            _id
            name   
            isMainEvent    
            eventUserOrganizers{
              users{
                data{
                  _id
                  name
                  email
                }
              }
            }             
          }
        }                                        			
  }
}
        """;

    return addEventString;
  }

  String addTeam(
      Map<String, dynamic> userInput, Map<String, dynamic> teamInput) {
    String addTeamString = """      
      mutation {
        updateUser(id: ${userInput['_id']},
  				data: {            
            teams: {
              connect: [
                ${teamInput['_id']}                                                                                 
              ]
            }             
          }                      
        ){
        _id
        name
        email
        teams{      
          data{    
            _id
            name       
            teamUserOrganizers{
              users{
                data{
                  _id
                  name
                  email
                }
              }
            }             
          }
        }                                        			
  }
}
        """;

    return addTeamString;
  }

  String removeFriend(
      Map<String, dynamic> userInput, Map<String, dynamic> friendInput) {
    String removeGameString = """      
      mutation {
        updateUser(id: ${userInput['_id']},  				         
            friends: {
              disconnect: 
                "${friendInput['_id']}"                                                                                               
            }                                           
        ){
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
        """;

    return removeGameString;
  }

  String removeGame(
      Map<String, dynamic> userInput, Map<String, dynamic> eventInput) {
    String removeGameString = """      
      mutation {
        updateUser(id: ${userInput['_id']},
  				data: {            
            events: {
              disconnect: [
                ${eventInput['_id']}                                                                                 
              ]
            }             
          }                      
        ){
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
        """;

    return removeGameString;
  }

  String removeTeamFromUser(
      Map<String, dynamic> teamInput, Map<String, dynamic> userInput ) {
    String addPlayerToEvent = """      
      mutation {
        updateUser(id: ${userInput['_id']}, data: {          
          teams: {
            disconnect: ${teamInput['_id']}
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

    return addPlayerToEvent;
  }

  String createTo(Map<String, dynamic> userInput) {
    String createTo = """
        mutation {
          createTo(data: {                    
            user: {
              connect: ${userInput['_id']}                                    
            }
            }) {
              _id
              user{
                _id
                name           
              }   
            }
          }
        """;

    return createTo;
  }

  String updateFriendRequest(Map<String, dynamic> friendRequestInput) {
    String updateFriendRequestString = """      
      mutation {
        updateFriendRequest(id: ${friendRequestInput['_id']},
  				data: {            
            status: ACCEPTED,                                                
          }                      
        ){
            _id
            status
            requestAttempts
            sender{              
              _id
              name              
            }   
            receiver{              
              _id
              name              
            }                        
            
    			
  }
}
        """;

    return updateFriendRequestString;
  }
}
