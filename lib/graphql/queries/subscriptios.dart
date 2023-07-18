import '../fragments/subscription_fragments.dart';

class SubscriptionQueries {   
   String getSubscriptions() {
    String getSubscriptions = """
          query getSubscriptions {
            allSubscriptionTypes {
              data {      
               ${SubscriptionFragments().subscriptionObject()}  

                    
                  }
                }
              }
          """;

    return getSubscriptions;
  }

}