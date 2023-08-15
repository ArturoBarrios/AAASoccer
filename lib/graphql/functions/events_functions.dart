class EventsFunctions {
  String allEventsOfType() {
    
    String allEventsOfType = """
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
                  Paginate(Documents(Collection("Event")), { size: 100 }),
                  Lambda(
                    "ref",
                    Let(
                      {
                        event: Get(Var("ref")),
                        eventTime: If(
                          Contains(["data", "endTime"], Var("event")),
                          ToTime(
                            ToInteger(Select(["data", "endTime"], Var("event")))
                          ),
                          null
                        ),
                        eventType: If(
                          Contains(["data", "type"], Var("event")),
                          Select(["data", "type"], Var("event")),
                          null
                        ),
                        archived: Select(["data", "archived"], Var("event"), false),
                        isMainEvent: Select(
                          ["data", "isMainEvent"],
                          Var("event"),
                          false
                        )
                      },
                      And(
                        GT(Var("eventTime"), Var("timestamp")),
                        Equals(Var("eventType"), Var("target_type")),
                        Not(Var("archived")),
                        Var("isMainEvent")
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

    return allEventsOfType;
  }

  String allEventsOfAllTypes() {
    String allEventsOfAllTypes = """
     Query(
        Lambda(
          ["startTime"],
          Let(
            { timestamp: ToTime(ToInteger(Var("startTime"))) },
            Select(
              ["data"],
              Map(
                Filter(
                  Paginate(Documents(Collection("Event")), { size: 100 }),
                  Lambda(
                    "ref",
                    Let(
                      {
                        event: Get(Var("ref")),
                        eventTime: If(
                          Contains(["data", "endTime"], Var("event")),
                          ToTime(
                            ToInteger(Select(["data", "endTime"], Var("event")))
                          ),
                          null
                        ),
                        archived: Select(["data", "archived"], Var("event"), false),
                        isMainEvent: Select(
                          ["data", "isMainEvent"],
                          Var("event"),
                          false
                        )
                      },
                      And(
                        GT(Var("eventTime"), Var("timestamp")),
                        Not(Var("archived")),
                        Var("isMainEvent")
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

    return allEventsOfAllTypes;
  }

  String allCurrentUserEventParticipants() {
    String allEventsOfAllTypes = """
     Query(
      Lambda(
        ["userId", "startTime"],
        Let(
          {
            userRef: Ref(Collection("User"), Var("userId")),
            timestamp: ToTime(ToInteger(Var("startTime")))
          },
          Select(
            ["data"],
            Map(
              Filter(
                Paginate(Documents(Collection("EventUserParticipant")), {
                  size: 100
                }),
                Lambda(
                  "ref",
                  Let(
                    {
                      participant: Get(Var("ref")),
                      eventRef: Select(["data", "event"], Var("participant")),
                      event: Get(Var("eventRef")),
                      eventTime: ToTime(
                        ToInteger(Select(["data", "endTime"], Var("event")))
                      ),
                      userId: Select(["data", "user"], Var("participant"))
                    },
                    And(
                      Equals(Var("userId"), Var("userRef")),
                      GT(Var("eventTime"), Var("timestamp"))
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

    return allEventsOfAllTypes;
  }
}
