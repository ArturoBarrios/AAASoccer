import '../../commands/network_models/add_social_media_apps_request.dart';
import '../fragments/event_fragments.dart';

class EventMutations {
  String getEvent(Map<String, dynamic> eventInput) {
    String getEvent = """      
      query {
        findEventByID(id: ${eventInput['_id']}) {
          ${EventFragments().fullEvent()}
        }
      }
      """;

    return getEvent;
  }

  String addPlayerToEventDoesntWork(
      Map<String, dynamic> eventInput, Map<String, dynamic> playerInput) {
    String addPlayerToEvent = """      
      mutation {
        updateEvent(
          id: ${eventInput['_id']},
  				data: {   
            name: "${eventInput['name']}",
            isMainEvent: ${eventInput['isMainEvent']},         
            users:{
              connect:[
                ${playerInput['user']['_id']}
              ]
              
            }
          }
                      
        ){
              _id
              location{
                data{
                  _id
                  latitude
                  longitude
                }
              
            } 
    				users{	
              data{
                  	_id
                    
              }
            }   
          }
        }
        """;

    return addPlayerToEvent;
  }

  String updateEventImage(Map<String, dynamic> eventInput) {
    String updateUserString = """      
      mutation {
        updateEvent(id: ${eventInput['_id']},
  				data: {            
            mainImageKey: "${eventInput['mainImageKey']}"                                                                                
          }                      
        ){
          ${EventFragments().fullEvent()}                              			
  }
}
        """;

    return updateUserString;
  }

  String addUserToEvent(Map<String, dynamic> eventInput,
      Map<String, dynamic> userInput, String roles) {
    String addPlayerToEvent = """      
      mutation {
        addUserToEvent(
          eventId: "${eventInput['_id']}"
          userId: "${userInput['_id']}"
          roles: "$roles"  				                     
        ){
          code 
          success
          message
          event{
            ${EventFragments().fullEvent()}
          }                  				  
        }
      }
        """;

    return addPlayerToEvent;
  }

  String deleteEventUserParticipant(
    Map<String, dynamic> event,
  ) {
    String deleteEventUserParticipantString = """      
      mutation {
        deleteEventUserParticipant(
          id: ${event['eventUserParticipantId']}
        )
        {
          _id
              
    				  
          }
        }
        """;

    return deleteEventUserParticipantString;
  }

  String updateEventUserParticipant(dynamic updateEventUserParticipantInput) {
    String updateEventUserParticipantString = """
      mutation {
        updateEventUserParticipant(id: ${updateEventUserParticipantInput['_id']},
          data: {                      
          roles: "${updateEventUserParticipantInput['roles']}",                                             
          }) {
              _id
                user{
                  _id
                  name
                  email
                  phone
                }
                roles
                
    				
                 
          }   
        }
        """;

    return updateEventUserParticipantString;
  }

  String updateEventUserParticipantRsv(
      dynamic updateEventUserParticipantInput) {
    String updateEventUserParticipantString = """
      mutation partialUpdateEventUserParticipant {
        updateEventUserParticipant(
          id:"${updateEventUserParticipantInput['participantId']}",
          data: {
            isAttending: ${updateEventUserParticipantInput['isAttending']},
            user: { connect: "${updateEventUserParticipantInput['userId']}" },
            event: { connect: "${updateEventUserParticipantInput['eventId']}"}
          }
        ) {
    _id
    user {
      _id
      name
      email
      phone
    }
    event {
      userParticipants {
        data{
          _id
          event{                        
            _id
            name
          }
          user{
            _id
            name
            email
            username
            userType
            teams{
              data{
                _id
              }

            }
          }          
          roles
          isAttending
        } 
      }
    }
    roles
    isAttending
  }
}
        """;

    return updateEventUserParticipantString;
  }

  String updateUserRolesInEvent(Map<String, dynamic> eventInput,
      Map<String, dynamic> userInput, String roles, String eventRequestId) {
    String addPlayerToEvent = """      
      mutation {
        partialUpdateEventUserParticipant(
          id: ${eventRequestId},
  				data: {                       
            roles: "$roles"                                                      
          }                      
        ){
          _id,
          roles,
          user{
            _id
            username
          }
          event{
            ${EventFragments().fullEvent()}

          }
              
    				  
          }
        }
        """;

    return addPlayerToEvent;
  }

  String updateEventSocialMedia(
      {required final AddSocialMediaAppsRequest body}) {
    String addSocialMediaToEventMutation = """
          id: ${body.eventId},
          data: {
            SocialMediaApps: {
              create: {
                type: ${body.socialMediaType}
                url: "${body.socialMediaUrl}"
                user: {
                  connect: "${body.userId}"
                }
                event: {
                  connect: "${body.eventId}"
                }
              }
            }
          }
    """;

    return addSocialMediaToEventMutation;
  }

  String deleteSocialMediaApps(
    Map<String, dynamic> event,
  ) {
    String deleteEventUserParticipantString = """      
      mutation {
        deleteSocialMediaApp(
          id: ${event['_id']}
        )
        {
          _id
          }
        }
        """;

    return deleteEventUserParticipantString;
  }

  String createPrice(
    Map<String, dynamic> paymentInput,
    Map<String, dynamic> eventInput,
  ) {
    // Check if 'teamAmount' is present in paymentInput, if not set it to 0
    var teamAmount = paymentInput.containsKey('teamPrice')
        ? paymentInput['teamPrice']
        : "0.00";

    String createPrice = """
   mutation {
      createPrice(data: {      
        amount: "${paymentInput['price']}",  
        teamAmount: "$teamAmount",
        event: {
            connect: "${eventInput['_id']}"
          },  
                                  
        }) {
          _id    
          amount
          teamAmount
          event {
            _id
            name
          }                                  
        }
      }
      """;

    return createPrice;
  }

  String addTeam(dynamic eventInput, dynamic teamInput) {
    String addTeamString = """      
      mutation {
        updateEvent(id: ${eventInput['_id']},
  				data: {            
            teams: {
              connect: [
                ${teamInput['_id']}                                                                                 
              ]
            }             
          }                      
        ){
        ${EventFragments().fullEvent()}
                                             			
      }
    }
    """;

    return addTeamString;
  }

  String removeTeamFromEvent(Map<String, dynamic> removeTeamFromEventInput) {
    String removeTeamString = """      
    mutation {
      updateEvent(id: ${removeTeamFromEventInput['event_id']},
        data: {            
          teams: {
            disconnect: [
              ${removeTeamFromEventInput['team_id']}                                                                                 
            ]
          }             
        }                      
      ){
        ${EventFragments().fullEvent()}
      }
    }
  """;

    return removeTeamString;
  }

  String archiveEvent(dynamic event) {
    String archiveEventString = """      
      mutation {
        updateEvent(id: ${event['_id']},
          data: {
            archived: true
               
          }  				                  
        ){
          ${EventFragments().fullEvent()}    			  
  }
}
        """;

    return archiveEventString;
  }

  String createEvent(Map<String, dynamic> eventInput) {
    // TODO add more attrs
    String createEvent = """      
mutation {
  createEvent(
    data: {
      name: "${eventInput['name']}"
      capacity: ${eventInput['capacity']}

    }
  ) {
    ${EventFragments().fullEvent()}  
  }
}
""";

    return createEvent;
  }

}
