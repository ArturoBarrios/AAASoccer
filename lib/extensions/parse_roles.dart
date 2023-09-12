import 'dart:developer';

/// Parse roles with given event.
extension ParseRoles on String {
  //"{"test1", "test2", "test3"} => ["test1", "test2", "test3"]
  List<String> parseRoles() {
    // Remove curly braces and split string into individual words
    List<String> words = replaceAll('{', '').replaceAll('}', '').split(', ');
    log("parsed roles : $words");
    return words;
  }
}
