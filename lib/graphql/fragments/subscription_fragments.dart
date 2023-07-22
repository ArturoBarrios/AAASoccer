class SubscriptionFragments{

  String subscriptionTypeObject(){
     String subscriptionTypeString = r'''      
        	_id
          name
          description
          price{
            amount
          }
          lengths              
    ''';

    return subscriptionTypeString;

  }
  
  String subscriptionTypeUserObject(){
     String subscriptionTypeString = r'''      
        	_id
          startDate
          endDate
          length
          subscriptionType{
            _id
            name
          }
          user{
            _id
            name
          }
            
    ''';

    return subscriptionTypeString;

  }
}