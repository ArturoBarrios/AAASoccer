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
}
