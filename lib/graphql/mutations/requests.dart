import '../fragments/request_fragments.dart';

class RequestMutations {
  String sendEventRequestV2(Map<String, dynamic> eventRequestInput
    ) {
    String createEventRequest = """
      mutation {
        createRequest(
          data: {    
            status: PENDING,
            requestAttempts: 1,                                           
            receivers: {
              connect: [
                ${eventRequestInput['receivers']}
              ]
            }
            type: EVENTREQUEST,
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

  String updateRequest(Map<String, dynamic> eventRequestInput) {
    String updateRequest = """
      mutation {
        updateRequest(id: ${eventRequestInput['_id']},
          data: {              
          status: ACCEPTED,
          acceptedBy: {
           	connect: "${eventRequestInput['acceptedBy_id']}"           
          },                                                  
          }) {
              ${RequestFragments().fullRequest()}    				
                 
          }   
        }
        """;

    return updateRequest;
  }

}