import '../fragments/team_fragments.dart';

class TeamQueries {

  String getTeams() {
    String getTeams = """
          query getTeams {
            allTeams {
              data {      
               ${TeamFragments().fullTeam()}  

                    
                  }
                }
              }
          """;

    return getTeams;
  }
  
String findTeamByID(Map<String, dynamic> teamInput ){
    String getTeam = """
      query getTeam {
            findTeamByID(id: "${teamInput['_id']}") {      
             ${TeamFragments().fullTeam()}                                                                                    
          }
        }
    """;
  
    return getTeam;
  }


}
