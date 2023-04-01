import '../fragments/request_fragments.dart';

class RequestMutations {
  String sendEventRequest(Map<String, dynamic> eventRequestInput
    ) {
    String createEventRequest = """
      mutation {
        createRequest(
          data: {    
            status: PENDING,
            requestAttempts: 1,                                           
            type: EVENTREQUEST,
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


  String sendTeamRequest(
      Map<String, dynamic> teamRequestInput) {
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

}