import '../fragments/team_fragments.dart';

class TeamMutations {
  String createTeam(Map<String, dynamic> teamInput, Map<String, dynamic> locationInput) {
    String createTeam = """
      mutation {
        createTeam(data: {
          name: "${teamInput['name']}",
          color: "${teamInput['color']}",          
          userParticipants: {
                create:
                  {
                    user: {
                      connect:                   
                          "${teamInput['user_id']}"    
                      }                                         
                      roles: "{ORGANIZER, PLAYER}"
                                       
                  }                                     
              },  
          location: {
            create: 
            {
              latitude: ${locationInput['latitude']},
              longitude: ${locationInput ['longitude']},
            }
          } 
          }) {
           ${TeamFragments().fullTeam()}
          }   
        }
        """;

    return createTeam;
  }
    
  
 String updateTeamRequest(
      Map<String, dynamic> teamRequestInput) {
      String updateTeamRequest = """
      mutation {
        updateRequest(id: ${teamRequestInput['_id']},
          data: {              
          status: ACCEPTED,
          acceptedBy: {
           	connect: "${teamRequestInput['acceptedBy_id']}"           
          },                                                  
          }) {
              _id
            status
            requestAttempts
            acceptedBy{              
                _id
                name              
                email         
            }
            organizers{                            
              data{
              _id
              name     
              email         
              }
            }   
            receivers{                            
              data{
              _id
              name     
              email         
              }
            }   
            sender{              
                _id
                name          
                email             
            }            
            team{              
                _id
                name              
            }            
    				
                 
          }   
        }
        """;

    return updateTeamRequest;
    }  




}
