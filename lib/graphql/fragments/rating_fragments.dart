class RatingFragments{

  String fullRating(){
     String ratingObjectString = r'''      
        	_id
          amount          
          teamAmount
          event{
            _id
            name            
          }
          team{
            _id
            name
          }                        
    ''';

    return ratingObjectString;

  }

   String fullEventRating(){
     String ratingObjectString = r'''      
        	_id
          eventRating
          hostRating
          fieldLocationRating
          eventFeedback
          hostFeedback
          fieldLocationFeedback
          fieldLocation{
            _id            
          }    
          event{
            _id
          }
          user{
            _id
          }

              
    ''';

    return ratingObjectString;

  }

  String ratingCategory(){
     String ratingCategoryString = r'''      
        	_id
                               
    ''';

    return ratingCategoryString;

  }
}








