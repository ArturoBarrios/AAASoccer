class EventsFunctions {
  String getGamesFunctionResolver() {
    String getGamesFunctionResolver = """
      Query(
        Lambda(
          ["startTime", "type"],
          Let(
            {
              timestamp: ToTime(ToInteger(Var("startTime"))),
              target_type: Var("type")
            },
            Select(
              ["data"],
              Map(
                Filter(
                  Paginate(Documents(Collection("Event"))),
                  Lambda(
                    "ref",
                    Let(
                      {
                        event: Get(Var("ref")),
                        eventTime: Select(["data", "endTime"], Var("event")),
                        eventType: Select(["data", "type"], Var("event")),
                        archived: Select(["data", "archived"], Var("event"), false)
                      },
                      And(
                        GT(Var("eventTime"), Var("timestamp")),
                        Equals(Var("eventType"), Var("target_type")),
                        Not(Var("archived"))
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

    return getGamesFunctionResolver;
  }
}
