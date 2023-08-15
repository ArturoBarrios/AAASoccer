import '../fragments/team_fragments.dart';

class TeamQueries {

  String getAllTeams(String from, String teamFragment) {
    String getAllTeamsString = """
      query GetEvents {
        getAllTeams(from: "$from") {                  
            ${teamFragment}        
        }
      }
    """;
    return getAllTeamsString;
  }

  String getAllTeamUserParticipants(String userId, String teamFragment) {
    String getAllTeamUserParticipantsString = """
      query GetEvents {
        getAllTeamUserParticipants(userId:"$userId") {                              
          _id
          team{
              ${teamFragment}            
          }
        }
      }
    """;
    return getAllTeamUserParticipantsString;
  }

  String getTeams(String teamFragment) {
    String getTeams = """
          query getTeams {
            allTeams {
              data {      
               ${teamFragment}  

                    
                  }
                }
              }
          """;

    return getTeams;
  }

  String findTeamByID(Map<String, dynamic> teamInput) {
    String getTeam = """
      query getTeam {
            findTeamByID(id: "${teamInput['_id']}") {      
             ${TeamFragments().fullTeam()}                                                                                    
          }
        }
    """;

    return getTeam;
  }

  String allUserTeamParticipants(
      dynamic user, String startTime, String teamFragment) {
    String getUserTeams = """
      query getTeams {
        allTeamsOfUser(startTime: "$startTime") {                  
            ${teamFragment}        
        }
      }
    """;
    return getUserTeams;
  }
}
