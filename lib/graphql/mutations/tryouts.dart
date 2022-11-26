class TryoutMutations{
  String createTryout(Map<String, dynamic> tryoutInput, Map<String, dynamic> eventInput ,Map<String, dynamic> locationInput) {
    String createTryout = """
      mutation {
        createTryout(data: {                    
          event: {
            create: 
            {
              name: "${eventInput['name']}",
              isMainEvent: ${eventInput ['isMainEvent']},
              location: {
                create: 
                {
                  latitude: ${locationInput['latitude']},
                  longitude: ${locationInput ['longitude']},
                }
              }
            }
          } 
          }) {
            _id                       
            event{
              _id
              name
              isMainEvent
              location{
                data{
                  _id
                  latitude
                  longitude
                }
              }     
            } 
          }   
        }
        """;

    return createTryout;
  }

  String addPlayerToTryout(
      Map<String, dynamic> tryoutInput, Map<String, dynamic> playerInput) {
    String addPlayerToTryout = """      
      mutation {
        updateTryout(id: ${tryoutInput['_id']},
  				data: {            
            players:{
              connect:[
                ${playerInput['_id']}
              ]
              
            }
          }
                      
        ){
            _id    				        
            event{
              _id
              location{
                data{
                  _id
                  latitude
                  longitude
                }
              }
            } 
    				players{	
              data{
                  	_id
                    
              }
            }
            
                  
            
            
  }
}
        """;

    return addPlayerToTryout;
  }
}