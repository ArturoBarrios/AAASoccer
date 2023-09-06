class Payment {
  String? amount;
  Event? event;
  Team? team;
  String? paidAt;
  User? user;
  bool? isPlayerPayment;
  bool? isTeamPayment;

  Payment({
    this.amount,
    this.event,
    this.team,
    this.paidAt,
    this.user,
    this.isPlayerPayment,
    this.isTeamPayment,
  });
}
