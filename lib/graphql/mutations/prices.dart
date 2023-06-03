import '../fragments/price_fragments.dart';

class PriceMutations {
  String updatePrice(
      Map<String, dynamic> priceInput) {
    var teamAmount = priceInput.containsKey('teamAmount') ? priceInput['teamAmount'] : "0";
    String updatePrice = """
      mutation {
        updatePrice(
          id: ${priceInput['_id']},
  				data: {                       
            amount: "${priceInput['amount']}",  
            teamAmount: "$teamAmount",       
          }                      
        ){
          ${PriceFragments().fullPrice()}                 				                    				  
          }
        }
        """;

    return updatePrice;
  }
}
