import 'chat_fragments.dart';
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
              friendRequests{
                data{
                  _id
                  status
                  requestAttempts
                  requestType
                  sender{
                    _id
                    name
                    email
                  }
                  receiver{
                    _id
                    name
                    email
                  }
                }
              }
              eventRequestsToAccept{
                data{
                  _id
                  status
                  requestAttempts
                  requestType
                  event{
                    _id
                    name
                  }
                  sender{
                    _id
                    name
                    email
                  }
                }
              } 
              teamRequestsToAccept{
                data{
                  _id
                  status
                  requestAttempts
                  requestType
                  team{
                    _id
                    name
                  }
                  sender{
                    _id
                    name
                    email
                  }
                }
              }   
    """;

    return FullUserReturn;

  }
}