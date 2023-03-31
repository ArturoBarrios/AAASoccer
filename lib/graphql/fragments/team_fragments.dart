class TeamFragments {
  String fullTeam() {
    String fullTeamReturn = r'''
            _id
            name
            color
            location{
              _id
              latitude
              longitude
            }              				                          
    ''';

    return fullTeamReturn;
  }
}
