import 'chat_fragments.dart';
import 'group_fragments.dart';
import 'image_fragments.dart';
import 'request_fragments.dart';
import 'event_fragments.dart';
import 'team_fragments.dart';

class UserFragments {
  String fullUser() {
    String fullUserReturn = """
       _id      
              name        	
              phone
              email              
              username
              birthdate              
              gender
              OSPID
              onboarded
              mainImageKey
              isProfilePrivate
              updatedAt
              followers{
                data{
                  follower{
                    _id
                    name
                  }
                  following{
                    _id
                    name
                  }

                }
              }
              following{
                data{
                  follower{
                    _id
                    name
                  }
                  following{
                    _id
                    name
                  }
                }
              }              
              images{
                data{
                  ${ImageFragments().fullImage()}
                }
              }
              location{
                _id
                latitude
                longitude
              }
              eventUserParticipants{
                data{
                  _id
                  user{
                    _id
                  }
                  event{
                    ${EventFragments().fullEvent()}  
                  }
                  roles
                }
              }
              teamUserParticipants{
                data{
                  _id
                  team{
                    ${TeamFragments().fullTeam()}  
                  }
                  roles
                }
              }
              
              requestsReceived{
                data{
                  ${RequestFragments().fullRequest()}              
                }
              }
              requestsSent{
                data{
                  ${RequestFragments().fullRequest()}   
                }
              }
              stripeCustomers{
                data{
                  _id
                  customerId
                }
              }
              
              
              sentMessages{
                data{
                  _id
                }
                
              }      
              chats{
                data{
                  ${ChatFragments().chatObject()}               

                }
              }
              
              
    """;

    return fullUserReturn;
  }
  
  String userGroupParticipants() {
    String fullUserReturn = """
       _id      
              name        	
             
              groupUserParticipants{
                data{
                  _id
                  group{
                    ${GroupFragments().fullGroup()}  
                  }
                  roles
                }
              }
              
              
    """;

    return fullUserReturn;
  }
}
