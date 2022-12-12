class TeamMutations {
  String createTeam(Map<String, dynamic> teamInput, Map<String, dynamic> locationInput) {
    String createTeam = """
      mutation {
        createTeam(data: {
          name: "${teamInput['name']}",
          color: "${teamInput['color']}",
          teamUserOrganizers: {
            create:
              {
                users: {
                  connect:[                        
                      "${teamInput['user_id']}"                       
                  ]
                }                    
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
            _id
            name
            color
            location{
              _id
              latitude
              longitude
            }      
          }   
        }
        """;

    return createTeam;
  }
    
  
 String updateTeamRequest(
      Map<String, dynamic> teamRequestInput) {
      String updateTeamRequest = """
      mutation {
        updateTeamRequest(id: ${teamRequestInput['_id']},
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


String sendTeamRequest(
      Map<String, dynamic> teamRequestInput, String organizersString, String receivers) {
      String sendTeamRequestString = """
      mutation {
        createTeamRequest(data: {    
          requestAttempts: 1, 
          status: PENDING,
          organizers: {
            connect: [
              $organizersString
            ]
          },
          sender: {
            connect: "${teamRequestInput['sender_id']}"            
          },  
          receivers: {
            connect: [            
              $receivers
            ]
          }  
          team: {
            connect: "${teamRequestInput['_id']}"            
          }                     
          }) {
            _id
            status
            requestAttempts
            organizers{
              data{
                _id
                email
                name
              }
            }
            receivers{
              data{
                _id
                email
                name
              }
            }
            sender{              
                _id
                name
                email              
            }   
            acceptedBy{              
                _id
                email
                name              
            }            
            team{              
                _id
                name              
            }            
          }   
        }
        """;

    return sendTeamRequestString;
    }

}
