import 'package:soccermadeeasy/graphql/fragments/chat_fragments.dart';
import 'package:soccermadeeasy/graphql/fragments/image_fragments.dart';

class GroupFragments {
  String fullGroup() {
    String fullGroupReturn = """
            _id
            name
            description
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
              group{
                _id
                name                      
              }
            }
            events{
              data{
                _id
                name

              }
            }
            groupLocations{
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
                group{
                  _id
                  name
                }
              }
            }
    """;

    return fullGroupReturn;
  }

 
}
