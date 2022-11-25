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
      Map<String, dynamic> fromInput, Map<String, dynamic> toInput, Map<String, dynamic> eventInput) {
      String createFriendRequest = """
      mutation {
        CreateFriendRequest(data: {    
          requestAttempts: 1, 
          to: {
            connect: 
            {
              _id: "${toInput['_id']}"
            }
          },  
          from: {
            connect: 
            {
              _id: "${fromInput['_id']}"
            }
          }                       
          event: {
            connect: 
            {
              _id: "${eventInput['_id']}"
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
            event{
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