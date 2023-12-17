import 'package:flutter/foundation.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import '../enums/payment_status_type.dart';

class PaymentModel extends ChangeNotifier {
  PaymentStatusType _status = PaymentStatusType.initial;
  PaymentStatusType get status => _status;
  set status(PaymentStatusType status) {
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
