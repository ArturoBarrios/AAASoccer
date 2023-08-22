// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paypal_access_token_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaypalAccessTokenResponse _$PaypalAccessTokenResponseFromJson(
    Map<String, dynamic> json) {
  return _PaypalAccessTokenResponse.fromJson(json);
}

/// @nodoc
mixin _$PaypalAccessTokenResponse {
  String? get scope => throw _privateConstructorUsedError;
  @JsonKey(name: 'access_token')
  String? get accessToken => throw _privateConstructorUsedError;
  @JsonKey(name: 'token_type')
  String? get tokenType => throw _privateConstructorUsedError;
  @JsonKey(name: 'app_id')
  String? get appId => throw _privateConstructorUsedError;
  @JsonKey(name: 'expires_in')
  int? get expiresIn => throw _privateConstructorUsedError;
  @JsonKey(name: 'supported_authn_schemes')
  List<String>? get supportedAuthnSchemes => throw _privateConstructorUsedError;
  String? get nonce => throw _privateConstructorUsedError;
  @JsonKey(name: 'client_metadata')
  ClientMetadata? get clientMetadata => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaypalAccessTokenResponseCopyWith<PaypalAccessTokenResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaypalAccessTokenResponseCopyWith<$Res> {
  factory $PaypalAccessTokenResponseCopyWith(PaypalAccessTokenResponse value,
          $Res Function(PaypalAccessTokenResponse) then) =
      _$PaypalAccessTokenResponseCopyWithImpl<$Res, PaypalAccessTokenResponse>;
  @useResult
  $Res call(
      {String? scope,
      @JsonKey(name: 'access_token') String? accessToken,
      @JsonKey(name: 'token_type') String? tokenType,
      @JsonKey(name: 'app_id') String? appId,
      @JsonKey(name: 'expires_in') int? expiresIn,
      @JsonKey(name: 'supported_authn_schemes')
      List<String>? supportedAuthnSchemes,
      String? nonce,
      @JsonKey(name: 'client_metadata') ClientMetadata? clientMetadata});

  $ClientMetadataCopyWith<$Res>? get clientMetadata;
}

/// @nodoc
class _$PaypalAccessTokenResponseCopyWithImpl<$Res,
        $Val extends PaypalAccessTokenResponse>
    implements $PaypalAccessTokenResponseCopyWith<$Res> {
  _$PaypalAccessTokenResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scope = freezed,
    Object? accessToken = freezed,
    Object? tokenType = freezed,
    Object? appId = freezed,
    Object? expiresIn = freezed,
    Object? supportedAuthnSchemes = freezed,
    Object? nonce = freezed,
    Object? clientMetadata = freezed,
  }) {
    return _then(_value.copyWith(
      scope: freezed == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenType: freezed == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      appId: freezed == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      supportedAuthnSchemes: freezed == supportedAuthnSchemes
          ? _value.supportedAuthnSchemes
          : supportedAuthnSchemes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nonce: freezed == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String?,
      clientMetadata: freezed == clientMetadata
          ? _value.clientMetadata
          : clientMetadata // ignore: cast_nullable_to_non_nullable
              as ClientMetadata?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ClientMetadataCopyWith<$Res>? get clientMetadata {
    if (_value.clientMetadata == null) {
      return null;
    }

    return $ClientMetadataCopyWith<$Res>(_value.clientMetadata!, (value) {
      return _then(_value.copyWith(clientMetadata: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PaypalAccessTokenResponseCopyWith<$Res>
    implements $PaypalAccessTokenResponseCopyWith<$Res> {
  factory _$$_PaypalAccessTokenResponseCopyWith(
          _$_PaypalAccessTokenResponse value,
          $Res Function(_$_PaypalAccessTokenResponse) then) =
      __$$_PaypalAccessTokenResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? scope,
      @JsonKey(name: 'access_token') String? accessToken,
      @JsonKey(name: 'token_type') String? tokenType,
      @JsonKey(name: 'app_id') String? appId,
      @JsonKey(name: 'expires_in') int? expiresIn,
      @JsonKey(name: 'supported_authn_schemes')
      List<String>? supportedAuthnSchemes,
      String? nonce,
      @JsonKey(name: 'client_metadata') ClientMetadata? clientMetadata});

  @override
  $ClientMetadataCopyWith<$Res>? get clientMetadata;
}

/// @nodoc
class __$$_PaypalAccessTokenResponseCopyWithImpl<$Res>
    extends _$PaypalAccessTokenResponseCopyWithImpl<$Res,
        _$_PaypalAccessTokenResponse>
    implements _$$_PaypalAccessTokenResponseCopyWith<$Res> {
  __$$_PaypalAccessTokenResponseCopyWithImpl(
      _$_PaypalAccessTokenResponse _value,
      $Res Function(_$_PaypalAccessTokenResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? scope = freezed,
    Object? accessToken = freezed,
    Object? tokenType = freezed,
    Object? appId = freezed,
    Object? expiresIn = freezed,
    Object? supportedAuthnSchemes = freezed,
    Object? nonce = freezed,
    Object? clientMetadata = freezed,
  }) {
    return _then(_$_PaypalAccessTokenResponse(
      scope: freezed == scope
          ? _value.scope
          : scope // ignore: cast_nullable_to_non_nullable
              as String?,
      accessToken: freezed == accessToken
          ? _value.accessToken
          : accessToken // ignore: cast_nullable_to_non_nullable
              as String?,
      tokenType: freezed == tokenType
          ? _value.tokenType
          : tokenType // ignore: cast_nullable_to_non_nullable
              as String?,
      appId: freezed == appId
          ? _value.appId
          : appId // ignore: cast_nullable_to_non_nullable
              as String?,
      expiresIn: freezed == expiresIn
          ? _value.expiresIn
          : expiresIn // ignore: cast_nullable_to_non_nullable
              as int?,
      supportedAuthnSchemes: freezed == supportedAuthnSchemes
          ? _value._supportedAuthnSchemes
          : supportedAuthnSchemes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      nonce: freezed == nonce
          ? _value.nonce
          : nonce // ignore: cast_nullable_to_non_nullable
              as String?,
      clientMetadata: freezed == clientMetadata
          ? _value.clientMetadata
          : clientMetadata // ignore: cast_nullable_to_non_nullable
              as ClientMetadata?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaypalAccessTokenResponse implements _PaypalAccessTokenResponse {
  const _$_PaypalAccessTokenResponse(
      {this.scope,
      @JsonKey(name: 'access_token') this.accessToken,
      @JsonKey(name: 'token_type') this.tokenType,
      @JsonKey(name: 'app_id') this.appId,
      @JsonKey(name: 'expires_in') this.expiresIn,
      @JsonKey(name: 'supported_authn_schemes')
      final List<String>? supportedAuthnSchemes,
      this.nonce,
      @JsonKey(name: 'client_metadata') this.clientMetadata})
      : _supportedAuthnSchemes = supportedAuthnSchemes;

  factory _$_PaypalAccessTokenResponse.fromJson(Map<String, dynamic> json) =>
      _$$_PaypalAccessTokenResponseFromJson(json);

  @override
  final String? scope;
  @override
  @JsonKey(name: 'access_token')
  final String? accessToken;
  @override
  @JsonKey(name: 'token_type')
  final String? tokenType;
  @override
  @JsonKey(name: 'app_id')
  final String? appId;
  @override
  @JsonKey(name: 'expires_in')
  final int? expiresIn;
  final List<String>? _supportedAuthnSchemes;
  @override
  @JsonKey(name: 'supported_authn_schemes')
  List<String>? get supportedAuthnSchemes {
    final value = _supportedAuthnSchemes;
    if (value == null) return null;
    if (_supportedAuthnSchemes is EqualUnmodifiableListView)
      return _supportedAuthnSchemes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? nonce;
  @override
  @JsonKey(name: 'client_metadata')
  final ClientMetadata? clientMetadata;

  @override
  String toString() {
    return 'PaypalAccessTokenResponse(scope: $scope, accessToken: $accessToken, tokenType: $tokenType, appId: $appId, expiresIn: $expiresIn, supportedAuthnSchemes: $supportedAuthnSchemes, nonce: $nonce, clientMetadata: $clientMetadata)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaypalAccessTokenResponse &&
            (identical(other.scope, scope) || other.scope == scope) &&
            (identical(other.accessToken, accessToken) ||
                other.accessToken == accessToken) &&
            (identical(other.tokenType, tokenType) ||
                other.tokenType == tokenType) &&
            (identical(other.appId, appId) || other.appId == appId) &&
            (identical(other.expiresIn, expiresIn) ||
                other.expiresIn == expiresIn) &&
            const DeepCollectionEquality()
                .equals(other._supportedAuthnSchemes, _supportedAuthnSchemes) &&
            (identical(other.nonce, nonce) || other.nonce == nonce) &&
            (identical(other.clientMetadata, clientMetadata) ||
                other.clientMetadata == clientMetadata));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      scope,
      accessToken,
      tokenType,
      appId,
      expiresIn,
      const DeepCollectionEquality().hash(_supportedAuthnSchemes),
      nonce,
      clientMetadata);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaypalAccessTokenResponseCopyWith<_$_PaypalAccessTokenResponse>
      get copyWith => __$$_PaypalAccessTokenResponseCopyWithImpl<
          _$_PaypalAccessTokenResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaypalAccessTokenResponseToJson(
      this,
    );
  }
}

abstract class _PaypalAccessTokenResponse implements PaypalAccessTokenResponse {
  const factory _PaypalAccessTokenResponse(
      {final String? scope,
      @JsonKey(name: 'access_token') final String? accessToken,
      @JsonKey(name: 'token_type') final String? tokenType,
      @JsonKey(name: 'app_id') final String? appId,
      @JsonKey(name: 'expires_in') final int? expiresIn,
      @JsonKey(name: 'supported_authn_schemes')
      final List<String>? supportedAuthnSchemes,
      final String? nonce,
      @JsonKey(name: 'client_metadata')
      final ClientMetadata? clientMetadata}) = _$_PaypalAccessTokenResponse;

  factory _PaypalAccessTokenResponse.fromJson(Map<String, dynamic> json) =
      _$_PaypalAccessTokenResponse.fromJson;

  @override
  String? get scope;
  @override
  @JsonKey(name: 'access_token')
  String? get accessToken;
  @override
  @JsonKey(name: 'token_type')
  String? get tokenType;
  @override
  @JsonKey(name: 'app_id')
  String? get appId;
  @override
  @JsonKey(name: 'expires_in')
  int? get expiresIn;
  @override
  @JsonKey(name: 'supported_authn_schemes')
  List<String>? get supportedAuthnSchemes;
  @override
  String? get nonce;
  @override
  @JsonKey(name: 'client_metadata')
  ClientMetadata? get clientMetadata;
  @override
  @JsonKey(ignore: true)
  _$$_PaypalAccessTokenResponseCopyWith<_$_PaypalAccessTokenResponse>
      get copyWith => throw _privateConstructorUsedError;
}

ClientMetadata _$ClientMetadataFromJson(Map<String, dynamic> json) {
  return _ClientMetadata.fromJson(json);
}

/// @nodoc
mixin _$ClientMetadata {
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'display_name')
  String? get displayName => throw _privateConstructorUsedError;
  @JsonKey(name: 'logo_uri')
  String? get logoUri => throw _privateConstructorUsedError;
  List<String>? get scopes => throw _privateConstructorUsedError;
  @JsonKey(name: 'ui_type')
  String? get uiType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ClientMetadataCopyWith<ClientMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ClientMetadataCopyWith<$Res> {
  factory $ClientMetadataCopyWith(
          ClientMetadata value, $Res Function(ClientMetadata) then) =
      _$ClientMetadataCopyWithImpl<$Res, ClientMetadata>;
  @useResult
  $Res call(
      {String? name,
      @JsonKey(name: 'display_name') String? displayName,
      @JsonKey(name: 'logo_uri') String? logoUri,
      List<String>? scopes,
      @JsonKey(name: 'ui_type') String? uiType});
}

/// @nodoc
class _$ClientMetadataCopyWithImpl<$Res, $Val extends ClientMetadata>
    implements $ClientMetadataCopyWith<$Res> {
  _$ClientMetadataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? displayName = freezed,
    Object? logoUri = freezed,
    Object? scopes = freezed,
    Object? uiType = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUri: freezed == logoUri
          ? _value.logoUri
          : logoUri // ignore: cast_nullable_to_non_nullable
              as String?,
      scopes: freezed == scopes
          ? _value.scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      uiType: freezed == uiType
          ? _value.uiType
          : uiType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ClientMetadataCopyWith<$Res>
    implements $ClientMetadataCopyWith<$Res> {
  factory _$$_ClientMetadataCopyWith(
          _$_ClientMetadata value, $Res Function(_$_ClientMetadata) then) =
      __$$_ClientMetadataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      @JsonKey(name: 'display_name') String? displayName,
      @JsonKey(name: 'logo_uri') String? logoUri,
      List<String>? scopes,
      @JsonKey(name: 'ui_type') String? uiType});
}

/// @nodoc
class __$$_ClientMetadataCopyWithImpl<$Res>
    extends _$ClientMetadataCopyWithImpl<$Res, _$_ClientMetadata>
    implements _$$_ClientMetadataCopyWith<$Res> {
  __$$_ClientMetadataCopyWithImpl(
      _$_ClientMetadata _value, $Res Function(_$_ClientMetadata) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? displayName = freezed,
    Object? logoUri = freezed,
    Object? scopes = freezed,
    Object? uiType = freezed,
  }) {
    return _then(_$_ClientMetadata(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      displayName: freezed == displayName
          ? _value.displayName
          : displayName // ignore: cast_nullable_to_non_nullable
              as String?,
      logoUri: freezed == logoUri
          ? _value.logoUri
          : logoUri // ignore: cast_nullable_to_non_nullable
              as String?,
      scopes: freezed == scopes
          ? _value._scopes
          : scopes // ignore: cast_nullable_to_non_nullable
              as List<String>?,
      uiType: freezed == uiType
          ? _value.uiType
          : uiType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ClientMetadata implements _ClientMetadata {
  const _$_ClientMetadata(
      {this.name,
      @JsonKey(name: 'display_name') this.displayName,
      @JsonKey(name: 'logo_uri') this.logoUri,
      final List<String>? scopes,
      @JsonKey(name: 'ui_type') this.uiType})
      : _scopes = scopes;

  factory _$_ClientMetadata.fromJson(Map<String, dynamic> json) =>
      _$$_ClientMetadataFromJson(json);

  @override
  final String? name;
  @override
  @JsonKey(name: 'display_name')
  final String? displayName;
  @override
  @JsonKey(name: 'logo_uri')
  final String? logoUri;
  final List<String>? _scopes;
  @override
  List<String>? get scopes {
    final value = _scopes;
    if (value == null) return null;
    if (_scopes is EqualUnmodifiableListView) return _scopes;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'ui_type')
  final String? uiType;

  @override
  String toString() {
    return 'ClientMetadata(name: $name, displayName: $displayName, logoUri: $logoUri, scopes: $scopes, uiType: $uiType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ClientMetadata &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.displayName, displayName) ||
                other.displayName == displayName) &&
            (identical(other.logoUri, logoUri) || other.logoUri == logoUri) &&
            const DeepCollectionEquality().equals(other._scopes, _scopes) &&
            (identical(other.uiType, uiType) || other.uiType == uiType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, displayName, logoUri,
      const DeepCollectionEquality().hash(_scopes), uiType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ClientMetadataCopyWith<_$_ClientMetadata> get copyWith =>
      __$$_ClientMetadataCopyWithImpl<_$_ClientMetadata>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ClientMetadataToJson(
      this,
    );
  }
}

abstract class _ClientMetadata implements ClientMetadata {
  const factory _ClientMetadata(
      {final String? name,
      @JsonKey(name: 'display_name') final String? displayName,
      @JsonKey(name: 'logo_uri') final String? logoUri,
      final List<String>? scopes,
      @JsonKey(name: 'ui_type') final String? uiType}) = _$_ClientMetadata;

  factory _ClientMetadata.fromJson(Map<String, dynamic> json) =
      _$_ClientMetadata.fromJson;

  @override
  String? get name;
  @override
  @JsonKey(name: 'display_name')
  String? get displayName;
  @override
  @JsonKey(name: 'logo_uri')
  String? get logoUri;
  @override
  List<String>? get scopes;
  @override
  @JsonKey(name: 'ui_type')
  String? get uiType;
  @override
  @JsonKey(ignore: true)
  _$$_ClientMetadataCopyWith<_$_ClientMetadata> get copyWith =>
      throw _privateConstructorUsedError;
}
