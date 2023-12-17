import '../fragments/request_fragments.dart';

class RequestMutations {
  String sendEventRequest(Map<String, dynamic> eventRequestInput) {
    String createEventRequest = """
      mutation {
        createRequest(
          data: {    
            status: PENDING,
            requestAttempts: 1,                                           
            type: ${eventRequestInput['type']},
            receivers: {
              connect: [
                ${eventRequestInput['receivers']}
              ]
            }
            sender: {
              connect: ${eventRequestInput['sender_id']}           
            },                                    
            event: {
              connect: ${eventRequestInput['event_id']}                       
            } 
            forRole: "${eventRequestInput['forRole']}"                      
          }) {
             ${RequestFragments().fullRequest()}   
    				
                 
          }   
        }
        """;

    return createEventRequest;
  }

  String updateRequest(Map<String, dynamic> requestInput) {
    String updateRequest = """
      mutation {
        updateRequest(id: ${requestInput['_id']},
          data: {              
          status: ACCEPTED,
          acceptedBy: {
           	connect: "${requestInput['acceptedBy_id']}"           
          },                                                  
          }) {
              ${RequestFragments().fullRequest()}    				
                 
          }   
        }
        """;

    return updateRequest;
  }

  String sendTeamRequest(Map<String, dynamic> teamRequestInput) {
    String sendTeamRequestString = """
      mutation {
        createRequest(data: {    
          status: PENDING,
          requestAttempts: 1, 
          type: TEAMREQUEST,         
          receivers: {
              connect: [
                ${teamRequestInput['receivers']}
              ]
            }
          sender: {
            connect: "${teamRequestInput['sender_id']}"            
          },  
          team: {
            connect: "${teamRequestInput['team_id']}"            
          }   
          forRole: "${teamRequestInput['forRole']}"                                        
          }) {
            ${RequestFragments().fullRequest()}        
          }   
        }
        """;

    return sendTeamRequestString;
  }

  String sendTeamEventRequest(Map<String, dynamic> teamRequestInput) {
    String sendTeamRequestString = """
      mutation {
        createRequest(data: {    
          status: PENDING,
          requestAttempts: 1, 
          type: ${teamRequestInput['type']},         
          receivers: {
              connect: [
                ${teamRequestInput['receivers']}
              ]
            }
          sender: {
            connect: "${teamRequestInput['sender_id']}"            
          },  
          team: {
            connect: "${teamRequestInput['team_id']}"            
          }   
          forRole: "PLAYER",
          event:{
            connect: "${teamRequestInput['event_id']}"
          }                                        
          }) {
            ${RequestFragments().fullRequest()}        
          }   
        }
        """;

    return sendTeamRequestString;
  }

  String sendFriendRequest(Map<String, dynamic> sendFriendRequestInput) {
    String sendFriendRequestString = """
      mutation {
        createRequest(data: {    
          requestAttempts: 1, 
          status: PENDING,
          type: FRIENDREQUEST,
          sender: {
            connect: "${sendFriendRequestInput['sender_id']}"
          },  
           receivers: {
              connect: [
                ${sendFriendRequestInput['receiver_id']}
              ]
            }
          }) {
           ${RequestFragments().fullRequest()}    
          }   
        }
        """;

    return sendFriendRequestString;
  }

  String sendChatRequest(Map<String, dynamic> requestInput) {
    String request = requestInput['type'] == 'EVENTCHATREQUEST'
        ? """
          event: {
            connect: "${requestInput['typeId']}"            
          } 
          """
        : """
          team:{
            connect: "${requestInput['typeId']}"
          }
          """;

    String sendTeamRequestString = """
      mutation {
        createRequest(data: {    
          status: PENDING,
          requestAttempts: 1, 
          type: ${requestInput['type']},
          $request           
          receivers: {
              connect: [
                ${requestInput['receiverId']}
              ]
            }
          sender: {
            connect: "${requestInput['senderId']}"            
          },  
          }) {
            ${RequestFragments().fullRequest()}        
          }   
        }
        """;

    return sendTeamRequestString;
  }
}
