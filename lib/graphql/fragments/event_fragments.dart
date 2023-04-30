import 'package:soccermadeeasy/graphql/fragments/team_fragments.dart';

class EventFragments {
  
  String fullEvent() {
    String fullEventReturn = """
      name        	
      _id  
      type                  
      archived
      isMainEvent
      deleted  
      startTime
      endTime  
      createdAt
      joinConditions{
        _id
        withRequest
        withPayment
      }
      price{                    
        _id
        amount
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
      teams{
          data{
            ${TeamFragments().fullTeam()}
          }
        }
      location{
        data{
        _id
        latitude
        longitude
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
      payments{
        data{
          _id
          amount
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
}
