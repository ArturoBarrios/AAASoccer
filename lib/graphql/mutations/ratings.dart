import '../fragments/rating_fragments.dart';

class RatingMutations {
  String createRatingCategory(
      Map<String, dynamic> ratingCategoryInput) {
    print("teamInput: $ratingCategoryInput");    
    String createRatingCategoryString = """
      mutation {
        createTeam(data: {
          name: "${ratingCategoryInput['name']}",
          ratingCategory: "${ratingCategoryInput['weight']}",             
          }) {
           ${RatingFragments().ratingCategory()}
          }   
        }
        """;

    return createRatingCategoryString;
  }
}
