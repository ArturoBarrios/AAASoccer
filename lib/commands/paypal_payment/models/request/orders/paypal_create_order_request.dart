// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import '../../response/orders/paypal_create_order_response.dart';
part 'paypal_create_order_request.freezed.dart';
part 'paypal_create_order_request.g.dart';

@freezed
class PaypalCreateOrderRequest with _$PaypalCreateOrderRequest {
  const factory PaypalCreateOrderRequest({
    @Default('CAPTURE') String? intent,
    @JsonKey(name: 'purchase_units') List<PurchaseUnitsRequest>? purchaseUnits,
    @JsonKey(name: 'application_context', includeIfNull: false)
        ApplicationContext? applicationContext,
  }) = _PaypalCreateOrderRequest;

  factory PaypalCreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$PaypalCreateOrderRequestFromJson(json);
}

@freezed
class PurchaseUnitsRequest with _$PurchaseUnitsRequest {
  const factory PurchaseUnitsRequest({
    List<Items>? items,
    Amount? amount,
  }) = _PurchaseUnitsRequest;

  factory PurchaseUnitsRequest.fromJson(Map<String, dynamic> json) =>
      _$PurchaseUnitsRequestFromJson(json);
}

@freezed
class ApplicationContext with _$ApplicationContext {
  const factory ApplicationContext({
    @Default('https://example.com/return')
    @JsonKey(name: 'return_url')
        String? returnUrl,
    @Default('https://example.com/cancel')
    @JsonKey(name: 'cancel_url')
        String? cancelUrl,
  }) = _ApplicationContext;

  factory ApplicationContext.fromJson(Map<String, dynamic> json) =>
      _$ApplicationContextFromJson(json);
}
