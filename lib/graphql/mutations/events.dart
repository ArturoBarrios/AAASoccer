import '../fragments/event_fragments.dart';

class EventMutations {
  String addPlayerToEventDoesntWork(
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

  String addUserToEvent(Map<String, dynamic> eventInput,
      Map<String, dynamic> userInput, String roles) {
    String addPlayerToEvent = """      
      mutation {
        updateEvent(
          id: ${eventInput['_id']},
  				data: {                       
            userParticipants:{
              create:
              {
                user: {
                  connect:
                  "${userInput['_id']}"
                }
                roles: "$roles"
              }
            }                                                        
          }                      
        ){
          ${EventFragments().fullEvent()}
              
    				  
          }
        }
        """;

    return addPlayerToEvent;
  }

  String updateEventUserParticipant(
      dynamic updateEventUserParticipantInput){
      String updateEventUserParticipantString = """
      mutation {
        updateEventUserParticipant(id: ${updateEventUserParticipantInput['_id']},
          data: {                      
          roles: "${updateEventUserParticipantInput['roles']}",                                             
          }) {
              _id
                user{
                  _id
                  name
                  email
                  phone
                }
                roles
                
    				
                 
          }   
        }
        """;

    return updateEventUserParticipantString;
    }  

  String updateUserRolesInEvent(Map<String, dynamic> eventInput,
      Map<String, dynamic> userInput, String roles, String eventRequestId) {
    String addPlayerToEvent = """      
      mutation {
        partialUpdateEventUserParticipant(
          id: ${eventRequestId},
  				data: {                       
            roles: "$roles"                                                      
          }                      
        ){
          _id,
          roles,
          user{
            _id
            username
          }
          event{
            ${EventFragments().fullEvent()}

          }
              
    				  
          }
        }
        """;

    return addPlayerToEvent;
  }

  String createPrice(
  Map<String, dynamic> paymentInput,
  Map<String, dynamic> eventInput,
) {
  // Check if 'teamAmount' is present in paymentInput, if not set it to 0
  var teamAmount = paymentInput.containsKey('teamPrice') ? paymentInput['teamPrice'] : "0";

  String createPrice = """
   mutation {
      createPrice(data: {      
        amount: "${paymentInput['price']}",  
        teamAmount: "$teamAmount",
        event: {
            connect: "${eventInput['_id']}"
          },  
                                  
        }) {
          _id    
          amount
          event {
            _id
            name
          }                                  
        }
      }
      """;

  return createPrice;
}

  String addTeam(
      Map<String, dynamic> eventInput, Map<String, dynamic> teamInput) {
    String addTeamString = """      
      mutation {
        updateEvent(id: ${eventInput['_id']},
  				data: {            
            teams: {
              connect: [
                ${teamInput['_id']}                                                                                 
              ]
            }             
          }                      
        ){
        ${EventFragments().fullEvent()}
                                             			
      }
    }
    """;

    return addTeamString;
  }
}
