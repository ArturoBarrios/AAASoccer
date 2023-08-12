import '../fragments/event_fragments.dart';

class TryoutMutations{
  String createTryout(Map<String, dynamic> tryoutInput, Map<String, dynamic> eventInput ,Map<String, dynamic> locationInput, Map<String, dynamic> userInput) {
    var teamAmount = eventInput.containsKey('teamPrice') ? eventInput['teamPrice'] : "0.00";
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
              chats: {
                create: [
                  {
                    name: "General",
                    isPrivate: false,
                    users: {
                      connect: [
                        "${userInput['_id']}"
                      ]
                    }


                  }
                ]
              }
              price: {
                create: {
                  amount: "${eventInput['price']}",
                  teamAmount: "$teamAmount",                  
                }
              },
              joinConditions: {
                create: [
                  {
                    withRequest: ${eventInput['withRequest']},
                    withPayment: ${eventInput['withPayment']},
                    forEvent: true
                  },
                  {
                    withRequest: ${eventInput['withTeamRequest']},
                    withPayment: ${eventInput['withTeamPayment']},
                    forTeam: true
                  }  
                ]
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
                  name: "${locationInput['name']}",
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