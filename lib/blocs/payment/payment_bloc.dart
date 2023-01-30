import 'dart:convert';
import 'package:bloc/bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:http/http.dart' as http;
part 'payment_event.dart';
part 'payment_state.dart';

class PaymentBloc extends Bloc<PaymentEvent, PaymentState> {
  
  PaymentBloc() : super(const PaymentState()){
    on<PaymentStart>(_onPaymentStart);
    on<PaymentCreateIntent>(_onPaymentCreateIntent);
    on<PaymentConfirmIntent>(_onPaymentConfirmIntent); 
  }

  void _onPaymentStart(
    PaymentStart event,
    Emitter<PaymentState> emit,
  ){
    emit(state.copyWith(status: PaymentStatus.initial));
  }

  void _onPaymentCreateIntent(
    PaymentCreateIntent event,
    Emitter<PaymentState> emit
  ) async{
    emit(state.copyWith(status: PaymentStatus.loading));

     final paymentMethod = await Stripe.instance.createPaymentMethod(
     params: PaymentMethodParams.card(
        paymentMethodData: 
          PaymentMethodData(billingDetails: event.billingDetails),
     ),
    );

    final paymentIntentResults = await _callPayEndpointMethodId(
      useStripeSdk: true,
      paymentMethodId: paymentMethod.id,
      currency: 'usd', 
      items: event.items,
    );

    if(paymentIntentResults['error'] != null) {
      emit(state.copyWith(status: PaymentStatus.failure));
    }

    if(paymentIntentResults['clientSecret'] != null &&
      paymentIntentResults['requiresAction'] == null){
      emit(state.copyWith(status: PaymentStatus.success));
    }

    if(paymentIntentResults['clientSecret'] != null &&
      paymentIntentResults['requiresAction'] == true){
        final String clientSecret = paymentIntentResults['clientSecret'];
        add(PaymentConfirmIntent(clientSecret: clientSecret));
      }

  }
  
  void _onPaymentConfirmIntent(
    PaymentConfirmIntent event,
    Emitter<PaymentState> emit,
  ) async {
    try{
      final paymentIntent = await Stripe.instance.handleNextAction(event.clientSecret);

      if(paymentIntent.status == PaymentIntentsStatus.RequiresConfirmation){
        Map<String, dynamic> results = await _callPayEndpointIntentId(
          paymentIntentId: paymentIntent.id,
        );
        if(results['error'] != null){
          emit(state.copyWith(status: PaymentStatus.failure));
        }else{
          emit(state.copyWith(status: PaymentStatus.success));
        }

      }
      
    } catch (e) {
      print("e");
      emit(state.copyWith(status: PaymentStatus.failure));
    }
  }


  Future<Map<String, dynamic>> _callPayEndpointIntentId({
    required String paymentIntentId
  }) async {
    final url = Uri.parse("https://us-central1-soccer-app-a9060.cloudfunctions.net/StripePayEndpointIntentId");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'paymentIntentId': paymentIntentId,
        }
      )
    );
    return json.decode(response.body);
  }

  Future<Map<String, dynamic>> _callPayEndpointMethodId({
    required bool useStripeSdk,
    required String paymentMethodId,
    required String currency,
    required List<Map<String, dynamic>> items,
  }) async {
    final url = Uri.parse("https://us-central1-soccer-app-a9060.cloudfunctions.net/StripePayEndpointMethodId");
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: json.encode(
        {
          'useStripeSdk': useStripeSdk,
          'paymentMethodId': paymentMethodId,
          'currency': currency,
          'items': items,
        }
      )
    );
    return json.decode(response.body);
  }



}