import '../fragments/subscription_fragments.dart';

class SubscriptionQueries {   
   String getSubscriptionTypes() {
    String getSubscriptionTypes = """
          query getSubscriptionTypes {
            allSubscriptionTypes {
              data {      
               ${SubscriptionFragments().subscriptionObject()}  

                    
                  }
                }
              }
          """;

    return getSubscriptionTypes;
  }

}