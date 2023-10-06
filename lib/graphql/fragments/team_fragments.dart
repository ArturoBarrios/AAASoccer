import 'package:soccermadeeasy/graphql/fragments/chat_fragments.dart';
import 'package:soccermadeeasy/graphql/fragments/image_fragments.dart';

class TeamFragments {
  String fullTeam() {
    String fullTeamReturn = """
            _id
            name
            color
            createdAt
            images{
              data{
               ${ImageFragments().fullImage()}       
              }
            }
            chats{
              data{
                ${ChatFragments().chatObject()}
              }
            }
            events{
              data{
                _id
                name

              }
            }
            teamLocations{
              data{
                location{
                  name
                  _id
                  latitude
                  longitude
                }
              }
            }    
            userParticipants{
              data{
                _id
                user{
                  _id
                  name
                  username
                  email
                  phone
                }
                roles
                isAttending
              }
            } 
            joinConditions{
              data{
                _id
                withRequest
                withPayment

              }
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
                isPlayerPayment
                isTeamPayment
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
    """;

    return fullTeamReturn;
  }

  String minimalTeam() {
    String fullTeamReturn = """
            _id
            name
            color
            createdAt                        
            events{
              data{
                _id
                name

              }
            }
            teamLocations{
              data{
                location{
                  name
                  _id
                  latitude
                  longitude
                }
              }
            }  
            userParticipants{
              data{
                _id
                user{
                  _id
                  name
                  username
                  email
                  phone
                }
                roles
                isAttending
              }
            } 
            joinConditions{
              data{
                _id
                withRequest
                withPayment

              }
            }
            price{                    
              _id
              amount
              team{
                _id
                name                      
              }
            }
            
    """;

    return fullTeamReturn;
  }
}
