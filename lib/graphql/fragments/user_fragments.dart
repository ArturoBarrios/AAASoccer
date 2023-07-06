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
              friends{   
                data{
                  _id
                  user{
                    _id
                    username
                    email   
                    OSPID                
                  }                  
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

  String playerUser(){
     String FullUserReturn = """
       _id      
              name        	
              phone
              email              
              username
              birthdate              
              gender
              OSPID
              ratings{
                data{
                  _id
                  rating                  
                }
              }
              player{
                _id
              }
              location{
                _id
                latitude
                longitude
              }
              events{
                data{
                  ${EventFragments().fullEvent()}               
                }                
              }
              stripeCustomers{
                data{
                  _id
                  customerId
                }
              }
              friends{   
                data{
                  _id
                  user{
                    _id
                    name
                    email   
                    OSPID                
                  }                  
                }                  
              }
              stripeCustomers{
                data{
                  _id
                  customerId
                }
              }
              teams{
                data{
                  _id
                  name
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

    return FullUserReturn;

  }
}