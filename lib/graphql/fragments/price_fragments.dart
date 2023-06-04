class PriceFragments{

  String fullPrice(){
     String priceObject = r'''      
        	_id
          amount          
          teamAmount
          event{
            _id
            name            
          }
          team{
            _id
            name
          }                        
    ''';

    return priceObject;

  }
}








