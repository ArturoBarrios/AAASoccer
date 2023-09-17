import 'package:soccermadeeasy/graphql/fragments/team_fragments.dart';

import '../fragments/user_fragments.dart';
import '../fragments/event_fragments.dart';

class UserMutations {
  String partialUserUpdate(Map<String, dynamic> userInput) {
    String updateUserString = """
      mutation {
        partialUpdateUser(
          id: ${userInput['user']['_id']}, 
          data: ${userInput['user']['dataToUpdate']}
        )
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

  String createUserEventPayment(dynamic createUserEventPaymentInput) {
    String paymentType = createUserEventPaymentInput['paymentType'] == 'player'
        ? """
          event: {
            connect: "${createUserEventPaymentInput['eventId']}"            
          }
          isPlayerPayment: true
          isTeamPayment: false
        """
        : """
          team: {
            connect: "${createUserEventPaymentInput['teamId']}"            
          }
          isPlayerPayment: false
          isTeamPayment: true
        """;

    String createUserEventPaymentString = """      
      mutation {
        createPayment(data: {
          amount: "${createUserEventPaymentInput['amount']}",
          user: {
            connect: "${createUserEventPaymentInput['userId']}"            
          } 
          paidAt: "${createUserEventPaymentInput['paidAt']}"
          $paymentType
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

  String updateUserPrivateStatus(Map<String, dynamic> userInput) {
    String updateUserString = """      
      mutation {
        updateUser(id: ${userInput['userId']},
  				data: {            
            isProfilePrivate: ${userInput['isProfilePrivate']}                                                                                
          }                      
        ){
          ${UserFragments().fullUser()}                                  			
  }
}
        """;

    return updateUserString;
  }

  String followUser(dynamic followUserInput) {
    String addFriendString = """      
      mutation {
        createFollowRelation(data: {
          follower: {
            connect: "${followUserInput['followerId']}"            
          }
          following: {
            connect: "${followUserInput['followingId']}"            
          }          
          }) {
           _id
           follower{
            _id
            name
            email
           }
            following{
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

  removeTeamFromUser(userInput, team) {}
}
