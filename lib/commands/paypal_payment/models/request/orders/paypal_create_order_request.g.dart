// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paypal_create_order_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaypalCreateOrderRequest _$$_PaypalCreateOrderRequestFromJson(
        Map<String, dynamic> json) =>
    _$_PaypalCreateOrderRequest(
      intent: json['intent'] as String? ?? 'CAPTURE',
      purchaseUnits: (json['purchase_units'] as List<dynamic>?)
          ?.map((e) => PurchaseUnitsRequest.fromJson(e as Map<String, dynamic>))
          .toList(),
      applicationContext: json['application_context'] == null
          ? null
          : ApplicationContext.fromJson(
              json['application_context'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PaypalCreateOrderRequestToJson(
    _$_PaypalCreateOrderRequest instance) {
  final val = <String, dynamic>{
    'intent': instance.intent,
    'purchase_units': instance.purchaseUnits,
  };

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('application_context', instance.applicationContext);
  return val;
}

_$_PurchaseUnitsRequest _$$_PurchaseUnitsRequestFromJson(
        Map<String, dynamic> json) =>
    _$_PurchaseUnitsRequest(
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      amount: json['amount'] == null
          ? null
          : Amount.fromJson(json['amount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PurchaseUnitsRequestToJson(
        _$_PurchaseUnitsRequest instance) =>
    <String, dynamic>{
      'items': instance.items,
      'amount': instance.amount,
    };

_$_ApplicationContext _$$_ApplicationContextFromJson(
        Map<String, dynamic> json) =>
    _$_ApplicationContext(
      returnUrl: json['return_url'] as String? ?? 'https://example.com/return',
      cancelUrl: json['cancel_url'] as String? ?? 'https://example.com/cancel',
    );

Map<String, dynamic> _$$_ApplicationContextToJson(
        _$_ApplicationContext instance) =>
    <String, dynamic>{
      'return_url': instance.returnUrl,
      'cancel_url': instance.cancelUrl,
    };
