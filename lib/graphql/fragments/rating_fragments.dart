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
          ratings
          ratingCategories                           
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








