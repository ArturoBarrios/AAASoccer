// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'paypal_access_token_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PaypalAccessTokenResponse _$$_PaypalAccessTokenResponseFromJson(
        Map<String, dynamic> json) =>
    _$_PaypalAccessTokenResponse(
      scope: json['scope'] as String?,
      accessToken: json['access_token'] as String?,
      tokenType: json['token_type'] as String?,
      appId: json['app_id'] as String?,
      expiresIn: json['expires_in'] as int?,
      supportedAuthnSchemes: (json['supported_authn_schemes'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      nonce: json['nonce'] as String?,
      clientMetadata: json['client_metadata'] == null
          ? null
          : ClientMetadata.fromJson(
              json['client_metadata'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PaypalAccessTokenResponseToJson(
        _$_PaypalAccessTokenResponse instance) =>
    <String, dynamic>{
      'scope': instance.scope,
      'access_token': instance.accessToken,
      'token_type': instance.tokenType,
      'app_id': instance.appId,
      'expires_in': instance.expiresIn,
      'supported_authn_schemes': instance.supportedAuthnSchemes,
      'nonce': instance.nonce,
      'client_metadata': instance.clientMetadata,
    };

_$_ClientMetadata _$$_ClientMetadataFromJson(Map<String, dynamic> json) =>
    _$_ClientMetadata(
      name: json['name'] as String?,
      displayName: json['display_name'] as String?,
      logoUri: json['logo_uri'] as String?,
      scopes:
          (json['scopes'] as List<dynamic>?)?.map((e) => e as String).toList(),
      uiType: json['ui_type'] as String?,
    );

Map<String, dynamic> _$$_ClientMetadataToJson(_$_ClientMetadata instance) =>
    <String, dynamic>{
      'name': instance.name,
      'display_name': instance.displayName,
      'logo_uri': instance.logoUri,
      'scopes': instance.scopes,
      'ui_type': instance.uiType,
    };
