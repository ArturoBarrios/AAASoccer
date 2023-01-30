import 'dart:ffi';

import 'package:flutter/foundation.dart';
import 'package:faunadb_http/faunadb_http.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:graphql_flutter/graphql_flutter.dart';
import 'package:twilio_flutter/twilio_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../enums/PaymentType.dart';

class PaymentModel extends ChangeNotifier {

  PaymentType _status = PaymentType.initial;
  PaymentType get status => _status;
  set status(PaymentType status) {
    _status = status;
    notifyListeners();
  }   
  
  CardFieldInputDetails _cardFieldInputDetails = CardFieldInputDetails(complete: false);
  CardFieldInputDetails get cardFieldInputDetails => _cardFieldInputDetails;
  set cardFieldInputDetails(CardFieldInputDetails cardFieldInputDetails) {
    _cardFieldInputDetails = cardFieldInputDetails;
    notifyListeners();
  }
  

}