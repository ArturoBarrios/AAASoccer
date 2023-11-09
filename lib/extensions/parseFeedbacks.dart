import 'dart:developer';

/// Parse roles with given event.
extension ParseFeedbacks on String {
  //"{"test1", "test2", "test3"} => ["test1", "test2", "test3"]
  List<String> parseFeedbacks() {
    // Remove curly braces and split string into individual words
    List<String> words = replaceAll('{', '').replaceAll('}', '').split(', ');
    log("parsed roles : $words");
    return words;
  }
}
