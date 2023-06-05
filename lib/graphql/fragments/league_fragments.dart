import 'package:soccermadeeasy/graphql/fragments/event_fragments.dart';

class LeagueFragments {
  

  String leagueFragment() {
    String leagueFragmentString = """
       _id              
        numberOfTeams                           
        events{
          data{                  
            ${EventFragments().fullEvent()}
          }                  
        } 
        tournaments{
          data{
            _id
          }
        }
    """;

    return leagueFragmentString;
  }

}
