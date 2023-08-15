class TeamsFunctions {
  String getAllTeams() {
    String allTeams = """
      Query(
  Lambda(
    ["from"],
    Let(
      { timestamp: ToInteger(Var("from")) },
      Select(
        ["data"],
        Map(
          Filter(
            Paginate(Documents(Collection("Team")), { size: 100 }),
            Lambda(
              "ref",
              Let(
                {
                  team: Get(Var("ref")),
                  updatedTime: Select(["data", "updatedAt"], Var("team"), "0"),
                  deleted: Select(["data", "deleted"], Var("team"), false)
                },
                And(
                  Not(Var("deleted")),
                  GT(ToInteger(Var("updatedTime")), Var("timestamp"))
                )
              )
            )
          ),
          Lambda("ref", Get(Var("ref")))
        )
      )
    )
  )
)
    """;

    return allTeams;
  }
  
  String getAllTeamUserParticipants() {
    String allTeams = """
      Query(
  Lambda(
    ["userId"],
    Let(
      { userRef: Ref(Collection("User"), Var("userId")) },
      Select(
        ["data"],
        Map(
          Filter(
            Paginate(Documents(Collection("TeamUserParticipant")), {
              size: 100
            }),
            Lambda(
              "ref",
              Let(
                {
                  participant: Get(Var("ref")),
                  teamRef: Select(["data", "team"], Var("participant")),
                  team: Get(Var("teamRef")),
                  userId: Select(["data", "user"], Var("participant")),
                  deleted: Select(["data", "deleted"], Var("team"), false)
                },
                And(Equals(Var("userId"), Var("userRef")), Not(Var("deleted")))
              )
            )
          ),
          Lambda("ref", Get(Var("ref")))
        )
      )
    )
  )
)
    """;

    return allTeams;
  }

}
