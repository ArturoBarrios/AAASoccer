import '../fragments/price_fragments.dart';

class PriceMutations {
  String updatePrice(
      Map<String, dynamic> priceInput) {    
    String updatePrice = """
      mutation {
        updatePrice(
          priceId: "${priceInput['_id']}",  				                   
            amount: "${priceInput['amount']}",                             
        ){
          code
          success
          message
          price{
            ${PriceFragments().fullPrice()}                 				                    				  
          }
          }
        }
        """;

    return updatePrice;
  }
}
