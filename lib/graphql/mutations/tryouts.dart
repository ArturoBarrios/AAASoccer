import '../fragments/event_fragments.dart';

class TryoutMutations{
  String createTryout(Map<String, dynamic> tryoutInput, Map<String, dynamic> eventInput ,Map<String, dynamic> locationInput, Map<String, dynamic> userInput) {
    String createTryout = """
      mutation {
        createTryout(data: {                    
          event: {
            create: 
            {
              name: "${eventInput['name']}",
              type: TRYOUT,
              archived: false,
              isMainEvent:true,
              startTime: "${eventInput['startTime']}",
              endTime: "${eventInput['endTime']}",
              createdAt: "${eventInput['createdAt']}",
              capacity: ${eventInput['capacity']},
              joinConditions: {
                create: {
                  withRequest: ${eventInput['withRequest']},
                  withPayment: ${eventInput['withPayment']},
                }
              },
              userParticipants: {
                create:
                  {
                    user: {
                      connect:                   
                          "${userInput['_id']}"    
                      }                                         
                      roles: "{ORGANIZER, PLAYER}"
                                       
                  }                                     
              },              
              location: {
                create: 
                {
                  latitude: ${locationInput['latitude']},
                  longitude: ${locationInput['longitude']},
                }
              }
            }
          }
        }) {
          _id
          event{
            ${EventFragments().fullEvent()}
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