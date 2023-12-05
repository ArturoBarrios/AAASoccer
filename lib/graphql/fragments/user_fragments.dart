import 'chat_fragments.dart';
import 'group_fragments.dart';
import 'image_fragments.dart';
import 'request_fragments.dart';
import 'event_fragments.dart';
import 'team_fragments.dart';

class UserFragments {
  String fullUser() {
    String fullUserReturn = """
      isSuperUser
      _id      
      name        	
      phone
      email              
      username
      birthdate                    
      OSPID
      onboarded
      mainImageKey
      gender
      isProfilePrivate
      hostRating
      updatedAt
      hasAcceptedTermsAndConditions
      hasAcceptedPrivacyPolicy
      stripeCustomers{        
          _id
          customerId        
      }
      eventRatings{        
        _id
        eventRating
        hostRating
        fieldLocationRating          
        user{
          _id
        }
      }      
      followers{        
        follower{
          _id
          name
        }
        following{
          _id
          name
        }
      }      
      following{        
          follower{
            _id
            name
          }
          following{
            _id
            name
          }
        }           
      images{        
          ${ImageFragments().fullImage()}        
      }
      location{
        _id
        latitude
        longitude
      }
      eventUserParticipants{
        
          _id
          user{
            _id
          }
          event{
            ${EventFragments().fullEvent()}  
          }
          roles
      }
      

      
      requestsReceived{        
          ${RequestFragments().fullRequest()}                      
      }
      requestsSent{        
          ${RequestFragments().fullRequest()}           
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

  String eventUserParticipants() {
    String fullUserReturn = """
       _id      
              name        	
             
              eventUserParticipants{
                data{
                  _id
                  event{
                    _id
                  }
                  roles
                }
              }
              
              
    """;

    return fullUserReturn;
  }
}
