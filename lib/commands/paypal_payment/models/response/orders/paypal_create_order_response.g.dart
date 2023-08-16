// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paypal_create_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaypalCreateOrderResponse _$$_PaypalCreateOrderResponseFromJson(
        Map<String, dynamic> json) =>
    _$_PaypalCreateOrderResponse(
      id: json['id'] as String?,
      intent: json['intent'] as String?,
      status: json['status'] as String?,
      purchaseUnits: (json['purchase_units'] as List<dynamic>?)
          ?.map((e) => PurchaseUnits.fromJson(e as Map<String, dynamic>))
          .toList(),
      createTime: json['create_time'] as String?,
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Links.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PaypalCreateOrderResponseToJson(
        _$_PaypalCreateOrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'intent': instance.intent,
      'status': instance.status,
      'purchase_units': instance.purchaseUnits,
      'create_time': instance.createTime,
      'links': instance.links,
    };

_$_PurchaseUnits _$$_PurchaseUnitsFromJson(Map<String, dynamic> json) =>
    _$_PurchaseUnits(
      referenceId: json['reference_id'] as String?,
      amount: json['amount'] == null
          ? null
          : Amount.fromJson(json['amount'] as Map<String, dynamic>),
      payee: json['payee'] == null
          ? null
          : Payee.fromJson(json['payee'] as Map<String, dynamic>),
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PurchaseUnitsToJson(_$_PurchaseUnits instance) =>
    <String, dynamic>{
      'reference_id': instance.referenceId,
      'amount': instance.amount,
      'payee': instance.payee,
      'items': instance.items,
    };

_$_Amount _$$_AmountFromJson(Map<String, dynamic> json) => _$_Amount(
      currencyCode: json['currency_code'] as String? ?? 'USD',
      value: json['value'] as String?,
      breakdown: json['breakdown'] == null
          ? null
          : Breakdown.fromJson(json['breakdown'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AmountToJson(_$_Amount instance) => <String, dynamic>{
      'currency_code': instance.currencyCode,
      'value': instance.value,
      'breakdown': instance.breakdown,
    };

_$_Breakdown _$$_BreakdownFromJson(Map<String, dynamic> json) => _$_Breakdown(
      itemTotal: json['item_total'] == null
          ? null
          : ItemTotal.fromJson(json['item_total'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_BreakdownToJson(_$_Breakdown instance) =>
    <String, dynamic>{
      'item_total': instance.itemTotal,
    };

_$_ItemTotal _$$_ItemTotalFromJson(Map<String, dynamic> json) => _$_ItemTotal(
      currencyCode: json['currency_code'] as String? ?? 'USD',
      value: json['value'] as String?,
    );

Map<String, dynamic> _$$_ItemTotalToJson(_$_ItemTotal instance) =>
    <String, dynamic>{
      'currency_code': instance.currencyCode,
      'value': instance.value,
    };

_$_Payee _$$_PayeeFromJson(Map<String, dynamic> json) => _$_Payee(
      emailAddress: json['email_address'] as String?,
      merchantId: json['merchant_id'] as String?,
    );

Map<String, dynamic> _$$_PayeeToJson(_$_Payee instance) => <String, dynamic>{
      'email_address': instance.emailAddress,
      'merchant_id': instance.merchantId,
    };

_$_Items _$$_ItemsFromJson(Map<String, dynamic> json) => _$_Items(
      name: json['name'] as String?,
      unitAmount: json['unit_amount'] == null
          ? null
          : UnitAmount.fromJson(json['unit_amount'] as Map<String, dynamic>),
      quantity: json['quantity'] as String?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$$_ItemsToJson(_$_Items instance) => <String, dynamic>{
      'name': instance.name,
      'unit_amount': instance.unitAmount,
      'quantity': instance.quantity,
      'description': instance.description,
    };

_$_UnitAmount _$$_UnitAmountFromJson(Map<String, dynamic> json) =>
    _$_UnitAmount(
      currencyCode: json['currency_code'] as String? ?? 'USD',
      value: json['value'] as String?,
    );

Map<String, dynamic> _$$_UnitAmountToJson(_$_UnitAmount instance) =>
    <String, dynamic>{
      'currency_code': instance.currencyCode,
      'value': instance.value,
    };

_$_Links _$$_LinksFromJson(Map<String, dynamic> json) => _$_Links(
      href: json['href'] as String?,
      rel: json['rel'] as String?,
      method: json['method'] as String?,
    );

Map<String, dynamic> _$$_LinksToJson(_$_Links instance) => <String, dynamic>{
      'href': instance.href,
      'rel': instance.rel,
      'method': instance.method,
    };
