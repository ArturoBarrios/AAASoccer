import 'chat_fragments.dart';
import 'image_fragments.dart';
import 'request_fragments.dart';
import 'event_fragments.dart';

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
                  event{
                    ${EventFragments().eventGameFragment()}  
                  }
                  roles
                }
              }
              events{
                data{
                  ${EventFragments().eventGameFragment()}               

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