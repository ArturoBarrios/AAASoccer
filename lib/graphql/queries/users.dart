
class UserQueries {
  static String getAllUsers = """
    query getAllUsers() {
      users(order_by: {  }) {        
        id
        name        
      }
    }
  """;

}