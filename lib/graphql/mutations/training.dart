import '../fragments/event_fragments.dart';

class TrainingMutations {
  String createTraining(
      Map<String, dynamic> trainingInput,
      Map<String, dynamic> eventInput,
      Map<String, dynamic> locationInput,
      Map<String, dynamic> userInput) {
    var teamAmount = eventInput.containsKey('teamPrice') ? eventInput['teamPrice'] : "0.00";
    String createTraining = """
      mutation {
        createTraining(data: {                    
          event: {
            create: 
            {
              name: "${eventInput['name']}",
              type: TRAINING,
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
              fieldLocations: {
                create: [
                  {
                    isMainField: true
                    location: {    
                      create: {
                        name: "${locationInput['name']}",
                        latitude: ${locationInput['latitude']},
                        longitude: ${locationInput ['longitude']},
                      }            
                    }
                  }
                ]
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
