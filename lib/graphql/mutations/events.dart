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
      Map<String, dynamic> eventRequestInput, String tos) {
      String createEventRequest = """
      mutation {
        CreateEventRequest(data: {    
          requestAttempts: 1, 
          tos: {
            connect: [
              tos
            ]
          },  
          from: {
            connect: 
            {
              _id: "${eventRequestInput['from_id']}"
            }
          }                       
          event: {
            connect: 
            {
              _id: "${eventRequestInput['event_id']}"
            }
          }                       
          }) {
            _id
            status
            requestAttempts
            tos{
              data{
                _id
                name
              }
            }   
            from{
              data{
                _id
                name
              }
            }            
            event{
              data{
                _id
                name
              }
            }            
          }   
        }
        """;

    return createEventRequest;
    }
}