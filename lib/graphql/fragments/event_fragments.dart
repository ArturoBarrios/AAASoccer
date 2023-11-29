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
      amenities
      eventRatings{        
          _id
          eventRating
          hostRating
          fieldLocationRating          
          user{
            _id
          }
        }
      
      
      requests{      
          ${RequestFragments().fullRequest()}        
      }
      images{        
          ${ImageFragments().fullImage()}                      
      }      
      SocialMediaApps{       
          ${fullSocialMediaApps()}       
      }
      joinConditions{        
        _id
        withRequest
        withPayment        
        forEvent        
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
        _id
        pickup        
      }                        
      fieldLocations{      
        ${LocationFragments().FieldLocationFull()}              
      }
      userParticipants{             
        _id
        roles                                                                    
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
        }          
      }
      payments{        
        _id
        amount   
        isPlayerPayment
        isTeamPayment       
        user{
          _id
          name
          username
        }
        event{
          _id
          name
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
        }                                                              
      }      
    """;

    return minimalEventReturn;
  }
}
