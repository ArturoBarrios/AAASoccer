// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paypal_capture_payment_for_order_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaypalCapturePaymentForOrderResponse
    _$$_PaypalCapturePaymentForOrderResponseFromJson(
            Map<String, dynamic> json) =>
        _$_PaypalCapturePaymentForOrderResponse(
          id: json['id'] as String?,
          intent: json['intent'] as String?,
          status: json['status'] as String?,
          paymentSource: json['payment_source'] == null
              ? null
              : PaymentSource.fromJson(
                  json['payment_source'] as Map<String, dynamic>),
          purchaseUnits: (json['purchase_units'] as List<dynamic>?)
              ?.map((e) => PurchaseUnits.fromJson(e as Map<String, dynamic>))
              .toList(),
          payer: json['payer'] == null
              ? null
              : Payer.fromJson(json['payer'] as Map<String, dynamic>),
          createTime: json['create_time'] as String?,
          updateTime: json['update_time'] as String?,
          links: (json['links'] as List<dynamic>?)
              ?.map((e) => Links.fromJson(e as Map<String, dynamic>))
              .toList(),
        );

Map<String, dynamic> _$$_PaypalCapturePaymentForOrderResponseToJson(
        _$_PaypalCapturePaymentForOrderResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'intent': instance.intent,
      'status': instance.status,
      'payment_source': instance.paymentSource,
      'purchase_units': instance.purchaseUnits,
      'payer': instance.payer,
      'create_time': instance.createTime,
      'update_time': instance.updateTime,
      'links': instance.links,
    };

_$_PaymentSource _$$_PaymentSourceFromJson(Map<String, dynamic> json) =>
    _$_PaymentSource(
      paypal: json['paypal'] == null
          ? null
          : Paypal.fromJson(json['paypal'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PaymentSourceToJson(_$_PaymentSource instance) =>
    <String, dynamic>{
      'paypal': instance.paypal,
    };

_$_Paypal _$$_PaypalFromJson(Map<String, dynamic> json) => _$_Paypal(
      emailAddress: json['email_address'] as String?,
      accountId: json['account_id'] as String?,
      accountStatus: json['account_status'] as String?,
      name: json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : CountryCode.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PaypalToJson(_$_Paypal instance) => <String, dynamic>{
      'email_address': instance.emailAddress,
      'account_id': instance.accountId,
      'account_status': instance.accountStatus,
      'name': instance.name,
      'address': instance.address,
    };

_$_Name _$$_NameFromJson(Map<String, dynamic> json) => _$_Name(
      givenName: json['given_name'] as String?,
      surname: json['surname'] as String?,
    );

Map<String, dynamic> _$$_NameToJson(_$_Name instance) => <String, dynamic>{
      'given_name': instance.givenName,
      'surname': instance.surname,
    };

_$_CountryCode _$$_CountryCodeFromJson(Map<String, dynamic> json) =>
    _$_CountryCode(
      countryCode: json['country_code'] as String?,
    );

Map<String, dynamic> _$$_CountryCodeToJson(_$_CountryCode instance) =>
    <String, dynamic>{
      'country_code': instance.countryCode,
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
      description: json['description'] as String?,
      items: (json['items'] as List<dynamic>?)
          ?.map((e) => Items.fromJson(e as Map<String, dynamic>))
          .toList(),
      shipping: json['shipping'] == null
          ? null
          : ShippingAddress.fromJson(json['shipping'] as Map<String, dynamic>),
      payments: json['payments'] == null
          ? null
          : Payments.fromJson(json['payments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PurchaseUnitsToJson(_$_PurchaseUnits instance) =>
    <String, dynamic>{
      'reference_id': instance.referenceId,
      'amount': instance.amount,
      'payee': instance.payee,
      'description': instance.description,
      'items': instance.items,
      'shipping': instance.shipping,
      'payments': instance.payments,
    };

_$_Amount _$$_AmountFromJson(Map<String, dynamic> json) => _$_Amount(
      currencyCode: json['currency_code'] as String?,
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
          : CurrencyCodeWithValue.fromJson(
              json['item_total'] as Map<String, dynamic>),
      shipping: json['shipping'] == null
          ? null
          : CurrencyCodeWithValue.fromJson(
              json['shipping'] as Map<String, dynamic>),
      handling: json['handling'] == null
          ? null
          : CurrencyCodeWithValue.fromJson(
              json['handling'] as Map<String, dynamic>),
      insurance: json['insurance'] == null
          ? null
          : CurrencyCodeWithValue.fromJson(
              json['insurance'] as Map<String, dynamic>),
      shippingDiscount: json['shipping_discount'] == null
          ? null
          : CurrencyCodeWithValue.fromJson(
              json['shipping_discount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_BreakdownToJson(_$_Breakdown instance) =>
    <String, dynamic>{
      'item_total': instance.itemTotal,
      'shipping': instance.shipping,
      'handling': instance.handling,
      'insurance': instance.insurance,
      'shipping_discount': instance.shippingDiscount,
    };

_$_CurrencyCodeWithValue _$$_CurrencyCodeWithValueFromJson(
        Map<String, dynamic> json) =>
    _$_CurrencyCodeWithValue(
      currencyCode: json['currency_code'] as String?,
      value: json['value'] as String?,
    );

Map<String, dynamic> _$$_CurrencyCodeWithValueToJson(
        _$_CurrencyCodeWithValue instance) =>
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
          : CurrencyCodeWithValue.fromJson(
              json['unit_amount'] as Map<String, dynamic>),
      tax: json['tax'] == null
          ? null
          : CurrencyCodeWithValue.fromJson(json['tax'] as Map<String, dynamic>),
      quantity: json['quantity'] as String?,
      description: json['description'] as String?,
      imageUrl: json['image_url'] as String?,
    );

Map<String, dynamic> _$$_ItemsToJson(_$_Items instance) => <String, dynamic>{
      'name': instance.name,
      'unit_amount': instance.unitAmount,
      'tax': instance.tax,
      'quantity': instance.quantity,
      'description': instance.description,
      'image_url': instance.imageUrl,
    };

_$_ShippingAddress _$$_ShippingAddressFromJson(Map<String, dynamic> json) =>
    _$_ShippingAddress(
      name: json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      address: json['address'] == null
          ? null
          : ShippingAddressFull.fromJson(
              json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ShippingAddressToJson(_$_ShippingAddress instance) =>
    <String, dynamic>{
      'name': instance.name,
      'address': instance.address,
    };

_$_ShippingAddressFull _$$_ShippingAddressFullFromJson(
        Map<String, dynamic> json) =>
    _$_ShippingAddressFull(
      addressLine1: json['address_line_1'] as String?,
      adminArea2: json['admin_area_2'] as String?,
      adminArea1: json['admin_area_1'] as String?,
      postalCode: json['postal_code'] as String?,
      countryCode: json['country_code'] as String?,
    );

Map<String, dynamic> _$$_ShippingAddressFullToJson(
        _$_ShippingAddressFull instance) =>
    <String, dynamic>{
      'address_line_1': instance.addressLine1,
      'admin_area_2': instance.adminArea2,
      'admin_area_1': instance.adminArea1,
      'postal_code': instance.postalCode,
      'country_code': instance.countryCode,
    };

_$_Payments _$$_PaymentsFromJson(Map<String, dynamic> json) => _$_Payments(
      captures: (json['captures'] as List<dynamic>?)
          ?.map((e) => Captures.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_PaymentsToJson(_$_Payments instance) =>
    <String, dynamic>{
      'captures': instance.captures,
    };

_$_Captures _$$_CapturesFromJson(Map<String, dynamic> json) => _$_Captures(
      id: json['id'] as String?,
      status: json['status'] as String?,
      amount: json['amount'] == null
          ? null
          : Amount.fromJson(json['amount'] as Map<String, dynamic>),
      finalCapture: json['final_capture'] as bool?,
      sellerProtection: json['seller_protection'] == null
          ? null
          : SellerProtection.fromJson(
              json['seller_protection'] as Map<String, dynamic>),
      sellerReceivableBreakdown: json['seller_receivable_breakdown'] == null
          ? null
          : SellerReceivableBreakdown.fromJson(
              json['seller_receivable_breakdown'] as Map<String, dynamic>),
      links: (json['links'] as List<dynamic>?)
          ?.map((e) => Links.fromJson(e as Map<String, dynamic>))
          .toList(),
      createTime: json['create_time'] as String?,
      updateTime: json['update_time'] as String?,
    );

Map<String, dynamic> _$$_CapturesToJson(_$_Captures instance) =>
    <String, dynamic>{
      'id': instance.id,
      'status': instance.status,
      'amount': instance.amount,
      'final_capture': instance.finalCapture,
      'seller_protection': instance.sellerProtection,
      'seller_receivable_breakdown': instance.sellerReceivableBreakdown,
      'links': instance.links,
      'create_time': instance.createTime,
      'update_time': instance.updateTime,
    };

_$_SellerProtection _$$_SellerProtectionFromJson(Map<String, dynamic> json) =>
    _$_SellerProtection(
      status: json['status'] as String?,
      disputeCategories: (json['dispute_categories'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_SellerProtectionToJson(_$_SellerProtection instance) =>
    <String, dynamic>{
      'status': instance.status,
      'dispute_categories': instance.disputeCategories,
    };

_$_SellerReceivableBreakdown _$$_SellerReceivableBreakdownFromJson(
        Map<String, dynamic> json) =>
    _$_SellerReceivableBreakdown(
      grossAmount: json['gross_amount'] == null
          ? null
          : CurrencyCodeWithValue.fromJson(
              json['gross_amount'] as Map<String, dynamic>),
      paypalFee: json['paypal_fee'] == null
          ? null
          : CurrencyCodeWithValue.fromJson(
              json['paypal_fee'] as Map<String, dynamic>),
      netAmount: json['net_amount'] == null
          ? null
          : CurrencyCodeWithValue.fromJson(
              json['net_amount'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SellerReceivableBreakdownToJson(
        _$_SellerReceivableBreakdown instance) =>
    <String, dynamic>{
      'gross_amount': instance.grossAmount,
      'paypal_fee': instance.paypalFee,
      'net_amount': instance.netAmount,
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

_$_Payer _$$_PayerFromJson(Map<String, dynamic> json) => _$_Payer(
      name: json['name'] == null
          ? null
          : Name.fromJson(json['name'] as Map<String, dynamic>),
      emailAddress: json['email_address'] as String?,
      payerId: json['payer_id'] as String?,
      address: json['address'] == null
          ? null
          : CountryCode.fromJson(json['address'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PayerToJson(_$_Payer instance) => <String, dynamic>{
      'name': instance.name,
      'email_address': instance.emailAddress,
      'payer_id': instance.payerId,
      'address': instance.address,
    };
