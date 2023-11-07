import '../fragments/rating_fragments.dart';

class RatingMutations {
 String createMultipleRatings(List<Map<String, dynamic>> ratingsList) {
  String ratingsInputsString = ratingsList.map((ratingInput) {
    // Ensure to handle escaping of strings and any potential issues with quotes
    String description = ratingInput['description'].replaceAll('"', '\\"');
    return "{ rating: ${ratingInput['rating']}, description: \"$description\" }";
  }).join(',');

  // Here, insert the fragment returned by the RatingFragments().fullRating()
  // where you need the full details of each rating returned by the mutation.
  String createRatingsString = """
    mutation CreateMultipleRatings(\$input: [CreateRatingInput!]!) {
      createMultipleRatings(input: \$input) {
        ...FullRatingFragment
      }
    }
    ${RatingFragments().fullRating()}
  """;

  return createRatingsString;
}


}
