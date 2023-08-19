import '../fragments/team_fragments.dart';

class TeamMutations {
  String createTeam(
      Map<String, dynamic> teamInput, Map<String, dynamic> locationInput) {
    print("teamInput: $teamInput");
    print("locationInput: $locationInput");
    String createTeam = """
      mutation {
        createTeam(data: {
          name: "${teamInput['name']}",
          color: "${teamInput['color']}",          
          status: "ACTIVE",
          capacity:"${teamInput['capacity']}",
          createdAt: "${teamInput['createdAt']}",
          updatedAt: "${teamInput['updatedAt']}",
          chats: {
                create: [
                  {
                    name: "General",
                    isPrivate: false,
                    users: {
                      connect: [
                        "${teamInput['user_id']}"
                      ]
                    }


                  }
                ]
              }    
          price: {
                create: {
                  amount: "${teamInput['price']}",                                
                }
              },
          joinConditions: {
            create: {
              withRequest: ${teamInput['withRequest']},
              withPayment: ${teamInput['withPayment']},
              forTeam: true

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
              longitude: ${locationInput['longitude']},
              name: "${locationInput['name']}",
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

  String updateTeamRequest(Map<String, dynamic> teamRequestInput) {
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

  String updateUserRolesInTeam(Map<String, dynamic> teamInput,
      Map<String, dynamic> userInput, String roles, String teamRequestId) {
    String addPlayerToTeam = """      
      mutation {
        partialUpdateTeamUserParticipant(
          id: ${teamRequestId},
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
          team{
            ${TeamFragments().fullTeam()}

          }
              
    				  
          }
        }
        """;

    return addPlayerToTeam;
  }

  String updateTeamUserParticipant(dynamic updateTeamUserParticipantInput) {
    String updateTeamUserParticipantString = """
      mutation {
        updateTeamUserParticipant(id: ${updateTeamUserParticipantInput['_id']},
          data: {                      
          roles: "${updateTeamUserParticipantInput['roles']}",                                             
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

    return updateTeamUserParticipantString;
  }

  String deleteTeamUserParticipant(
    Map<String, dynamic> teamUserParticipant,
  ) {
    String deleteTeamUserParticipantString = """      
      mutation {
        deleteTeamUserParticipant(
          id: ${teamUserParticipant['eventUserParticipantId']}
        )
        {
          _id
              
    				  
          }
        }
        """;

    return deleteTeamUserParticipantString;
  }
}
