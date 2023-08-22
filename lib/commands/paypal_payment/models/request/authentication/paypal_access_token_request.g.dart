// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paypal_access_token_request.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaypalAccessTokenRequest _$$_PaypalAccessTokenRequestFromJson(
        Map<String, dynamic> json) =>
    _$_PaypalAccessTokenRequest(
      grantType: json['grant_type'] as String? ?? 'client_credentials',
    );

Map<String, dynamic> _$$_PaypalAccessTokenRequestToJson(
        _$_PaypalAccessTokenRequest instance) =>
    <String, dynamic>{
      'grant_type': instance.grantType,
    };
