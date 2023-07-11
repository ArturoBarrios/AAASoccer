import 'package:soccermadeeasy/graphql/fragments/team_fragments.dart';

import '../fragments/user_fragments.dart';
import '../fragments/event_fragments.dart';
import '../fragments/request_fragments.dart';

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

  String createUserStripeCustomer(
      Map<String, dynamic> userInput, Map<String, dynamic> customerInput) {
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

  String createUserEventPayment(
      dynamic createUserEventPaymentInput
      ) {
    String createUserEventPaymentString = """      
      mutation {
        createPayment(data: {
          amount: "${createUserEventPaymentInput['amount']}",, 
          user: {
            connect: "${createUserEventPaymentInput['user']['_id']}"            
          } 
          event: {
            connect: "${createUserEventPaymentInput['event']['_id']}"            
          }
          paidAt: "${createUserEventPaymentInput['paidAt']}"
          }) {
            _id
            amount
            event{
              _id
              name
            }
            paidAt
            user{
              _id
              name
              username
            }
            
          }   
        }
        """;

    return createUserEventPaymentString;
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
  
  
  String updateUserProfileImage(Map<String, dynamic> userInput) {
    String updateUserString = """      
      mutation {
        updateUser(id: ${userInput['_id']},
  				data: {            
            mainImageKey: "${userInput['mainImageKey']}"                                                                                
          }                      
        ){
          ${UserFragments().fullUser()}                                  			
  }
}
        """;

    return updateUserString;
  }

  String addFriend( 
       Map<String, dynamic> userInput,Map<String, dynamic> friendInput) {
    String addFriendString = """      
      mutation {
       updateUser(id: ${userInput['_id']},
  				data: {   
            friends:{  
              create:
              {
                user:   {              
                  connect: 
                    ${friendInput['_id']}                                                                                                                                                                                              
                }   
              }       
            }        
          }                      
        ){
        _id
    		name      
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

  String addUserToTeam(
      Map<String, dynamic> userInput, Map<String, dynamic> teamInput, role) {
    String addTeamString = """      
      mutation {
        updateTeam(
          id: ${teamInput['_id']},
  				data: {            
             userParticipants:{
              create:
              {
                user: {
                  connect:
                  "${userInput['_id']}"
                }                
                roles: "$role"
              }
          }   
          }                   
        ){
        ${TeamFragments().fullTeam()}                                     			
  }
}
        """;

    return addTeamString;
  }

  String removeFriend(
      Map<String, dynamic> userInput, Map<String, dynamic> friendInput) {
    String addFriendString = """      
      mutation {
        deleteUserLink(id: "${friendInput['_id']}") {
          _id
          
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
        ${UserFragments().fullUser()}        
                                              			
  }
}
        """;

    return removeGameString;
  }

  String removeTeamFromUser(
      Map<String, dynamic> teamInput, Map<String, dynamic> userInput) {
    String addPlayerToEvent = """      
      mutation {
        updateUser(id: ${userInput['_id']}, data: {          
          teams: {
            disconnect: ${teamInput['_id']}
          }
        }) {
          _id
        }
      }
        """;

    return addPlayerToEvent;
  }
  
  String removeEventFromUser(
      Map<String, dynamic> teamInput, Map<String, dynamic> userInput) {
    String addPlayerToEvent = """      
      mutation {
        updateUser(id: ${userInput['_id']}, data: {          
          teams: {
            disconnect: ${teamInput['_id']}
          }
        }) {
          _id
        }
      }
        """;

    return addPlayerToEvent;
  }
}
