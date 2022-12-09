class EventMutations{
  String addPlayerToEvent(
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

  String sendEventRequest(
      Map<String, dynamic> eventRequestInput, String organizersString, String receivers) {
      String createEventRequest = """
      mutation {
        createEventRequest(
          data: {    
            status: PENDING,
            requestAttempts: 1,                     
            organizers: {
              connect: [
                $organizersString
              ]
            }
            receivers: {
              connect: [
                $receivers
              ]
            }
            sender: {
              connect: "${eventRequestInput['sender_id']}"           
            },                                    
            event: {
              connect: "${eventRequestInput['event_id']}"                       
            }                       
          }) {
              _id
            status
            requestAttempts
            organizers{
              data{
                _id
                name
              }
            }
            sender{                            
              _id
              name              
            }   
            acceptedBy{              
                _id
                name              
            }            
            organizerWhoAcceptedOrSentRequest {              
                _id
                name              
            }            
            event{              
                _id
                name              
            }            
    				
                 
          }   
        }
        """;

    return createEventRequest;
    }
  String updateEventRequest(
      Map<String, dynamic> eventRequestInput) {
      String createEventRequest = """
      mutation {
        createEventRequest(
          data: {              
          status: ACCEPTED,
          acceptedBy: {
           	connect: "${eventRequestInput['acceptedBy_id']}"           
          },                                                  
          }) {
              _id
            status
            requestAttempts
            acceptedBy{              
                _id
                name              
            }
            organizer{                            
              _id
              name              
            }   
            from{              
                _id
                name              
            }            
            event{              
                _id
                name              
            }            
    				
                 
          }   
        }
        """;

    return createEventRequest;
    }
}