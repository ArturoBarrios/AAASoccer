// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'paypal_access_token_response.freezed.dart';
part 'paypal_access_token_response.g.dart';

@freezed
class PaypalAccessTokenResponse with _$PaypalAccessTokenResponse {
  const factory PaypalAccessTokenResponse({
    String? scope,
    @JsonKey(name: 'access_token') String? accessToken,
    @JsonKey(name: 'token_type') String? tokenType,
    @JsonKey(name: 'app_id') String? appId,
    @JsonKey(name: 'expires_in') int? expiresIn,
    @JsonKey(name: 'supported_authn_schemes')
        List<String>? supportedAuthnSchemes,
    String? nonce,
    @JsonKey(name: 'client_metadata') ClientMetadata? clientMetadata,
  }) = _PaypalAccessTokenResponse;

  factory PaypalAccessTokenResponse.fromJson(Map<String, Object?> json) =>
      _$PaypalAccessTokenResponseFromJson(json);
}

@freezed
class ClientMetadata with _$ClientMetadata {
  const factory ClientMetadata({
    String? name,
    @JsonKey(name: 'display_name') String? displayName,
    @JsonKey(name: 'logo_uri') String? logoUri,
    List<String>? scopes,
    @JsonKey(name: 'ui_type') String? uiType,
  }) = _ClientMetadata;

  factory ClientMetadata.fromJson(Map<String, Object?> json) =>
      _$ClientMetadataFromJson(json);
}
