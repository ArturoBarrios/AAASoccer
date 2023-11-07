import 'package:soccermadeeasy/graphql/fragments/request_fragments.dart';
import 'package:soccermadeeasy/graphql/fragments/team_fragments.dart';
import 'package:soccermadeeasy/graphql/fragments/chat_fragments.dart';
import 'package:soccermadeeasy/graphql/fragments/location_fragments.dart';

import 'image_fragments.dart';

class EventFragments {
  String userEventParticipants() {
    String userEventParticipantsReturn = """
      _id      
      user{
        _id
        name
        email
      }
      roles
      event{
        ${fullEvent()}
      }
    """;
    return userEventParticipantsReturn;
  }

  String fullSocialMediaApps() {
    String fullImageReturn = """
          _id
          type
          url
          user{
            _id
            name
            email
            userType
          }                 
          team{
            _id
            name
          }           
          event{
            _id
            name
          }   
      """;

    return fullImageReturn;
  }

  String fullEvent() {
    String fullEventReturn = """
      name        	
      _id  
      type                        
      isMainEvent
      mainImageKey
      archived
      deleted  
      startTime
      endTime  
      capacity
      createdAt
      eventReputation{
        ratings{
          data{
            _id
            rating
          }
        }
      }
      requests{
        data{
          ${RequestFragments().fullRequest()}
        }
      }
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
      SocialMediaApps{
        data{
          ${fullSocialMediaApps()}
        }
      }
      joinConditions{
        data{
          _id
          withRequest
          withPayment
          forTeam
          forEvent
        }
      }
      price{                    
        _id
        amount
        teamAmount
        event{
          _id
          name                      
        }
      }
      games{
        data{
          _id
          pickup
        }
      }
      trainings{
        data{
          _id
        }
      }
      tryouts{
        data{
          _id
        }
      }
      tournaments{
        data{
          _id
        }
      } 
      leagues{
        data{
          _id
        }
      }
      teams{
          data{
            ${TeamFragments().fullTeam()}
          }
        }
      fieldLocations{
        data{
          ${LocationFragments().FieldLocationFull()}        
        }
      }
      userParticipants{     
        data{
          _id
          event{                        
            _id
            name
          }
          user{
            _id
            name
            email
            username
            userType
            teams{
              data{
                _id
              }

            }
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
          event{
            _id
            name
          }
        }                                                              
      }
    """;

    return fullEventReturn;
  }

  String minimalEvent() {
    String minimalEventReturn = """
      name        	
      _id  
      type                  
      archived
      isMainEvent
      mainImageKey
      deleted  
      startTime
      endTime  
      capacity
      createdAt                 
      fieldLocations{
        data{
          ${LocationFragments().FieldLocationFull()}
        }
      } 
      teams{
          data{
            _id
          }
        }
      
      userParticipants{     
        data{
          _id
          event{                        
            _id
            name
          }
          user{
            _id
            name
            email
            username
            userType
            teams{
              data{
                _id
              }

            }
          }          
          roles
          isAttending
        }                                                              
      }      
    """;

    return minimalEventReturn;
  }
}
