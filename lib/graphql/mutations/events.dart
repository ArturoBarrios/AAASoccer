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
                email
                name
              }
            }
            receivers{
              data{
                _id
                email
                name
              }
            }
            sender{                            
              _id
              email
              name              
            }   
            acceptedBy{              
                _id
                email
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
      String updateEventRequest = """
      mutation {
        updateEventRequest(id: ${eventRequestInput['_id']},
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
                email         
            }
            organizers{                            
              data{
              _id
              name     
              email         
              }
            }   
            receivers{                            
              data{
              _id
              name     
              email         
              }
            }   
            sender{              
                _id
                OSPID
                name          
                email             
            }            
            event{              
                _id
                name              
            }            
    				
                 
          }   
        }
        """;

    return updateEventRequest;
    }
}