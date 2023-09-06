import 'User.dart';

class SubscriptionTypeUser {
  SubscriptionType? subscriptionType;
  User? user;
  String? startDate;
  String? endDate;
  int? length;

  SubscriptionTypeUser({
    this.subscriptionType,
    this.user,
    this.startDate,
    this.endDate,
    this.length,
  });
}