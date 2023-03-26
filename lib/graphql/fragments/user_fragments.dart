import 'chat_fragments.dart';
import 'image_fragments.dart';

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
              events{
                data{
                  _id
                  archived
                  deleted
                  name
                  isMainEvent
                  type
                  games{
                    data{
                      _id
                      pickup
                    }
                  }

                }                
              }
              requests{
                data{
                  _id
                  type
                  status
                  requestAttempts
                  fromOrganizer
                  sender{
                    _id
                    name
                    email
                    OSPID
                  }
                  receivers{
                    data{
                      _id
                      name
                      email
                      OSPID
                    }
                  }
                  acceptedBy{
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
                  _id
                  archived
                  deleted
                  name
                  isMainEvent
                  type
                  games{
                    data{
                      _id
                      pickup
                    }
                  }

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