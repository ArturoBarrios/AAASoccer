class EventFragments {
  String eventGameFragment() {
    String eventGame = r'''
      _id
                  archived
                  deleted
                  name
                  isMainEvent
                  type
                  startTime
                  endTime
                  location{
                    data{
                    _id
                    latitude
                    longitude
                    }
                  }
                  games{
                    data{
                      _id
                      pickup
                    }
                  }
     ''';
    return eventGame;
  }

  String fullEvent() {
    String fullEventReturn = r'''
       name        	
                  _id  
                  type                  
                  archived
                  isMainEvent
                  deleted  
                  startTime
                  endTime  
                  price{                    
                    _id
                    amount
                    event{
                      _id
                      name                      
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
                      }
                      roles
                    }                                        
                                 
                  }
    ''';

    return fullEventReturn;
  }
}
