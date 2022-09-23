class TrainingMutations{
  String createTraining(Map<String, dynamic> trainingInput, Map<String, dynamic> eventInput ,Map<String, dynamic> locationInput) {
    String createTraining = """
      mutation {
        createTraining(data: {                    
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

    return createTraining;
  }

  String addPlayerToTraining(
      Map<String, dynamic> trainingInput, Map<String, dynamic> playerInput) {
    String addPlayerToTraining = """      
      mutation {
        updateTraining(id: ${trainingInput['_id']},
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

    return addPlayerToTraining;
  }
}