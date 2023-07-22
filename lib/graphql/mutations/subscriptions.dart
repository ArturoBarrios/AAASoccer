import '../fragments/subscription_fragments.dart';

class SubscriptionMutations {
  String createSubscriptionType(
      Map<String, dynamic> subscriptionInput) {    
    // var teamAmount = priceInput.containsKey('teamAmount') ? priceInput['teamAmount'] : "0";
    String createSubscriptionString = """
      mutation {
        createSubscriptionType(data: {                       
          name: "${subscriptionInput['name']}",      
          description: "${subscriptionInput['description']}",      
          price: {
            create: {
              amount: "${subscriptionInput['price']}",
            }
          },    
          lengths: "${subscriptionInput['lengths']}",  
        }                      
        ){
          ${SubscriptionFragments().subscriptionTypeObject()}                 				                    				  
          }
        }
        """;

    return createSubscriptionString;
  }
  
  String createSubscriptionTypeUser(
      Map<String, dynamic> subscriptionInput) {    
    // var teamAmount = priceInput.containsKey('teamAmount') ? priceInput['teamAmount'] : "0";
    String createSubscriptionTypeUserString = """
      mutation {
        createSubscriptionTypeUser(data: {                                 
          length: 30,
          subscriptionType: {
            connect: "${subscriptionInput['subscription_type_id']}"
          },
          user: {
            connect: "${subscriptionInput['user_id']}"
          }
        }                      
        ){
          ${SubscriptionFragments().subscriptionTypeUserObject()}                 				                    				  
          }
        }
        """;

    return createSubscriptionTypeUserString;
  }


}
