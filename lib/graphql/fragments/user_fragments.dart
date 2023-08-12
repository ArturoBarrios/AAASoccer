import 'chat_fragments.dart';
import 'image_fragments.dart';
import 'request_fragments.dart';
import 'event_fragments.dart';
import 'team_fragments.dart';

class UserFragments{

  String fullUser(){
     String FullUserReturn = """
       _id      
              name        	
              phone
              email              
              username
              birthdate              
              gender
              OSPID
              mainImageKey
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
              subscriptionTypeUsers{
                data{
                  _id
                  startDate
                  endDate                  
                  length
                  subscriptionType{
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
              events{
                data{
                  ${EventFragments().fullEvent()}               

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
              requestsSent{
                data{
                  ${RequestFragments().fullRequest()}   
                }
              }
    """;

    return FullUserReturn;

  }

  
}