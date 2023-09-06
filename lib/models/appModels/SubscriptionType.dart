import 'Price.dart';

class SubscriptionType {
  String? name;
  String? description;
  Price? price;
  String? lengths;
  List<SubscriptionTypeUser>? subscriptions;

  SubscriptionType({
    this.name,
    this.description,
    this.price,
    this.lengths,
    this.subscriptions,
  });
}