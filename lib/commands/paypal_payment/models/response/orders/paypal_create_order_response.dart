// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

part 'paypal_create_order_response.freezed.dart';
part 'paypal_create_order_response.g.dart';

@freezed
class PaypalCreateOrderResponse with _$PaypalCreateOrderResponse {
  const factory PaypalCreateOrderResponse({
    String? id,
    String? intent,
    String? status,
    @JsonKey(name: 'purchase_units') List<PurchaseUnits>? purchaseUnits,
    @JsonKey(name: 'create_time') String? createTime,
    List<Links>? links,
  }) = _PaypalCreateOrderResponse;

  factory PaypalCreateOrderResponse.fromJson(Map<String, Object?> json) =>
      _$PaypalCreateOrderResponseFromJson(json);
}

@freezed
class PurchaseUnits with _$PurchaseUnits {
  const factory PurchaseUnits({
    @JsonKey(name: 'reference_id') String? referenceId,
    Amount? amount,
    Payee? payee,
    List<Items>? items,
  }) = _PurchaseUnits;

  factory PurchaseUnits.fromJson(Map<String, Object?> json) =>
      _$PurchaseUnitsFromJson(json);
}

@freezed
class Amount with _$Amount {
  const factory Amount({
    @Default('USD') @JsonKey(name: 'currency_code') String? currencyCode,
    String? value,
    Breakdown? breakdown,
  }) = _Amount;

  factory Amount.fromJson(Map<String, Object?> json) => _$AmountFromJson(json);
}

@freezed
class Breakdown with _$Breakdown {
  const factory Breakdown({
    @JsonKey(name: 'item_total') ItemTotal? itemTotal,
  }) = _Breakdown;

  factory Breakdown.fromJson(Map<String, Object?> json) =>
      _$BreakdownFromJson(json);
}

@freezed
class ItemTotal with _$ItemTotal {
  const factory ItemTotal({
    @Default('USD') @JsonKey(name: 'currency_code') String? currencyCode,
    String? value,
  }) = _ItemTotal;

  factory ItemTotal.fromJson(Map<String, Object?> json) =>
      _$ItemTotalFromJson(json);
}

@freezed
class Payee with _$Payee {
  const factory Payee({
    @JsonKey(name: 'email_address') String? emailAddress,
    @JsonKey(name: 'merchant_id') String? merchantId,
  }) = _Payee;

  factory Payee.fromJson(Map<String, Object?> json) => _$PayeeFromJson(json);
}

@freezed
class Items with _$Items {
  const factory Items({
    String? name,
    @JsonKey(name: 'unit_amount') UnitAmount? unitAmount,
    String? quantity,
    String? description,
  }) = _Items;

  factory Items.fromJson(Map<String, Object?> json) => _$ItemsFromJson(json);
}

@freezed
class UnitAmount with _$UnitAmount {
  const factory UnitAmount({
    @Default('USD') @JsonKey(name: 'currency_code') String? currencyCode,
    String? value,
  }) = _UnitAmount;

  factory UnitAmount.fromJson(Map<String, Object?> json) =>
      _$UnitAmountFromJson(json);
}

@freezed
class Links with _$Links {
  const factory Links({
    String? href,
    String? rel,
    String? method,
  }) = _Links;

  factory Links.fromJson(Map<String, Object?> json) => _$LinksFromJson(json);
}
