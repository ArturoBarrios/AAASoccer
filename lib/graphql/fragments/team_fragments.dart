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
            userParticipants{
              data{
                user{
                  _id
                  name
                  email
                  phone
                }
                roles
              }
            } 

    ''';

    return fullTeamReturn;
  }
}
