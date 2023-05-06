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
            joinConditions{
              _id
              withRequest
              withPayment
            }
            price{                    
              _id
              amount
              team{
                _id
                name                      
              }
            }
            payments{
              data{
                _id
                amount
                user{
                  _id
                  name
                }
                team{
                  _id
                  name
                }
              }
            }
    ''';

    return fullTeamReturn;
  }
}
