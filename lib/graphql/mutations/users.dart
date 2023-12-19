import 'package:soccermadeeasy/graphql/fragments/team_fragments.dart';

import '../fragments/user_fragments.dart';
import '../fragments/event_fragments.dart';

class UserMutations {
  String deleteUser(Map<String, dynamic> userInput) {
    String updateUserString = """
       mutation {
        deleteUser(
          userId: "${userInput['_id']}",                             
          ) {
             code
              success
              message        
                                             
          }   
        }
    """;
    return updateUserString;
  }

  String updateUserOnboarding(Map<String, dynamic> userInput) {
    String updateUserString = """
       mutation {
        updateUserOnboarding(input: {
          userId: "${userInput['_id']}"
          onboarded: ${userInput['onboarded']}                    
          preferredFoot: "${userInput['preferredFoot']}"
          preferredPosition: "${userInput['preferredPosition']}"
          skillLevel: "${userInput['skillLevel']}"
          interestedIn: "${userInput['interestedIn']}"
        }                   
          ) {
             code
                success
                message            
              user{    
                _id
              }                 
          }   
        }
    """;
    return updateUserString;
  }
 
  String updateUsertermsAndPrivacy(Map<String, dynamic> userInput) {
    String updateUserString = """
       mutation {
        updateUsertermsAndPrivacy(
          userId: "${userInput['userId']}"
          hasAcceptedPrivacyPolicy: ${userInput['hasAcceptedPrivacyPolicy']}
          hasAcceptedTermsAndConditions: ${userInput['hasAcceptedTermsAndConditions']}                     
                   
          ) {
             code
                success
                message            
              user{    
                _id                
              }                 
          }   
        }
    """;
    return updateUserString;
  }

  String createUserStripeCustomer(
      Map<String, dynamic> userInput, Map<String, dynamic> customerInput) {
    String updateUserString = """      
      mutation {
        createStripeCustomer(
          customerId: "${customerInput['customerId']}", 
          userId: "${userInput['_id']}"          
          ) {
            success 
            code
            message
            stripeCustomer{
              _id
              customerId
              user{
                _id
                name
                email
              }

            }
            
          }   
        }
        """;

    return updateUserString;
  }

  String createUserEventPayment(dynamic createUserEventPaymentInput) {
    // String paymentType = createUserEventPaymentInput['paymentType'] == 'player'
    //     ? """
    //       event: {
    //         connect: "${createUserEventPaymentInput['eventId']}"            
    //       }
    //       charge: "${createUserEventPaymentInput['charge']}"
    //       isPlayerPayment: true
    //       isTeamPayment: false
    //     """
    //     : """
    //       team: {
    //         connect: "${createUserEventPaymentInput['teamId']}"            
    //       }
    //       isPlayerPayment: false
    //       isTeamPayment: true
    //     """;

    String createUserEventPaymentString = """      
      mutation {
        createPayment(input: {
          eventId: "${createUserEventPaymentInput['eventId']}"
          userId: "${createUserEventPaymentInput['userId']}" 
          charge: "${createUserEventPaymentInput['charge']}"
          amount: "${createUserEventPaymentInput['amount']}"
          paidAt: "${createUserEventPaymentInput['paidAt']}"
          
          }) {
            code
            success 
            message
            payment{
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

  String updateUserAccount(Map<String, dynamic> userInput) {
    String updateUserString = """      
      mutation {
        updateUserAccount(input: {
          userId: "${userInput['userId']}"
          name: "${userInput['name']}"
          birthdate: "${userInput['birthdate']}"
          gender: "${userInput['gender']}"

        }            				
        ){
          code
          success
          message
          user{
            _id
            name
            birthdate
            gender                                			
          }
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
