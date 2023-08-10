import 'dart:io';

import 'package:flutter/material.dart';
import 'package:pay/pay.dart' as payment;

import '../../payment_configurations.dart';

class AppleGooglePaymentButton extends StatelessWidget {
  final Function(Map<String, dynamic>?)? paymentResult;
  final dynamic item;
  const AppleGooglePaymentButton({Key? key, this.paymentResult, this.item})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Platform.isIOS
        ? payment.ApplePayButton(
            paymentConfiguration:
                payment.PaymentConfiguration.fromJsonString(defaultApplePay),
            paymentItems: [
              payment.PaymentItem(
                type: payment.PaymentItemType.item,
                label: item['objectToPurchase']['name'],
                amount: item['price']['amount'],
                status: payment.PaymentItemStatus.final_price,
              )
            ],
            type: payment.ApplePayButtonType.buy,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: (final result) => paymentResult?.call(result),
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          )
        : payment.GooglePayButton(
            paymentConfiguration:
                payment.PaymentConfiguration.fromJsonString(defaultGooglePay),
            paymentItems: [
              payment.PaymentItem(
                type: payment.PaymentItemType.item,
                label: item['objectToPurchase']['name'],
                amount: item['price']['amount'],
                status: payment.PaymentItemStatus.final_price,
              )
            ],
            type: payment.GooglePayButtonType.buy,
            margin: const EdgeInsets.only(top: 15.0),
            onPaymentResult: (final result) => paymentResult?.call(result),
            loadingIndicator: const Center(
              child: CircularProgressIndicator(),
            ),
          );
  }
}
