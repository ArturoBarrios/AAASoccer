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
      Map<String, dynamic> senderInput, Map<String, dynamic> receiverInput) {
      String createFriendRequest = """
      mutation {
        CreateFriendRequest(data: {    
          requestAttempts: 1, 
          to: {
            connect: 
            {
              _id: "${receiverInput['_id']}"
            }
          },  
          from: {
            connect: 
            {
              _id: "${senderInput['_id']}"
            }
          }                       
          }) {
            _id
            status
            requestAttempts
            to{
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
          }   
        }
        """;

    return createFriendRequest;
    }
}