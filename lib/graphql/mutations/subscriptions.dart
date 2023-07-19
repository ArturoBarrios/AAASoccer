import '../fragments/subscription_fragments.dart';

class SubscriptionMutations {
  String createSubscription(
      Map<String, dynamic> subscriptionInput) {    
    // var teamAmount = priceInput.containsKey('teamAmount') ? priceInput['teamAmount'] : "0";
    String createSubscriptionString = """
      mutation {
        createSubscriptionType(data: {                       
          name: "${subscriptionInput['name']}",      
          description: "${subscriptionInput['description']}",      
          price: "${subscriptionInput['price']}",    
          lengths: ${subscriptionInput['lengths']},  
        }                      
        ){
          ${SubscriptionFragments().subscriptionObject()}                 				                    				  
          }
        }
        """;

    return createSubscriptionString;
  }
}
