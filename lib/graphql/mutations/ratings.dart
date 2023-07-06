import '../fragments/rating_fragments.dart';

class RatingMutations {
  String updateRating(
      Map<String, dynamic> ratingInput) {    
    // var teamAmount = priceInput.containsKey('teamAmount') ? priceInput['teamAmount'] : "0";
    String updateRatingString = """
      mutation {
        updateRating(
          id: ${ratingInput['_id']},
  				data: {                       
               
          }                      
        ){
          ${RatingFragments().fullRating()}                 				                    				  
          }
        }
        """;

    return updateRatingString;
  }
  
  String createRating(
      Map<String, dynamic> ratingInput) {    
    // var teamAmount = priceInput.containsKey('teamAmount') ? priceInput['teamAmount'] : "0";
    String createRatingString = """
      mutation {
        createRating(data: {                       
          rating: "${ratingInput['rating']}",      
        }                      
        ){
          ${RatingFragments().fullRating()}                 				                    				  
          }
        }
        """;

    return createRatingString;
  }
}
