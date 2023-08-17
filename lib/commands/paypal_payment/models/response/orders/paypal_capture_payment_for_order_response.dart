// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'paypal_capture_payment_for_order_response.freezed.dart';
part 'paypal_capture_payment_for_order_response.g.dart';

@freezed
class PaypalCapturePaymentForOrderResponse
    with _$PaypalCapturePaymentForOrderResponse {
  const factory PaypalCapturePaymentForOrderResponse({
    String? id,
    String? intent,
    String? status,
    @JsonKey(name: 'payment_source') PaymentSource? paymentSource,
    @JsonKey(name: 'purchase_units') List<PurchaseUnits>? purchaseUnits,
    Payer? payer,
    @JsonKey(name: 'create_time') String? createTime,
    @JsonKey(name: 'update_time') String? updateTime,
    List<Links>? links,
  }) = _PaypalCapturePaymentForOrderResponse;

  factory PaypalCapturePaymentForOrderResponse.fromJson(
          Map<String, Object?> json) =>
      _$PaypalCapturePaymentForOrderResponseFromJson(json);
}

@freezed
class PaymentSource with _$PaymentSource {
  const factory PaymentSource({
    Paypal? paypal,
  }) = _PaymentSource;

  factory PaymentSource.fromJson(Map<String, Object?> json) =>
      _$PaymentSourceFromJson(json);
}

@freezed
class Paypal with _$Paypal {
  const factory Paypal({
    @JsonKey(name: 'email_address') String? emailAddress,
    @JsonKey(name: 'account_id') String? accountId,
    @JsonKey(name: 'account_status') String? accountStatus,
    Name? name,
    CountryCode? address,
  }) = _Paypal;

  factory Paypal.fromJson(Map<String, Object?> json) => _$PaypalFromJson(json);
}

@freezed
class Name with _$Name {
  const factory Name({
    @JsonKey(name: 'given_name') String? givenName,
    String? surname,
  }) = _Name;

  factory Name.fromJson(Map<String, Object?> json) => _$NameFromJson(json);
}

@freezed
class CountryCode with _$CountryCode {
  const factory CountryCode({
    @JsonKey(name: 'country_code') String? countryCode,
  }) = _CountryCode;

  factory CountryCode.fromJson(Map<String, Object?> json) =>
      _$CountryCodeFromJson(json);
}

@freezed
class PurchaseUnits with _$PurchaseUnits {
  const factory PurchaseUnits({
    @JsonKey(name: 'reference_id') String? referenceId,
    Amount? amount,
    Payee? payee,
    String? description,
    List<Items>? items,
    ShippingAddress? shipping,
    Payments? payments,
  }) = _PurchaseUnits;

  factory PurchaseUnits.fromJson(Map<String, Object?> json) =>
      _$PurchaseUnitsFromJson(json);
}

@freezed
class Amount with _$Amount {
  const factory Amount({
    @JsonKey(name: 'currency_code') String? currencyCode,
    String? value,
    Breakdown? breakdown,
  }) = _Amount;

  factory Amount.fromJson(Map<String, Object?> json) => _$AmountFromJson(json);
}

@freezed
class Breakdown with _$Breakdown {
  const factory Breakdown({
    @JsonKey(name: 'item_total') CurrencyCodeWithValue? itemTotal,
    CurrencyCodeWithValue? shipping,
    CurrencyCodeWithValue? handling,
    CurrencyCodeWithValue? insurance,
    @JsonKey(name: 'shipping_discount') CurrencyCodeWithValue? shippingDiscount,
  }) = _Breakdown;

  factory Breakdown.fromJson(Map<String, Object?> json) =>
      _$BreakdownFromJson(json);
}

@freezed
class CurrencyCodeWithValue with _$CurrencyCodeWithValue {
  const factory CurrencyCodeWithValue({
    @JsonKey(name: 'currency_code') String? currencyCode,
    String? value,
  }) = _CurrencyCodeWithValue;

  factory CurrencyCodeWithValue.fromJson(Map<String, Object?> json) =>
      _$CurrencyCodeWithValueFromJson(json);
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
    @JsonKey(name: 'unit_amount') CurrencyCodeWithValue? unitAmount,
    CurrencyCodeWithValue? tax,
    String? quantity,
    String? description,
    @JsonKey(name: 'image_url') String? imageUrl,
  }) = _Items;

  factory Items.fromJson(Map<String, Object?> json) => _$ItemsFromJson(json);
}

@freezed
class ShippingAddress with _$ShippingAddress {
  const factory ShippingAddress({
    Name? name,
    ShippingAddressFull? address,
  }) = _ShippingAddress;

  factory ShippingAddress.fromJson(Map<String, Object?> json) =>
      _$ShippingAddressFromJson(json);
}

@freezed
class ShippingAddressFull with _$ShippingAddressFull {
  const factory ShippingAddressFull({
    @JsonKey(name: 'address_line_1') String? addressLine1,
    @JsonKey(name: 'admin_area_2') String? adminArea2,
    @JsonKey(name: 'admin_area_1') String? adminArea1,
    @JsonKey(name: 'postal_code') String? postalCode,
    @JsonKey(name: 'country_code') String? countryCode,
  }) = _ShippingAddressFull;

  factory ShippingAddressFull.fromJson(Map<String, Object?> json) =>
      _$ShippingAddressFullFromJson(json);
}

@freezed
class Payments with _$Payments {
  const factory Payments({
    List<Captures>? captures,
  }) = _Payments;

  factory Payments.fromJson(Map<String, Object?> json) =>
      _$PaymentsFromJson(json);
}

@freezed
class Captures with _$Captures {
  const factory Captures({
    String? id,
    String? status,
    Amount? amount,
    @JsonKey(name: 'final_capture') bool? finalCapture,
    @JsonKey(name: 'seller_protection') SellerProtection? sellerProtection,
    @JsonKey(name: 'seller_receivable_breakdown')
        SellerReceivableBreakdown? sellerReceivableBreakdown,
    List<Links>? links,
    @JsonKey(name: 'create_time') String? createTime,
    @JsonKey(name: 'update_time') String? updateTime,
  }) = _Captures;

  factory Captures.fromJson(Map<String, Object?> json) =>
      _$CapturesFromJson(json);
}

@freezed
class SellerProtection with _$SellerProtection {
  const factory SellerProtection({
    String? status,
    @JsonKey(name: 'dispute_categories') List<String>? disputeCategories,
  }) = _SellerProtection;

  factory SellerProtection.fromJson(Map<String, Object?> json) =>
      _$SellerProtectionFromJson(json);
}

@freezed
class SellerReceivableBreakdown with _$SellerReceivableBreakdown {
  const factory SellerReceivableBreakdown({
    @JsonKey(name: 'gross_amount') CurrencyCodeWithValue? grossAmount,
    @JsonKey(name: 'paypal_fee') CurrencyCodeWithValue? paypalFee,
    @JsonKey(name: 'net_amount') CurrencyCodeWithValue? netAmount,
  }) = _SellerReceivableBreakdown;

  factory SellerReceivableBreakdown.fromJson(Map<String, Object?> json) =>
      _$SellerReceivableBreakdownFromJson(json);
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

@freezed
class Payer with _$Payer {
  const factory Payer({
    Name? name,
    @JsonKey(name: 'email_address') String? emailAddress,
    @JsonKey(name: 'payer_id') String? payerId,
    CountryCode? address,
  }) = _Payer;

  factory Payer.fromJson(Map<String, Object?> json) => _$PayerFromJson(json);
}
