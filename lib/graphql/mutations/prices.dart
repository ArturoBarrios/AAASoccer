import '../fragments/price_fragments.dart';

class PriceMutations {
  String updatePrice(
      Map<String, dynamic> priceInput) {    
    String updatePrice = """
      mutation {
        updatePrice(
          pricesId: ${priceInput['_id']},
  				data: {                       
            amount: "${priceInput['amount']}",                   
          }                      
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
