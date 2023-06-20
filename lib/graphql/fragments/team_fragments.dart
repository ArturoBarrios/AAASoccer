import 'package:soccermadeeasy/graphql/fragments/chat_fragments.dart';

class TeamFragments {
  String fullTeam() {
    String fullTeamReturn = """
            _id
            name
            color
            createdAt
            images{
              data{
                _id          
                key
                isMainImage
                public          
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
            location{
              data{
                name
                _id
                latitude
                longitude
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
}
