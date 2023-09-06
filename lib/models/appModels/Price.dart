

class Price {
  String? amount;
  Event? event;  // You will define this Event class similarly
  Team? team;    // You will define this Team class similarly
  Location? location;  // You will define this Location class similarly
  SubscriptionType? subscriptionType;  // You will define this SubscriptionType class similarly
  String? teamAmount;
  int? time;  // In minutes

  Price({
    this.amount,
    this.event,
    this.team,
    this.location,
    this.subscriptionType,
    this.teamAmount,
    this.time,
  });
}