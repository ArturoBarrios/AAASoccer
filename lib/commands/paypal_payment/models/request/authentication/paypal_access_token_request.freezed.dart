// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paypal_access_token_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaypalAccessTokenRequest _$PaypalAccessTokenRequestFromJson(
    Map<String, dynamic> json) {
  return _PaypalAccessTokenRequest.fromJson(json);
}

/// @nodoc
mixin _$PaypalAccessTokenRequest {
  @JsonKey(name: 'grant_type')
  String? get grantType => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaypalAccessTokenRequestCopyWith<PaypalAccessTokenRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaypalAccessTokenRequestCopyWith<$Res> {
  factory $PaypalAccessTokenRequestCopyWith(PaypalAccessTokenRequest value,
          $Res Function(PaypalAccessTokenRequest) then) =
      _$PaypalAccessTokenRequestCopyWithImpl<$Res, PaypalAccessTokenRequest>;
  @useResult
  $Res call({@JsonKey(name: 'grant_type') String? grantType});
}

/// @nodoc
class _$PaypalAccessTokenRequestCopyWithImpl<$Res,
        $Val extends PaypalAccessTokenRequest>
    implements $PaypalAccessTokenRequestCopyWith<$Res> {
  _$PaypalAccessTokenRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grantType = freezed,
  }) {
    return _then(_value.copyWith(
      grantType: freezed == grantType
          ? _value.grantType
          : grantType // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaypalAccessTokenRequestCopyWith<$Res>
    implements $PaypalAccessTokenRequestCopyWith<$Res> {
  factory _$$_PaypalAccessTokenRequestCopyWith(
          _$_PaypalAccessTokenRequest value,
          $Res Function(_$_PaypalAccessTokenRequest) then) =
      __$$_PaypalAccessTokenRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'grant_type') String? grantType});
}

/// @nodoc
class __$$_PaypalAccessTokenRequestCopyWithImpl<$Res>
    extends _$PaypalAccessTokenRequestCopyWithImpl<$Res,
        _$_PaypalAccessTokenRequest>
    implements _$$_PaypalAccessTokenRequestCopyWith<$Res> {
  __$$_PaypalAccessTokenRequestCopyWithImpl(_$_PaypalAccessTokenRequest _value,
      $Res Function(_$_PaypalAccessTokenRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grantType = freezed,
  }) {
    return _then(_$_PaypalAccessTokenRequest(
      grantType: freezed == grantType
          ? _value.grantType
          : grantType // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaypalAccessTokenRequest implements _PaypalAccessTokenRequest {
  const _$_PaypalAccessTokenRequest(
      {@JsonKey(name: 'grant_type') this.grantType = 'client_credentials'});

  factory _$_PaypalAccessTokenRequest.fromJson(Map<String, dynamic> json) =>
      _$$_PaypalAccessTokenRequestFromJson(json);

  @override
  @JsonKey(name: 'grant_type')
  final String? grantType;

  @override
  String toString() {
    return 'PaypalAccessTokenRequest(grantType: $grantType)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaypalAccessTokenRequest &&
            (identical(other.grantType, grantType) ||
                other.grantType == grantType));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, grantType);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaypalAccessTokenRequestCopyWith<_$_PaypalAccessTokenRequest>
      get copyWith => __$$_PaypalAccessTokenRequestCopyWithImpl<
          _$_PaypalAccessTokenRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaypalAccessTokenRequestToJson(
      this,
    );
  }
}

abstract class _PaypalAccessTokenRequest implements PaypalAccessTokenRequest {
  const factory _PaypalAccessTokenRequest(
          {@JsonKey(name: 'grant_type') final String? grantType}) =
      _$_PaypalAccessTokenRequest;

  factory _PaypalAccessTokenRequest.fromJson(Map<String, dynamic> json) =
      _$_PaypalAccessTokenRequest.fromJson;

  @override
  @JsonKey(name: 'grant_type')
  String? get grantType;
  @override
  @JsonKey(ignore: true)
  _$$_PaypalAccessTokenRequestCopyWith<_$_PaypalAccessTokenRequest>
      get copyWith => throw _privateConstructorUsedError;
}
