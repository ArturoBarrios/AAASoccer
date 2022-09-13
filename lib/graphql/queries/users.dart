class UserQueries {
  static String getAllPlayers = """
    query GetPlayers {
      allPlayers {
        data {
          _id
          user {
            name
          }
        }
      }
    }
  """;

  
}
