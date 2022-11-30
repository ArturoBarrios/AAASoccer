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
        createEventRequest(
          data: {    
          requestAttempts: 1, 
          tos:[            
            	"349720669660906050"                           
          ],            
          from: {
           	connect: "${eventRequestInput['from_id']}"           
          },                  
          event: {
          	connect: "${eventRequestInput['event_id']}"                       
          }                       
          }) {
              _id
            status
            requestAttempts
            tos{
              user{                
                _id
                name
              }
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