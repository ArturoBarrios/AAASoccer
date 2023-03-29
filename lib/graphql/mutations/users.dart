import '../fragments/user_fragments.dart';
import '../fragments/event_fragments.dart';

class UserMutations {
  String partialUserUpdate(Map<String, dynamic> userInput) {
    String updateUserString = """
      mutation {
        partialUpdateUser(id: ${userInput['user']['_id']}, 
        data:{
         ${userInput['user']['dataToUpdate']}
        })
        {
          ${UserFragments().fullUser()}
        }  
      }
    """;

    return updateUserString;
  }

  String sendFriendRequest(Map<String, dynamic> sendFriendRequestInput) {
    String sendFriendRequestString = """
      mutation {
        createFriendRequest(data: {    
          requestAttempts: 1, 
          status: PENDING,
          requestType: FRIENDREQUEST,
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
              phone           
            }   
            receiver{              
              _id
              email
              name 
              phone             
            }            
          }   
        }
        """;

    return sendFriendRequestString;
  }




 
  String createUserStripeCustomer(Map<String, dynamic> userInput, Map<String, dynamic> customerInput) {
    String updateUserString = """      
      mutation {
        createStripeCustomer(data: {
          customerId: "${customerInput['customerId']}", 
          user: {
            connect: "${userInput['_id']}"            
          } 
          }) {
            _id
            customerId
    				user{
              _id
              name
              email
            }
            
          }   
        }
        """;

    return updateUserString;
  }


  String updateUser(Map<String, dynamic> userInput) {
    String updateUserString = """      
      mutation {
        updateUser(id: ${userInput['_id']},
  				data: {            
            OSPID: "${userInput['OSPID']}"                                                                                
          }                      
        ){
          ${UserFragments().fullUser()}                                  			
  }
}
        """;

    return updateUserString;
  }

  
  String addFriend(
      Map<String, dynamic> userInput, Map<String, dynamic> friendInput) {
    String addFriendString = """      
      mutation {
       createUserLink(
  				data: {            
            user:   {              
              connect: 
                 ${userInput['_id']}                                                                                                                                                                                              
            }           
          }                      
        ){
        _id
    		user{
          _id
          name
          email
          OSPID
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
           ${EventFragments().fullEvent()}
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

  // String removeFriend(
  //     Map<String, dynamic> userInput, Map<String, dynamic> friendInput) {
  //   String removeGameString = """      
  //     mutation {
  //       deleteUserLink(id: "${friendInput['user']['_id']}",         
          
          
  //         ) {
  //            _id
             

            
  //         }   
  //       }
  //       """;

  //   return removeGameString;
  // }

   String removeFriend(
      Map<String, dynamic> userInput, Map<String, dynamic> friendInput) {
    String addFriendString = """      
      mutation {
        deleteUser(id: "${friendInput['user']['_id']}") {
          _id
          name
          email
          OSPID
        }
      }
        """;

    return addFriendString;
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
