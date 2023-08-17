import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../enums/PaymentType.dart';

class PaymentModel extends ChangeNotifier {
  PaymentType _status = PaymentType.initial;
  PaymentType get status => _status;
  set status(PaymentType status) {
    _status = status;
    notifyListeners();
  }

  CardFieldInputDetails _cardFieldInputDetails =
      const CardFieldInputDetails(complete: false);
  CardFieldInputDetails get cardFieldInputDetails => _cardFieldInputDetails;
  set cardFieldInputDetails(CardFieldInputDetails cardFieldInputDetails) {
    _cardFieldInputDetails = cardFieldInputDetails;
    notifyListeners();
  }
}
