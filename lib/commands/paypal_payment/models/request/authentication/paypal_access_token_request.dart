// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'paypal_access_token_request.freezed.dart';
part 'paypal_access_token_request.g.dart';

@freezed
class PaypalAccessTokenRequest with _$PaypalAccessTokenRequest {
  const factory PaypalAccessTokenRequest({
    @Default('client_credentials')
    @JsonKey(name: 'grant_type')
        String? grantType,
  }) = _PaypalAccessTokenRequest;

  factory PaypalAccessTokenRequest.fromJson(Map<String, Object?> json) =>
      _$PaypalAccessTokenRequestFromJson(json);
}
