import '../fragments/team_fragments.dart';

class TeamMutations {
  String createTeam(Map<String, dynamic> teamInput, Map<String, dynamic> locationInput) {
    String createTeam = """
      mutation {
        createTeam(data: {
          name: "${teamInput['name']}",
          color: "${teamInput['color']}",          
          status: "ACTIVE"
          createdAt: "${teamInput['createdAt']}",
          joinConditions: {
            create: {
              withRequest: ${teamInput['withRequest']},
              withPayment: ${teamInput['withPayment']},
            }
          },
          userParticipants: {
                create:
                  {
                    user: {
                      connect:                   
                          "${teamInput['user_id']}"    
                      }                                         
                      roles: "${teamInput['roles']}"
                                       
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

  String createPrice(
    Map<String, dynamic> paymentInput,
    Map<String, dynamic> teamInput,
  ) {
    String createPrice = """
     mutation {
        createPrice(data: {      
          amount: "${paymentInput['price']}",  
          team: {
              connect: "${teamInput['_id']}"
            },  
                                    
          }) {
            _id    
            amount
            team {
              _id
              name
            }                                  
          }
        }
        """;

    return createPrice;
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

    String removeUserFromTeam(
      dynamic team, dynamic user) {
      String updateTeamRequest = """
      mutation {
        updateRequest(id: ${team['_id']},
          data: {              
          status: ACCEPTED,
          acceptedBy: {
           	connect: "${team['acceptedBy_id']}"           
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
