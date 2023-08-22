// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paypal_capture_payment_for_order_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaypalCapturePaymentForOrderResponse
    _$PaypalCapturePaymentForOrderResponseFromJson(Map<String, dynamic> json) {
  return _PaypalCapturePaymentForOrderResponse.fromJson(json);
}

/// @nodoc
mixin _$PaypalCapturePaymentForOrderResponse {
  String? get id => throw _privateConstructorUsedError;
  String? get intent => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'payment_source')
  PaymentSource? get paymentSource => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_units')
  List<PurchaseUnits>? get purchaseUnits => throw _privateConstructorUsedError;
  Payer? get payer => throw _privateConstructorUsedError;
  @JsonKey(name: 'create_time')
  String? get createTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'update_time')
  String? get updateTime => throw _privateConstructorUsedError;
  List<Links>? get links => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaypalCapturePaymentForOrderResponseCopyWith<
          PaypalCapturePaymentForOrderResponse>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaypalCapturePaymentForOrderResponseCopyWith<$Res> {
  factory $PaypalCapturePaymentForOrderResponseCopyWith(
          PaypalCapturePaymentForOrderResponse value,
          $Res Function(PaypalCapturePaymentForOrderResponse) then) =
      _$PaypalCapturePaymentForOrderResponseCopyWithImpl<$Res,
          PaypalCapturePaymentForOrderResponse>;
  @useResult
  $Res call(
      {String? id,
      String? intent,
      String? status,
      @JsonKey(name: 'payment_source') PaymentSource? paymentSource,
      @JsonKey(name: 'purchase_units') List<PurchaseUnits>? purchaseUnits,
      Payer? payer,
      @JsonKey(name: 'create_time') String? createTime,
      @JsonKey(name: 'update_time') String? updateTime,
      List<Links>? links});

  $PaymentSourceCopyWith<$Res>? get paymentSource;
  $PayerCopyWith<$Res>? get payer;
}

/// @nodoc
class _$PaypalCapturePaymentForOrderResponseCopyWithImpl<$Res,
        $Val extends PaypalCapturePaymentForOrderResponse>
    implements $PaypalCapturePaymentForOrderResponseCopyWith<$Res> {
  _$PaypalCapturePaymentForOrderResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? intent = freezed,
    Object? status = freezed,
    Object? paymentSource = freezed,
    Object? purchaseUnits = freezed,
    Object? payer = freezed,
    Object? createTime = freezed,
    Object? updateTime = freezed,
    Object? links = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      intent: freezed == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentSource: freezed == paymentSource
          ? _value.paymentSource
          : paymentSource // ignore: cast_nullable_to_non_nullable
              as PaymentSource?,
      purchaseUnits: freezed == purchaseUnits
          ? _value.purchaseUnits
          : purchaseUnits // ignore: cast_nullable_to_non_nullable
              as List<PurchaseUnits>?,
      payer: freezed == payer
          ? _value.payer
          : payer // ignore: cast_nullable_to_non_nullable
              as Payer?,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      updateTime: freezed == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Links>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaymentSourceCopyWith<$Res>? get paymentSource {
    if (_value.paymentSource == null) {
      return null;
    }

    return $PaymentSourceCopyWith<$Res>(_value.paymentSource!, (value) {
      return _then(_value.copyWith(paymentSource: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PayerCopyWith<$Res>? get payer {
    if (_value.payer == null) {
      return null;
    }

    return $PayerCopyWith<$Res>(_value.payer!, (value) {
      return _then(_value.copyWith(payer: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PaypalCapturePaymentForOrderResponseCopyWith<$Res>
    implements $PaypalCapturePaymentForOrderResponseCopyWith<$Res> {
  factory _$$_PaypalCapturePaymentForOrderResponseCopyWith(
          _$_PaypalCapturePaymentForOrderResponse value,
          $Res Function(_$_PaypalCapturePaymentForOrderResponse) then) =
      __$$_PaypalCapturePaymentForOrderResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? intent,
      String? status,
      @JsonKey(name: 'payment_source') PaymentSource? paymentSource,
      @JsonKey(name: 'purchase_units') List<PurchaseUnits>? purchaseUnits,
      Payer? payer,
      @JsonKey(name: 'create_time') String? createTime,
      @JsonKey(name: 'update_time') String? updateTime,
      List<Links>? links});

  @override
  $PaymentSourceCopyWith<$Res>? get paymentSource;
  @override
  $PayerCopyWith<$Res>? get payer;
}

/// @nodoc
class __$$_PaypalCapturePaymentForOrderResponseCopyWithImpl<$Res>
    extends _$PaypalCapturePaymentForOrderResponseCopyWithImpl<$Res,
        _$_PaypalCapturePaymentForOrderResponse>
    implements _$$_PaypalCapturePaymentForOrderResponseCopyWith<$Res> {
  __$$_PaypalCapturePaymentForOrderResponseCopyWithImpl(
      _$_PaypalCapturePaymentForOrderResponse _value,
      $Res Function(_$_PaypalCapturePaymentForOrderResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? intent = freezed,
    Object? status = freezed,
    Object? paymentSource = freezed,
    Object? purchaseUnits = freezed,
    Object? payer = freezed,
    Object? createTime = freezed,
    Object? updateTime = freezed,
    Object? links = freezed,
  }) {
    return _then(_$_PaypalCapturePaymentForOrderResponse(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      intent: freezed == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      paymentSource: freezed == paymentSource
          ? _value.paymentSource
          : paymentSource // ignore: cast_nullable_to_non_nullable
              as PaymentSource?,
      purchaseUnits: freezed == purchaseUnits
          ? _value._purchaseUnits
          : purchaseUnits // ignore: cast_nullable_to_non_nullable
              as List<PurchaseUnits>?,
      payer: freezed == payer
          ? _value.payer
          : payer // ignore: cast_nullable_to_non_nullable
              as Payer?,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      updateTime: freezed == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Links>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaypalCapturePaymentForOrderResponse
    implements _PaypalCapturePaymentForOrderResponse {
  const _$_PaypalCapturePaymentForOrderResponse(
      {this.id,
      this.intent,
      this.status,
      @JsonKey(name: 'payment_source') this.paymentSource,
      @JsonKey(name: 'purchase_units') final List<PurchaseUnits>? purchaseUnits,
      this.payer,
      @JsonKey(name: 'create_time') this.createTime,
      @JsonKey(name: 'update_time') this.updateTime,
      final List<Links>? links})
      : _purchaseUnits = purchaseUnits,
        _links = links;

  factory _$_PaypalCapturePaymentForOrderResponse.fromJson(
          Map<String, dynamic> json) =>
      _$$_PaypalCapturePaymentForOrderResponseFromJson(json);

  @override
  final String? id;
  @override
  final String? intent;
  @override
  final String? status;
  @override
  @JsonKey(name: 'payment_source')
  final PaymentSource? paymentSource;
  final List<PurchaseUnits>? _purchaseUnits;
  @override
  @JsonKey(name: 'purchase_units')
  List<PurchaseUnits>? get purchaseUnits {
    final value = _purchaseUnits;
    if (value == null) return null;
    if (_purchaseUnits is EqualUnmodifiableListView) return _purchaseUnits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final Payer? payer;
  @override
  @JsonKey(name: 'create_time')
  final String? createTime;
  @override
  @JsonKey(name: 'update_time')
  final String? updateTime;
  final List<Links>? _links;
  @override
  List<Links>? get links {
    final value = _links;
    if (value == null) return null;
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PaypalCapturePaymentForOrderResponse(id: $id, intent: $intent, status: $status, paymentSource: $paymentSource, purchaseUnits: $purchaseUnits, payer: $payer, createTime: $createTime, updateTime: $updateTime, links: $links)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaypalCapturePaymentForOrderResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.intent, intent) || other.intent == intent) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.paymentSource, paymentSource) ||
                other.paymentSource == paymentSource) &&
            const DeepCollectionEquality()
                .equals(other._purchaseUnits, _purchaseUnits) &&
            (identical(other.payer, payer) || other.payer == payer) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime) &&
            const DeepCollectionEquality().equals(other._links, _links));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      intent,
      status,
      paymentSource,
      const DeepCollectionEquality().hash(_purchaseUnits),
      payer,
      createTime,
      updateTime,
      const DeepCollectionEquality().hash(_links));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaypalCapturePaymentForOrderResponseCopyWith<
          _$_PaypalCapturePaymentForOrderResponse>
      get copyWith => __$$_PaypalCapturePaymentForOrderResponseCopyWithImpl<
          _$_PaypalCapturePaymentForOrderResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaypalCapturePaymentForOrderResponseToJson(
      this,
    );
  }
}

abstract class _PaypalCapturePaymentForOrderResponse
    implements PaypalCapturePaymentForOrderResponse {
  const factory _PaypalCapturePaymentForOrderResponse(
      {final String? id,
      final String? intent,
      final String? status,
      @JsonKey(name: 'payment_source') final PaymentSource? paymentSource,
      @JsonKey(name: 'purchase_units') final List<PurchaseUnits>? purchaseUnits,
      final Payer? payer,
      @JsonKey(name: 'create_time') final String? createTime,
      @JsonKey(name: 'update_time') final String? updateTime,
      final List<Links>? links}) = _$_PaypalCapturePaymentForOrderResponse;

  factory _PaypalCapturePaymentForOrderResponse.fromJson(
          Map<String, dynamic> json) =
      _$_PaypalCapturePaymentForOrderResponse.fromJson;

  @override
  String? get id;
  @override
  String? get intent;
  @override
  String? get status;
  @override
  @JsonKey(name: 'payment_source')
  PaymentSource? get paymentSource;
  @override
  @JsonKey(name: 'purchase_units')
  List<PurchaseUnits>? get purchaseUnits;
  @override
  Payer? get payer;
  @override
  @JsonKey(name: 'create_time')
  String? get createTime;
  @override
  @JsonKey(name: 'update_time')
  String? get updateTime;
  @override
  List<Links>? get links;
  @override
  @JsonKey(ignore: true)
  _$$_PaypalCapturePaymentForOrderResponseCopyWith<
          _$_PaypalCapturePaymentForOrderResponse>
      get copyWith => throw _privateConstructorUsedError;
}

PaymentSource _$PaymentSourceFromJson(Map<String, dynamic> json) {
  return _PaymentSource.fromJson(json);
}

/// @nodoc
mixin _$PaymentSource {
  Paypal? get paypal => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentSourceCopyWith<PaymentSource> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentSourceCopyWith<$Res> {
  factory $PaymentSourceCopyWith(
          PaymentSource value, $Res Function(PaymentSource) then) =
      _$PaymentSourceCopyWithImpl<$Res, PaymentSource>;
  @useResult
  $Res call({Paypal? paypal});

  $PaypalCopyWith<$Res>? get paypal;
}

/// @nodoc
class _$PaymentSourceCopyWithImpl<$Res, $Val extends PaymentSource>
    implements $PaymentSourceCopyWith<$Res> {
  _$PaymentSourceCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paypal = freezed,
  }) {
    return _then(_value.copyWith(
      paypal: freezed == paypal
          ? _value.paypal
          : paypal // ignore: cast_nullable_to_non_nullable
              as Paypal?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $PaypalCopyWith<$Res>? get paypal {
    if (_value.paypal == null) {
      return null;
    }

    return $PaypalCopyWith<$Res>(_value.paypal!, (value) {
      return _then(_value.copyWith(paypal: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PaymentSourceCopyWith<$Res>
    implements $PaymentSourceCopyWith<$Res> {
  factory _$$_PaymentSourceCopyWith(
          _$_PaymentSource value, $Res Function(_$_PaymentSource) then) =
      __$$_PaymentSourceCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Paypal? paypal});

  @override
  $PaypalCopyWith<$Res>? get paypal;
}

/// @nodoc
class __$$_PaymentSourceCopyWithImpl<$Res>
    extends _$PaymentSourceCopyWithImpl<$Res, _$_PaymentSource>
    implements _$$_PaymentSourceCopyWith<$Res> {
  __$$_PaymentSourceCopyWithImpl(
      _$_PaymentSource _value, $Res Function(_$_PaymentSource) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? paypal = freezed,
  }) {
    return _then(_$_PaymentSource(
      paypal: freezed == paypal
          ? _value.paypal
          : paypal // ignore: cast_nullable_to_non_nullable
              as Paypal?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaymentSource implements _PaymentSource {
  const _$_PaymentSource({this.paypal});

  factory _$_PaymentSource.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentSourceFromJson(json);

  @override
  final Paypal? paypal;

  @override
  String toString() {
    return 'PaymentSource(paypal: $paypal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentSource &&
            (identical(other.paypal, paypal) || other.paypal == paypal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, paypal);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentSourceCopyWith<_$_PaymentSource> get copyWith =>
      __$$_PaymentSourceCopyWithImpl<_$_PaymentSource>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentSourceToJson(
      this,
    );
  }
}

abstract class _PaymentSource implements PaymentSource {
  const factory _PaymentSource({final Paypal? paypal}) = _$_PaymentSource;

  factory _PaymentSource.fromJson(Map<String, dynamic> json) =
      _$_PaymentSource.fromJson;

  @override
  Paypal? get paypal;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentSourceCopyWith<_$_PaymentSource> get copyWith =>
      throw _privateConstructorUsedError;
}

Paypal _$PaypalFromJson(Map<String, dynamic> json) {
  return _Paypal.fromJson(json);
}

/// @nodoc
mixin _$Paypal {
  @JsonKey(name: 'email_address')
  String? get emailAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_id')
  String? get accountId => throw _privateConstructorUsedError;
  @JsonKey(name: 'account_status')
  String? get accountStatus => throw _privateConstructorUsedError;
  Name? get name => throw _privateConstructorUsedError;
  CountryCode? get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaypalCopyWith<Paypal> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaypalCopyWith<$Res> {
  factory $PaypalCopyWith(Paypal value, $Res Function(Paypal) then) =
      _$PaypalCopyWithImpl<$Res, Paypal>;
  @useResult
  $Res call(
      {@JsonKey(name: 'email_address') String? emailAddress,
      @JsonKey(name: 'account_id') String? accountId,
      @JsonKey(name: 'account_status') String? accountStatus,
      Name? name,
      CountryCode? address});

  $NameCopyWith<$Res>? get name;
  $CountryCodeCopyWith<$Res>? get address;
}

/// @nodoc
class _$PaypalCopyWithImpl<$Res, $Val extends Paypal>
    implements $PaypalCopyWith<$Res> {
  _$PaypalCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailAddress = freezed,
    Object? accountId = freezed,
    Object? accountStatus = freezed,
    Object? name = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      emailAddress: freezed == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      accountStatus: freezed == accountStatus
          ? _value.accountStatus
          : accountStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Name?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as CountryCode?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NameCopyWith<$Res>? get name {
    if (_value.name == null) {
      return null;
    }

    return $NameCopyWith<$Res>(_value.name!, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CountryCodeCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $CountryCodeCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PaypalCopyWith<$Res> implements $PaypalCopyWith<$Res> {
  factory _$$_PaypalCopyWith(_$_Paypal value, $Res Function(_$_Paypal) then) =
      __$$_PaypalCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'email_address') String? emailAddress,
      @JsonKey(name: 'account_id') String? accountId,
      @JsonKey(name: 'account_status') String? accountStatus,
      Name? name,
      CountryCode? address});

  @override
  $NameCopyWith<$Res>? get name;
  @override
  $CountryCodeCopyWith<$Res>? get address;
}

/// @nodoc
class __$$_PaypalCopyWithImpl<$Res>
    extends _$PaypalCopyWithImpl<$Res, _$_Paypal>
    implements _$$_PaypalCopyWith<$Res> {
  __$$_PaypalCopyWithImpl(_$_Paypal _value, $Res Function(_$_Paypal) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailAddress = freezed,
    Object? accountId = freezed,
    Object? accountStatus = freezed,
    Object? name = freezed,
    Object? address = freezed,
  }) {
    return _then(_$_Paypal(
      emailAddress: freezed == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      accountId: freezed == accountId
          ? _value.accountId
          : accountId // ignore: cast_nullable_to_non_nullable
              as String?,
      accountStatus: freezed == accountStatus
          ? _value.accountStatus
          : accountStatus // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Name?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as CountryCode?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Paypal implements _Paypal {
  const _$_Paypal(
      {@JsonKey(name: 'email_address') this.emailAddress,
      @JsonKey(name: 'account_id') this.accountId,
      @JsonKey(name: 'account_status') this.accountStatus,
      this.name,
      this.address});

  factory _$_Paypal.fromJson(Map<String, dynamic> json) =>
      _$$_PaypalFromJson(json);

  @override
  @JsonKey(name: 'email_address')
  final String? emailAddress;
  @override
  @JsonKey(name: 'account_id')
  final String? accountId;
  @override
  @JsonKey(name: 'account_status')
  final String? accountStatus;
  @override
  final Name? name;
  @override
  final CountryCode? address;

  @override
  String toString() {
    return 'Paypal(emailAddress: $emailAddress, accountId: $accountId, accountStatus: $accountStatus, name: $name, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Paypal &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.accountId, accountId) ||
                other.accountId == accountId) &&
            (identical(other.accountStatus, accountStatus) ||
                other.accountStatus == accountStatus) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, emailAddress, accountId, accountStatus, name, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaypalCopyWith<_$_Paypal> get copyWith =>
      __$$_PaypalCopyWithImpl<_$_Paypal>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaypalToJson(
      this,
    );
  }
}

abstract class _Paypal implements Paypal {
  const factory _Paypal(
      {@JsonKey(name: 'email_address') final String? emailAddress,
      @JsonKey(name: 'account_id') final String? accountId,
      @JsonKey(name: 'account_status') final String? accountStatus,
      final Name? name,
      final CountryCode? address}) = _$_Paypal;

  factory _Paypal.fromJson(Map<String, dynamic> json) = _$_Paypal.fromJson;

  @override
  @JsonKey(name: 'email_address')
  String? get emailAddress;
  @override
  @JsonKey(name: 'account_id')
  String? get accountId;
  @override
  @JsonKey(name: 'account_status')
  String? get accountStatus;
  @override
  Name? get name;
  @override
  CountryCode? get address;
  @override
  @JsonKey(ignore: true)
  _$$_PaypalCopyWith<_$_Paypal> get copyWith =>
      throw _privateConstructorUsedError;
}

Name _$NameFromJson(Map<String, dynamic> json) {
  return _Name.fromJson(json);
}

/// @nodoc
mixin _$Name {
  @JsonKey(name: 'given_name')
  String? get givenName => throw _privateConstructorUsedError;
  String? get surname => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $NameCopyWith<Name> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $NameCopyWith<$Res> {
  factory $NameCopyWith(Name value, $Res Function(Name) then) =
      _$NameCopyWithImpl<$Res, Name>;
  @useResult
  $Res call({@JsonKey(name: 'given_name') String? givenName, String? surname});
}

/// @nodoc
class _$NameCopyWithImpl<$Res, $Val extends Name>
    implements $NameCopyWith<$Res> {
  _$NameCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? givenName = freezed,
    Object? surname = freezed,
  }) {
    return _then(_value.copyWith(
      givenName: freezed == givenName
          ? _value.givenName
          : givenName // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_NameCopyWith<$Res> implements $NameCopyWith<$Res> {
  factory _$$_NameCopyWith(_$_Name value, $Res Function(_$_Name) then) =
      __$$_NameCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'given_name') String? givenName, String? surname});
}

/// @nodoc
class __$$_NameCopyWithImpl<$Res> extends _$NameCopyWithImpl<$Res, _$_Name>
    implements _$$_NameCopyWith<$Res> {
  __$$_NameCopyWithImpl(_$_Name _value, $Res Function(_$_Name) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? givenName = freezed,
    Object? surname = freezed,
  }) {
    return _then(_$_Name(
      givenName: freezed == givenName
          ? _value.givenName
          : givenName // ignore: cast_nullable_to_non_nullable
              as String?,
      surname: freezed == surname
          ? _value.surname
          : surname // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Name implements _Name {
  const _$_Name({@JsonKey(name: 'given_name') this.givenName, this.surname});

  factory _$_Name.fromJson(Map<String, dynamic> json) => _$$_NameFromJson(json);

  @override
  @JsonKey(name: 'given_name')
  final String? givenName;
  @override
  final String? surname;

  @override
  String toString() {
    return 'Name(givenName: $givenName, surname: $surname)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Name &&
            (identical(other.givenName, givenName) ||
                other.givenName == givenName) &&
            (identical(other.surname, surname) || other.surname == surname));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, givenName, surname);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_NameCopyWith<_$_Name> get copyWith =>
      __$$_NameCopyWithImpl<_$_Name>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_NameToJson(
      this,
    );
  }
}

abstract class _Name implements Name {
  const factory _Name(
      {@JsonKey(name: 'given_name') final String? givenName,
      final String? surname}) = _$_Name;

  factory _Name.fromJson(Map<String, dynamic> json) = _$_Name.fromJson;

  @override
  @JsonKey(name: 'given_name')
  String? get givenName;
  @override
  String? get surname;
  @override
  @JsonKey(ignore: true)
  _$$_NameCopyWith<_$_Name> get copyWith => throw _privateConstructorUsedError;
}

CountryCode _$CountryCodeFromJson(Map<String, dynamic> json) {
  return _CountryCode.fromJson(json);
}

/// @nodoc
mixin _$CountryCode {
  @JsonKey(name: 'country_code')
  String? get countryCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CountryCodeCopyWith<CountryCode> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CountryCodeCopyWith<$Res> {
  factory $CountryCodeCopyWith(
          CountryCode value, $Res Function(CountryCode) then) =
      _$CountryCodeCopyWithImpl<$Res, CountryCode>;
  @useResult
  $Res call({@JsonKey(name: 'country_code') String? countryCode});
}

/// @nodoc
class _$CountryCodeCopyWithImpl<$Res, $Val extends CountryCode>
    implements $CountryCodeCopyWith<$Res> {
  _$CountryCodeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryCode = freezed,
  }) {
    return _then(_value.copyWith(
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CountryCodeCopyWith<$Res>
    implements $CountryCodeCopyWith<$Res> {
  factory _$$_CountryCodeCopyWith(
          _$_CountryCode value, $Res Function(_$_CountryCode) then) =
      __$$_CountryCodeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'country_code') String? countryCode});
}

/// @nodoc
class __$$_CountryCodeCopyWithImpl<$Res>
    extends _$CountryCodeCopyWithImpl<$Res, _$_CountryCode>
    implements _$$_CountryCodeCopyWith<$Res> {
  __$$_CountryCodeCopyWithImpl(
      _$_CountryCode _value, $Res Function(_$_CountryCode) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? countryCode = freezed,
  }) {
    return _then(_$_CountryCode(
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CountryCode implements _CountryCode {
  const _$_CountryCode({@JsonKey(name: 'country_code') this.countryCode});

  factory _$_CountryCode.fromJson(Map<String, dynamic> json) =>
      _$$_CountryCodeFromJson(json);

  @override
  @JsonKey(name: 'country_code')
  final String? countryCode;

  @override
  String toString() {
    return 'CountryCode(countryCode: $countryCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CountryCode &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, countryCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CountryCodeCopyWith<_$_CountryCode> get copyWith =>
      __$$_CountryCodeCopyWithImpl<_$_CountryCode>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CountryCodeToJson(
      this,
    );
  }
}

abstract class _CountryCode implements CountryCode {
  const factory _CountryCode(
          {@JsonKey(name: 'country_code') final String? countryCode}) =
      _$_CountryCode;

  factory _CountryCode.fromJson(Map<String, dynamic> json) =
      _$_CountryCode.fromJson;

  @override
  @JsonKey(name: 'country_code')
  String? get countryCode;
  @override
  @JsonKey(ignore: true)
  _$$_CountryCodeCopyWith<_$_CountryCode> get copyWith =>
      throw _privateConstructorUsedError;
}

PurchaseUnits _$PurchaseUnitsFromJson(Map<String, dynamic> json) {
  return _PurchaseUnits.fromJson(json);
}

/// @nodoc
mixin _$PurchaseUnits {
  @JsonKey(name: 'reference_id')
  String? get referenceId => throw _privateConstructorUsedError;
  Amount? get amount => throw _privateConstructorUsedError;
  Payee? get payee => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  List<Items>? get items => throw _privateConstructorUsedError;
  ShippingAddress? get shipping => throw _privateConstructorUsedError;
  Payments? get payments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PurchaseUnitsCopyWith<PurchaseUnits> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseUnitsCopyWith<$Res> {
  factory $PurchaseUnitsCopyWith(
          PurchaseUnits value, $Res Function(PurchaseUnits) then) =
      _$PurchaseUnitsCopyWithImpl<$Res, PurchaseUnits>;
  @useResult
  $Res call(
      {@JsonKey(name: 'reference_id') String? referenceId,
      Amount? amount,
      Payee? payee,
      String? description,
      List<Items>? items,
      ShippingAddress? shipping,
      Payments? payments});

  $AmountCopyWith<$Res>? get amount;
  $PayeeCopyWith<$Res>? get payee;
  $ShippingAddressCopyWith<$Res>? get shipping;
  $PaymentsCopyWith<$Res>? get payments;
}

/// @nodoc
class _$PurchaseUnitsCopyWithImpl<$Res, $Val extends PurchaseUnits>
    implements $PurchaseUnitsCopyWith<$Res> {
  _$PurchaseUnitsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referenceId = freezed,
    Object? amount = freezed,
    Object? payee = freezed,
    Object? description = freezed,
    Object? items = freezed,
    Object? shipping = freezed,
    Object? payments = freezed,
  }) {
    return _then(_value.copyWith(
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Amount?,
      payee: freezed == payee
          ? _value.payee
          : payee // ignore: cast_nullable_to_non_nullable
              as Payee?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Items>?,
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as ShippingAddress?,
      payments: freezed == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as Payments?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AmountCopyWith<$Res>? get amount {
    if (_value.amount == null) {
      return null;
    }

    return $AmountCopyWith<$Res>(_value.amount!, (value) {
      return _then(_value.copyWith(amount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PayeeCopyWith<$Res>? get payee {
    if (_value.payee == null) {
      return null;
    }

    return $PayeeCopyWith<$Res>(_value.payee!, (value) {
      return _then(_value.copyWith(payee: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ShippingAddressCopyWith<$Res>? get shipping {
    if (_value.shipping == null) {
      return null;
    }

    return $ShippingAddressCopyWith<$Res>(_value.shipping!, (value) {
      return _then(_value.copyWith(shipping: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PaymentsCopyWith<$Res>? get payments {
    if (_value.payments == null) {
      return null;
    }

    return $PaymentsCopyWith<$Res>(_value.payments!, (value) {
      return _then(_value.copyWith(payments: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PurchaseUnitsCopyWith<$Res>
    implements $PurchaseUnitsCopyWith<$Res> {
  factory _$$_PurchaseUnitsCopyWith(
          _$_PurchaseUnits value, $Res Function(_$_PurchaseUnits) then) =
      __$$_PurchaseUnitsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'reference_id') String? referenceId,
      Amount? amount,
      Payee? payee,
      String? description,
      List<Items>? items,
      ShippingAddress? shipping,
      Payments? payments});

  @override
  $AmountCopyWith<$Res>? get amount;
  @override
  $PayeeCopyWith<$Res>? get payee;
  @override
  $ShippingAddressCopyWith<$Res>? get shipping;
  @override
  $PaymentsCopyWith<$Res>? get payments;
}

/// @nodoc
class __$$_PurchaseUnitsCopyWithImpl<$Res>
    extends _$PurchaseUnitsCopyWithImpl<$Res, _$_PurchaseUnits>
    implements _$$_PurchaseUnitsCopyWith<$Res> {
  __$$_PurchaseUnitsCopyWithImpl(
      _$_PurchaseUnits _value, $Res Function(_$_PurchaseUnits) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referenceId = freezed,
    Object? amount = freezed,
    Object? payee = freezed,
    Object? description = freezed,
    Object? items = freezed,
    Object? shipping = freezed,
    Object? payments = freezed,
  }) {
    return _then(_$_PurchaseUnits(
      referenceId: freezed == referenceId
          ? _value.referenceId
          : referenceId // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Amount?,
      payee: freezed == payee
          ? _value.payee
          : payee // ignore: cast_nullable_to_non_nullable
              as Payee?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Items>?,
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as ShippingAddress?,
      payments: freezed == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as Payments?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PurchaseUnits implements _PurchaseUnits {
  const _$_PurchaseUnits(
      {@JsonKey(name: 'reference_id') this.referenceId,
      this.amount,
      this.payee,
      this.description,
      final List<Items>? items,
      this.shipping,
      this.payments})
      : _items = items;

  factory _$_PurchaseUnits.fromJson(Map<String, dynamic> json) =>
      _$$_PurchaseUnitsFromJson(json);

  @override
  @JsonKey(name: 'reference_id')
  final String? referenceId;
  @override
  final Amount? amount;
  @override
  final Payee? payee;
  @override
  final String? description;
  final List<Items>? _items;
  @override
  List<Items>? get items {
    final value = _items;
    if (value == null) return null;
    if (_items is EqualUnmodifiableListView) return _items;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final ShippingAddress? shipping;
  @override
  final Payments? payments;

  @override
  String toString() {
    return 'PurchaseUnits(referenceId: $referenceId, amount: $amount, payee: $payee, description: $description, items: $items, shipping: $shipping, payments: $payments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PurchaseUnits &&
            (identical(other.referenceId, referenceId) ||
                other.referenceId == referenceId) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.payee, payee) || other.payee == payee) &&
            (identical(other.description, description) ||
                other.description == description) &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.payments, payments) ||
                other.payments == payments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      referenceId,
      amount,
      payee,
      description,
      const DeepCollectionEquality().hash(_items),
      shipping,
      payments);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PurchaseUnitsCopyWith<_$_PurchaseUnits> get copyWith =>
      __$$_PurchaseUnitsCopyWithImpl<_$_PurchaseUnits>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PurchaseUnitsToJson(
      this,
    );
  }
}

abstract class _PurchaseUnits implements PurchaseUnits {
  const factory _PurchaseUnits(
      {@JsonKey(name: 'reference_id') final String? referenceId,
      final Amount? amount,
      final Payee? payee,
      final String? description,
      final List<Items>? items,
      final ShippingAddress? shipping,
      final Payments? payments}) = _$_PurchaseUnits;

  factory _PurchaseUnits.fromJson(Map<String, dynamic> json) =
      _$_PurchaseUnits.fromJson;

  @override
  @JsonKey(name: 'reference_id')
  String? get referenceId;
  @override
  Amount? get amount;
  @override
  Payee? get payee;
  @override
  String? get description;
  @override
  List<Items>? get items;
  @override
  ShippingAddress? get shipping;
  @override
  Payments? get payments;
  @override
  @JsonKey(ignore: true)
  _$$_PurchaseUnitsCopyWith<_$_PurchaseUnits> get copyWith =>
      throw _privateConstructorUsedError;
}

Amount _$AmountFromJson(Map<String, dynamic> json) {
  return _Amount.fromJson(json);
}

/// @nodoc
mixin _$Amount {
  @JsonKey(name: 'currency_code')
  String? get currencyCode => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;
  Breakdown? get breakdown => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AmountCopyWith<Amount> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AmountCopyWith<$Res> {
  factory $AmountCopyWith(Amount value, $Res Function(Amount) then) =
      _$AmountCopyWithImpl<$Res, Amount>;
  @useResult
  $Res call(
      {@JsonKey(name: 'currency_code') String? currencyCode,
      String? value,
      Breakdown? breakdown});

  $BreakdownCopyWith<$Res>? get breakdown;
}

/// @nodoc
class _$AmountCopyWithImpl<$Res, $Val extends Amount>
    implements $AmountCopyWith<$Res> {
  _$AmountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currencyCode = freezed,
    Object? value = freezed,
    Object? breakdown = freezed,
  }) {
    return _then(_value.copyWith(
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      breakdown: freezed == breakdown
          ? _value.breakdown
          : breakdown // ignore: cast_nullable_to_non_nullable
              as Breakdown?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $BreakdownCopyWith<$Res>? get breakdown {
    if (_value.breakdown == null) {
      return null;
    }

    return $BreakdownCopyWith<$Res>(_value.breakdown!, (value) {
      return _then(_value.copyWith(breakdown: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AmountCopyWith<$Res> implements $AmountCopyWith<$Res> {
  factory _$$_AmountCopyWith(_$_Amount value, $Res Function(_$_Amount) then) =
      __$$_AmountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'currency_code') String? currencyCode,
      String? value,
      Breakdown? breakdown});

  @override
  $BreakdownCopyWith<$Res>? get breakdown;
}

/// @nodoc
class __$$_AmountCopyWithImpl<$Res>
    extends _$AmountCopyWithImpl<$Res, _$_Amount>
    implements _$$_AmountCopyWith<$Res> {
  __$$_AmountCopyWithImpl(_$_Amount _value, $Res Function(_$_Amount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currencyCode = freezed,
    Object? value = freezed,
    Object? breakdown = freezed,
  }) {
    return _then(_$_Amount(
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
      breakdown: freezed == breakdown
          ? _value.breakdown
          : breakdown // ignore: cast_nullable_to_non_nullable
              as Breakdown?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Amount implements _Amount {
  const _$_Amount(
      {@JsonKey(name: 'currency_code') this.currencyCode,
      this.value,
      this.breakdown});

  factory _$_Amount.fromJson(Map<String, dynamic> json) =>
      _$$_AmountFromJson(json);

  @override
  @JsonKey(name: 'currency_code')
  final String? currencyCode;
  @override
  final String? value;
  @override
  final Breakdown? breakdown;

  @override
  String toString() {
    return 'Amount(currencyCode: $currencyCode, value: $value, breakdown: $breakdown)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Amount &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.value, value) || other.value == value) &&
            (identical(other.breakdown, breakdown) ||
                other.breakdown == breakdown));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currencyCode, value, breakdown);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AmountCopyWith<_$_Amount> get copyWith =>
      __$$_AmountCopyWithImpl<_$_Amount>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AmountToJson(
      this,
    );
  }
}

abstract class _Amount implements Amount {
  const factory _Amount(
      {@JsonKey(name: 'currency_code') final String? currencyCode,
      final String? value,
      final Breakdown? breakdown}) = _$_Amount;

  factory _Amount.fromJson(Map<String, dynamic> json) = _$_Amount.fromJson;

  @override
  @JsonKey(name: 'currency_code')
  String? get currencyCode;
  @override
  String? get value;
  @override
  Breakdown? get breakdown;
  @override
  @JsonKey(ignore: true)
  _$$_AmountCopyWith<_$_Amount> get copyWith =>
      throw _privateConstructorUsedError;
}

Breakdown _$BreakdownFromJson(Map<String, dynamic> json) {
  return _Breakdown.fromJson(json);
}

/// @nodoc
mixin _$Breakdown {
  @JsonKey(name: 'item_total')
  CurrencyCodeWithValue? get itemTotal => throw _privateConstructorUsedError;
  CurrencyCodeWithValue? get shipping => throw _privateConstructorUsedError;
  CurrencyCodeWithValue? get handling => throw _privateConstructorUsedError;
  CurrencyCodeWithValue? get insurance => throw _privateConstructorUsedError;
  @JsonKey(name: 'shipping_discount')
  CurrencyCodeWithValue? get shippingDiscount =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BreakdownCopyWith<Breakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BreakdownCopyWith<$Res> {
  factory $BreakdownCopyWith(Breakdown value, $Res Function(Breakdown) then) =
      _$BreakdownCopyWithImpl<$Res, Breakdown>;
  @useResult
  $Res call(
      {@JsonKey(name: 'item_total') CurrencyCodeWithValue? itemTotal,
      CurrencyCodeWithValue? shipping,
      CurrencyCodeWithValue? handling,
      CurrencyCodeWithValue? insurance,
      @JsonKey(name: 'shipping_discount')
      CurrencyCodeWithValue? shippingDiscount});

  $CurrencyCodeWithValueCopyWith<$Res>? get itemTotal;
  $CurrencyCodeWithValueCopyWith<$Res>? get shipping;
  $CurrencyCodeWithValueCopyWith<$Res>? get handling;
  $CurrencyCodeWithValueCopyWith<$Res>? get insurance;
  $CurrencyCodeWithValueCopyWith<$Res>? get shippingDiscount;
}

/// @nodoc
class _$BreakdownCopyWithImpl<$Res, $Val extends Breakdown>
    implements $BreakdownCopyWith<$Res> {
  _$BreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemTotal = freezed,
    Object? shipping = freezed,
    Object? handling = freezed,
    Object? insurance = freezed,
    Object? shippingDiscount = freezed,
  }) {
    return _then(_value.copyWith(
      itemTotal: freezed == itemTotal
          ? _value.itemTotal
          : itemTotal // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      handling: freezed == handling
          ? _value.handling
          : handling // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      insurance: freezed == insurance
          ? _value.insurance
          : insurance // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      shippingDiscount: freezed == shippingDiscount
          ? _value.shippingDiscount
          : shippingDiscount // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrencyCodeWithValueCopyWith<$Res>? get itemTotal {
    if (_value.itemTotal == null) {
      return null;
    }

    return $CurrencyCodeWithValueCopyWith<$Res>(_value.itemTotal!, (value) {
      return _then(_value.copyWith(itemTotal: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrencyCodeWithValueCopyWith<$Res>? get shipping {
    if (_value.shipping == null) {
      return null;
    }

    return $CurrencyCodeWithValueCopyWith<$Res>(_value.shipping!, (value) {
      return _then(_value.copyWith(shipping: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrencyCodeWithValueCopyWith<$Res>? get handling {
    if (_value.handling == null) {
      return null;
    }

    return $CurrencyCodeWithValueCopyWith<$Res>(_value.handling!, (value) {
      return _then(_value.copyWith(handling: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrencyCodeWithValueCopyWith<$Res>? get insurance {
    if (_value.insurance == null) {
      return null;
    }

    return $CurrencyCodeWithValueCopyWith<$Res>(_value.insurance!, (value) {
      return _then(_value.copyWith(insurance: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrencyCodeWithValueCopyWith<$Res>? get shippingDiscount {
    if (_value.shippingDiscount == null) {
      return null;
    }

    return $CurrencyCodeWithValueCopyWith<$Res>(_value.shippingDiscount!,
        (value) {
      return _then(_value.copyWith(shippingDiscount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BreakdownCopyWith<$Res> implements $BreakdownCopyWith<$Res> {
  factory _$$_BreakdownCopyWith(
          _$_Breakdown value, $Res Function(_$_Breakdown) then) =
      __$$_BreakdownCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'item_total') CurrencyCodeWithValue? itemTotal,
      CurrencyCodeWithValue? shipping,
      CurrencyCodeWithValue? handling,
      CurrencyCodeWithValue? insurance,
      @JsonKey(name: 'shipping_discount')
      CurrencyCodeWithValue? shippingDiscount});

  @override
  $CurrencyCodeWithValueCopyWith<$Res>? get itemTotal;
  @override
  $CurrencyCodeWithValueCopyWith<$Res>? get shipping;
  @override
  $CurrencyCodeWithValueCopyWith<$Res>? get handling;
  @override
  $CurrencyCodeWithValueCopyWith<$Res>? get insurance;
  @override
  $CurrencyCodeWithValueCopyWith<$Res>? get shippingDiscount;
}

/// @nodoc
class __$$_BreakdownCopyWithImpl<$Res>
    extends _$BreakdownCopyWithImpl<$Res, _$_Breakdown>
    implements _$$_BreakdownCopyWith<$Res> {
  __$$_BreakdownCopyWithImpl(
      _$_Breakdown _value, $Res Function(_$_Breakdown) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? itemTotal = freezed,
    Object? shipping = freezed,
    Object? handling = freezed,
    Object? insurance = freezed,
    Object? shippingDiscount = freezed,
  }) {
    return _then(_$_Breakdown(
      itemTotal: freezed == itemTotal
          ? _value.itemTotal
          : itemTotal // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      shipping: freezed == shipping
          ? _value.shipping
          : shipping // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      handling: freezed == handling
          ? _value.handling
          : handling // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      insurance: freezed == insurance
          ? _value.insurance
          : insurance // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      shippingDiscount: freezed == shippingDiscount
          ? _value.shippingDiscount
          : shippingDiscount // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Breakdown implements _Breakdown {
  const _$_Breakdown(
      {@JsonKey(name: 'item_total') this.itemTotal,
      this.shipping,
      this.handling,
      this.insurance,
      @JsonKey(name: 'shipping_discount') this.shippingDiscount});

  factory _$_Breakdown.fromJson(Map<String, dynamic> json) =>
      _$$_BreakdownFromJson(json);

  @override
  @JsonKey(name: 'item_total')
  final CurrencyCodeWithValue? itemTotal;
  @override
  final CurrencyCodeWithValue? shipping;
  @override
  final CurrencyCodeWithValue? handling;
  @override
  final CurrencyCodeWithValue? insurance;
  @override
  @JsonKey(name: 'shipping_discount')
  final CurrencyCodeWithValue? shippingDiscount;

  @override
  String toString() {
    return 'Breakdown(itemTotal: $itemTotal, shipping: $shipping, handling: $handling, insurance: $insurance, shippingDiscount: $shippingDiscount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Breakdown &&
            (identical(other.itemTotal, itemTotal) ||
                other.itemTotal == itemTotal) &&
            (identical(other.shipping, shipping) ||
                other.shipping == shipping) &&
            (identical(other.handling, handling) ||
                other.handling == handling) &&
            (identical(other.insurance, insurance) ||
                other.insurance == insurance) &&
            (identical(other.shippingDiscount, shippingDiscount) ||
                other.shippingDiscount == shippingDiscount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, itemTotal, shipping, handling, insurance, shippingDiscount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BreakdownCopyWith<_$_Breakdown> get copyWith =>
      __$$_BreakdownCopyWithImpl<_$_Breakdown>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BreakdownToJson(
      this,
    );
  }
}

abstract class _Breakdown implements Breakdown {
  const factory _Breakdown(
      {@JsonKey(name: 'item_total') final CurrencyCodeWithValue? itemTotal,
      final CurrencyCodeWithValue? shipping,
      final CurrencyCodeWithValue? handling,
      final CurrencyCodeWithValue? insurance,
      @JsonKey(name: 'shipping_discount')
      final CurrencyCodeWithValue? shippingDiscount}) = _$_Breakdown;

  factory _Breakdown.fromJson(Map<String, dynamic> json) =
      _$_Breakdown.fromJson;

  @override
  @JsonKey(name: 'item_total')
  CurrencyCodeWithValue? get itemTotal;
  @override
  CurrencyCodeWithValue? get shipping;
  @override
  CurrencyCodeWithValue? get handling;
  @override
  CurrencyCodeWithValue? get insurance;
  @override
  @JsonKey(name: 'shipping_discount')
  CurrencyCodeWithValue? get shippingDiscount;
  @override
  @JsonKey(ignore: true)
  _$$_BreakdownCopyWith<_$_Breakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

CurrencyCodeWithValue _$CurrencyCodeWithValueFromJson(
    Map<String, dynamic> json) {
  return _CurrencyCodeWithValue.fromJson(json);
}

/// @nodoc
mixin _$CurrencyCodeWithValue {
  @JsonKey(name: 'currency_code')
  String? get currencyCode => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CurrencyCodeWithValueCopyWith<CurrencyCodeWithValue> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CurrencyCodeWithValueCopyWith<$Res> {
  factory $CurrencyCodeWithValueCopyWith(CurrencyCodeWithValue value,
          $Res Function(CurrencyCodeWithValue) then) =
      _$CurrencyCodeWithValueCopyWithImpl<$Res, CurrencyCodeWithValue>;
  @useResult
  $Res call(
      {@JsonKey(name: 'currency_code') String? currencyCode, String? value});
}

/// @nodoc
class _$CurrencyCodeWithValueCopyWithImpl<$Res,
        $Val extends CurrencyCodeWithValue>
    implements $CurrencyCodeWithValueCopyWith<$Res> {
  _$CurrencyCodeWithValueCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currencyCode = freezed,
    Object? value = freezed,
  }) {
    return _then(_value.copyWith(
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CurrencyCodeWithValueCopyWith<$Res>
    implements $CurrencyCodeWithValueCopyWith<$Res> {
  factory _$$_CurrencyCodeWithValueCopyWith(_$_CurrencyCodeWithValue value,
          $Res Function(_$_CurrencyCodeWithValue) then) =
      __$$_CurrencyCodeWithValueCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'currency_code') String? currencyCode, String? value});
}

/// @nodoc
class __$$_CurrencyCodeWithValueCopyWithImpl<$Res>
    extends _$CurrencyCodeWithValueCopyWithImpl<$Res, _$_CurrencyCodeWithValue>
    implements _$$_CurrencyCodeWithValueCopyWith<$Res> {
  __$$_CurrencyCodeWithValueCopyWithImpl(_$_CurrencyCodeWithValue _value,
      $Res Function(_$_CurrencyCodeWithValue) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currencyCode = freezed,
    Object? value = freezed,
  }) {
    return _then(_$_CurrencyCodeWithValue(
      currencyCode: freezed == currencyCode
          ? _value.currencyCode
          : currencyCode // ignore: cast_nullable_to_non_nullable
              as String?,
      value: freezed == value
          ? _value.value
          : value // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CurrencyCodeWithValue implements _CurrencyCodeWithValue {
  const _$_CurrencyCodeWithValue(
      {@JsonKey(name: 'currency_code') this.currencyCode, this.value});

  factory _$_CurrencyCodeWithValue.fromJson(Map<String, dynamic> json) =>
      _$$_CurrencyCodeWithValueFromJson(json);

  @override
  @JsonKey(name: 'currency_code')
  final String? currencyCode;
  @override
  final String? value;

  @override
  String toString() {
    return 'CurrencyCodeWithValue(currencyCode: $currencyCode, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CurrencyCodeWithValue &&
            (identical(other.currencyCode, currencyCode) ||
                other.currencyCode == currencyCode) &&
            (identical(other.value, value) || other.value == value));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, currencyCode, value);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CurrencyCodeWithValueCopyWith<_$_CurrencyCodeWithValue> get copyWith =>
      __$$_CurrencyCodeWithValueCopyWithImpl<_$_CurrencyCodeWithValue>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CurrencyCodeWithValueToJson(
      this,
    );
  }
}

abstract class _CurrencyCodeWithValue implements CurrencyCodeWithValue {
  const factory _CurrencyCodeWithValue(
      {@JsonKey(name: 'currency_code') final String? currencyCode,
      final String? value}) = _$_CurrencyCodeWithValue;

  factory _CurrencyCodeWithValue.fromJson(Map<String, dynamic> json) =
      _$_CurrencyCodeWithValue.fromJson;

  @override
  @JsonKey(name: 'currency_code')
  String? get currencyCode;
  @override
  String? get value;
  @override
  @JsonKey(ignore: true)
  _$$_CurrencyCodeWithValueCopyWith<_$_CurrencyCodeWithValue> get copyWith =>
      throw _privateConstructorUsedError;
}

Payee _$PayeeFromJson(Map<String, dynamic> json) {
  return _Payee.fromJson(json);
}

/// @nodoc
mixin _$Payee {
  @JsonKey(name: 'email_address')
  String? get emailAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'merchant_id')
  String? get merchantId => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayeeCopyWith<Payee> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayeeCopyWith<$Res> {
  factory $PayeeCopyWith(Payee value, $Res Function(Payee) then) =
      _$PayeeCopyWithImpl<$Res, Payee>;
  @useResult
  $Res call(
      {@JsonKey(name: 'email_address') String? emailAddress,
      @JsonKey(name: 'merchant_id') String? merchantId});
}

/// @nodoc
class _$PayeeCopyWithImpl<$Res, $Val extends Payee>
    implements $PayeeCopyWith<$Res> {
  _$PayeeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailAddress = freezed,
    Object? merchantId = freezed,
  }) {
    return _then(_value.copyWith(
      emailAddress: freezed == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      merchantId: freezed == merchantId
          ? _value.merchantId
          : merchantId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PayeeCopyWith<$Res> implements $PayeeCopyWith<$Res> {
  factory _$$_PayeeCopyWith(_$_Payee value, $Res Function(_$_Payee) then) =
      __$$_PayeeCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'email_address') String? emailAddress,
      @JsonKey(name: 'merchant_id') String? merchantId});
}

/// @nodoc
class __$$_PayeeCopyWithImpl<$Res> extends _$PayeeCopyWithImpl<$Res, _$_Payee>
    implements _$$_PayeeCopyWith<$Res> {
  __$$_PayeeCopyWithImpl(_$_Payee _value, $Res Function(_$_Payee) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? emailAddress = freezed,
    Object? merchantId = freezed,
  }) {
    return _then(_$_Payee(
      emailAddress: freezed == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      merchantId: freezed == merchantId
          ? _value.merchantId
          : merchantId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Payee implements _Payee {
  const _$_Payee(
      {@JsonKey(name: 'email_address') this.emailAddress,
      @JsonKey(name: 'merchant_id') this.merchantId});

  factory _$_Payee.fromJson(Map<String, dynamic> json) =>
      _$$_PayeeFromJson(json);

  @override
  @JsonKey(name: 'email_address')
  final String? emailAddress;
  @override
  @JsonKey(name: 'merchant_id')
  final String? merchantId;

  @override
  String toString() {
    return 'Payee(emailAddress: $emailAddress, merchantId: $merchantId)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Payee &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.merchantId, merchantId) ||
                other.merchantId == merchantId));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, emailAddress, merchantId);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PayeeCopyWith<_$_Payee> get copyWith =>
      __$$_PayeeCopyWithImpl<_$_Payee>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayeeToJson(
      this,
    );
  }
}

abstract class _Payee implements Payee {
  const factory _Payee(
      {@JsonKey(name: 'email_address') final String? emailAddress,
      @JsonKey(name: 'merchant_id') final String? merchantId}) = _$_Payee;

  factory _Payee.fromJson(Map<String, dynamic> json) = _$_Payee.fromJson;

  @override
  @JsonKey(name: 'email_address')
  String? get emailAddress;
  @override
  @JsonKey(name: 'merchant_id')
  String? get merchantId;
  @override
  @JsonKey(ignore: true)
  _$$_PayeeCopyWith<_$_Payee> get copyWith =>
      throw _privateConstructorUsedError;
}

Items _$ItemsFromJson(Map<String, dynamic> json) {
  return _Items.fromJson(json);
}

/// @nodoc
mixin _$Items {
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'unit_amount')
  CurrencyCodeWithValue? get unitAmount => throw _privateConstructorUsedError;
  CurrencyCodeWithValue? get tax => throw _privateConstructorUsedError;
  String? get quantity => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_url')
  String? get imageUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemsCopyWith<Items> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemsCopyWith<$Res> {
  factory $ItemsCopyWith(Items value, $Res Function(Items) then) =
      _$ItemsCopyWithImpl<$Res, Items>;
  @useResult
  $Res call(
      {String? name,
      @JsonKey(name: 'unit_amount') CurrencyCodeWithValue? unitAmount,
      CurrencyCodeWithValue? tax,
      String? quantity,
      String? description,
      @JsonKey(name: 'image_url') String? imageUrl});

  $CurrencyCodeWithValueCopyWith<$Res>? get unitAmount;
  $CurrencyCodeWithValueCopyWith<$Res>? get tax;
}

/// @nodoc
class _$ItemsCopyWithImpl<$Res, $Val extends Items>
    implements $ItemsCopyWith<$Res> {
  _$ItemsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? unitAmount = freezed,
    Object? tax = freezed,
    Object? quantity = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      unitAmount: freezed == unitAmount
          ? _value.unitAmount
          : unitAmount // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      tax: freezed == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrencyCodeWithValueCopyWith<$Res>? get unitAmount {
    if (_value.unitAmount == null) {
      return null;
    }

    return $CurrencyCodeWithValueCopyWith<$Res>(_value.unitAmount!, (value) {
      return _then(_value.copyWith(unitAmount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrencyCodeWithValueCopyWith<$Res>? get tax {
    if (_value.tax == null) {
      return null;
    }

    return $CurrencyCodeWithValueCopyWith<$Res>(_value.tax!, (value) {
      return _then(_value.copyWith(tax: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ItemsCopyWith<$Res> implements $ItemsCopyWith<$Res> {
  factory _$$_ItemsCopyWith(_$_Items value, $Res Function(_$_Items) then) =
      __$$_ItemsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? name,
      @JsonKey(name: 'unit_amount') CurrencyCodeWithValue? unitAmount,
      CurrencyCodeWithValue? tax,
      String? quantity,
      String? description,
      @JsonKey(name: 'image_url') String? imageUrl});

  @override
  $CurrencyCodeWithValueCopyWith<$Res>? get unitAmount;
  @override
  $CurrencyCodeWithValueCopyWith<$Res>? get tax;
}

/// @nodoc
class __$$_ItemsCopyWithImpl<$Res> extends _$ItemsCopyWithImpl<$Res, _$_Items>
    implements _$$_ItemsCopyWith<$Res> {
  __$$_ItemsCopyWithImpl(_$_Items _value, $Res Function(_$_Items) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? unitAmount = freezed,
    Object? tax = freezed,
    Object? quantity = freezed,
    Object? description = freezed,
    Object? imageUrl = freezed,
  }) {
    return _then(_$_Items(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      unitAmount: freezed == unitAmount
          ? _value.unitAmount
          : unitAmount // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      tax: freezed == tax
          ? _value.tax
          : tax // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      imageUrl: freezed == imageUrl
          ? _value.imageUrl
          : imageUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Items implements _Items {
  const _$_Items(
      {this.name,
      @JsonKey(name: 'unit_amount') this.unitAmount,
      this.tax,
      this.quantity,
      this.description,
      @JsonKey(name: 'image_url') this.imageUrl});

  factory _$_Items.fromJson(Map<String, dynamic> json) =>
      _$$_ItemsFromJson(json);

  @override
  final String? name;
  @override
  @JsonKey(name: 'unit_amount')
  final CurrencyCodeWithValue? unitAmount;
  @override
  final CurrencyCodeWithValue? tax;
  @override
  final String? quantity;
  @override
  final String? description;
  @override
  @JsonKey(name: 'image_url')
  final String? imageUrl;

  @override
  String toString() {
    return 'Items(name: $name, unitAmount: $unitAmount, tax: $tax, quantity: $quantity, description: $description, imageUrl: $imageUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Items &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unitAmount, unitAmount) ||
                other.unitAmount == unitAmount) &&
            (identical(other.tax, tax) || other.tax == tax) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.imageUrl, imageUrl) ||
                other.imageUrl == imageUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, name, unitAmount, tax, quantity, description, imageUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ItemsCopyWith<_$_Items> get copyWith =>
      __$$_ItemsCopyWithImpl<_$_Items>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ItemsToJson(
      this,
    );
  }
}

abstract class _Items implements Items {
  const factory _Items(
      {final String? name,
      @JsonKey(name: 'unit_amount') final CurrencyCodeWithValue? unitAmount,
      final CurrencyCodeWithValue? tax,
      final String? quantity,
      final String? description,
      @JsonKey(name: 'image_url') final String? imageUrl}) = _$_Items;

  factory _Items.fromJson(Map<String, dynamic> json) = _$_Items.fromJson;

  @override
  String? get name;
  @override
  @JsonKey(name: 'unit_amount')
  CurrencyCodeWithValue? get unitAmount;
  @override
  CurrencyCodeWithValue? get tax;
  @override
  String? get quantity;
  @override
  String? get description;
  @override
  @JsonKey(name: 'image_url')
  String? get imageUrl;
  @override
  @JsonKey(ignore: true)
  _$$_ItemsCopyWith<_$_Items> get copyWith =>
      throw _privateConstructorUsedError;
}

ShippingAddress _$ShippingAddressFromJson(Map<String, dynamic> json) {
  return _ShippingAddress.fromJson(json);
}

/// @nodoc
mixin _$ShippingAddress {
  Name? get name => throw _privateConstructorUsedError;
  ShippingAddressFull? get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShippingAddressCopyWith<ShippingAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShippingAddressCopyWith<$Res> {
  factory $ShippingAddressCopyWith(
          ShippingAddress value, $Res Function(ShippingAddress) then) =
      _$ShippingAddressCopyWithImpl<$Res, ShippingAddress>;
  @useResult
  $Res call({Name? name, ShippingAddressFull? address});

  $NameCopyWith<$Res>? get name;
  $ShippingAddressFullCopyWith<$Res>? get address;
}

/// @nodoc
class _$ShippingAddressCopyWithImpl<$Res, $Val extends ShippingAddress>
    implements $ShippingAddressCopyWith<$Res> {
  _$ShippingAddressCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Name?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as ShippingAddressFull?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NameCopyWith<$Res>? get name {
    if (_value.name == null) {
      return null;
    }

    return $NameCopyWith<$Res>(_value.name!, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ShippingAddressFullCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $ShippingAddressFullCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ShippingAddressCopyWith<$Res>
    implements $ShippingAddressCopyWith<$Res> {
  factory _$$_ShippingAddressCopyWith(
          _$_ShippingAddress value, $Res Function(_$_ShippingAddress) then) =
      __$$_ShippingAddressCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({Name? name, ShippingAddressFull? address});

  @override
  $NameCopyWith<$Res>? get name;
  @override
  $ShippingAddressFullCopyWith<$Res>? get address;
}

/// @nodoc
class __$$_ShippingAddressCopyWithImpl<$Res>
    extends _$ShippingAddressCopyWithImpl<$Res, _$_ShippingAddress>
    implements _$$_ShippingAddressCopyWith<$Res> {
  __$$_ShippingAddressCopyWithImpl(
      _$_ShippingAddress _value, $Res Function(_$_ShippingAddress) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? address = freezed,
  }) {
    return _then(_$_ShippingAddress(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Name?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as ShippingAddressFull?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShippingAddress implements _ShippingAddress {
  const _$_ShippingAddress({this.name, this.address});

  factory _$_ShippingAddress.fromJson(Map<String, dynamic> json) =>
      _$$_ShippingAddressFromJson(json);

  @override
  final Name? name;
  @override
  final ShippingAddressFull? address;

  @override
  String toString() {
    return 'ShippingAddress(name: $name, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShippingAddress &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShippingAddressCopyWith<_$_ShippingAddress> get copyWith =>
      __$$_ShippingAddressCopyWithImpl<_$_ShippingAddress>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShippingAddressToJson(
      this,
    );
  }
}

abstract class _ShippingAddress implements ShippingAddress {
  const factory _ShippingAddress(
      {final Name? name,
      final ShippingAddressFull? address}) = _$_ShippingAddress;

  factory _ShippingAddress.fromJson(Map<String, dynamic> json) =
      _$_ShippingAddress.fromJson;

  @override
  Name? get name;
  @override
  ShippingAddressFull? get address;
  @override
  @JsonKey(ignore: true)
  _$$_ShippingAddressCopyWith<_$_ShippingAddress> get copyWith =>
      throw _privateConstructorUsedError;
}

ShippingAddressFull _$ShippingAddressFullFromJson(Map<String, dynamic> json) {
  return _ShippingAddressFull.fromJson(json);
}

/// @nodoc
mixin _$ShippingAddressFull {
  @JsonKey(name: 'address_line_1')
  String? get addressLine1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_area_2')
  String? get adminArea2 => throw _privateConstructorUsedError;
  @JsonKey(name: 'admin_area_1')
  String? get adminArea1 => throw _privateConstructorUsedError;
  @JsonKey(name: 'postal_code')
  String? get postalCode => throw _privateConstructorUsedError;
  @JsonKey(name: 'country_code')
  String? get countryCode => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ShippingAddressFullCopyWith<ShippingAddressFull> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ShippingAddressFullCopyWith<$Res> {
  factory $ShippingAddressFullCopyWith(
          ShippingAddressFull value, $Res Function(ShippingAddressFull) then) =
      _$ShippingAddressFullCopyWithImpl<$Res, ShippingAddressFull>;
  @useResult
  $Res call(
      {@JsonKey(name: 'address_line_1') String? addressLine1,
      @JsonKey(name: 'admin_area_2') String? adminArea2,
      @JsonKey(name: 'admin_area_1') String? adminArea1,
      @JsonKey(name: 'postal_code') String? postalCode,
      @JsonKey(name: 'country_code') String? countryCode});
}

/// @nodoc
class _$ShippingAddressFullCopyWithImpl<$Res, $Val extends ShippingAddressFull>
    implements $ShippingAddressFullCopyWith<$Res> {
  _$ShippingAddressFullCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addressLine1 = freezed,
    Object? adminArea2 = freezed,
    Object? adminArea1 = freezed,
    Object? postalCode = freezed,
    Object? countryCode = freezed,
  }) {
    return _then(_value.copyWith(
      addressLine1: freezed == addressLine1
          ? _value.addressLine1
          : addressLine1 // ignore: cast_nullable_to_non_nullable
              as String?,
      adminArea2: freezed == adminArea2
          ? _value.adminArea2
          : adminArea2 // ignore: cast_nullable_to_non_nullable
              as String?,
      adminArea1: freezed == adminArea1
          ? _value.adminArea1
          : adminArea1 // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ShippingAddressFullCopyWith<$Res>
    implements $ShippingAddressFullCopyWith<$Res> {
  factory _$$_ShippingAddressFullCopyWith(_$_ShippingAddressFull value,
          $Res Function(_$_ShippingAddressFull) then) =
      __$$_ShippingAddressFullCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'address_line_1') String? addressLine1,
      @JsonKey(name: 'admin_area_2') String? adminArea2,
      @JsonKey(name: 'admin_area_1') String? adminArea1,
      @JsonKey(name: 'postal_code') String? postalCode,
      @JsonKey(name: 'country_code') String? countryCode});
}

/// @nodoc
class __$$_ShippingAddressFullCopyWithImpl<$Res>
    extends _$ShippingAddressFullCopyWithImpl<$Res, _$_ShippingAddressFull>
    implements _$$_ShippingAddressFullCopyWith<$Res> {
  __$$_ShippingAddressFullCopyWithImpl(_$_ShippingAddressFull _value,
      $Res Function(_$_ShippingAddressFull) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? addressLine1 = freezed,
    Object? adminArea2 = freezed,
    Object? adminArea1 = freezed,
    Object? postalCode = freezed,
    Object? countryCode = freezed,
  }) {
    return _then(_$_ShippingAddressFull(
      addressLine1: freezed == addressLine1
          ? _value.addressLine1
          : addressLine1 // ignore: cast_nullable_to_non_nullable
              as String?,
      adminArea2: freezed == adminArea2
          ? _value.adminArea2
          : adminArea2 // ignore: cast_nullable_to_non_nullable
              as String?,
      adminArea1: freezed == adminArea1
          ? _value.adminArea1
          : adminArea1 // ignore: cast_nullable_to_non_nullable
              as String?,
      postalCode: freezed == postalCode
          ? _value.postalCode
          : postalCode // ignore: cast_nullable_to_non_nullable
              as String?,
      countryCode: freezed == countryCode
          ? _value.countryCode
          : countryCode // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ShippingAddressFull implements _ShippingAddressFull {
  const _$_ShippingAddressFull(
      {@JsonKey(name: 'address_line_1') this.addressLine1,
      @JsonKey(name: 'admin_area_2') this.adminArea2,
      @JsonKey(name: 'admin_area_1') this.adminArea1,
      @JsonKey(name: 'postal_code') this.postalCode,
      @JsonKey(name: 'country_code') this.countryCode});

  factory _$_ShippingAddressFull.fromJson(Map<String, dynamic> json) =>
      _$$_ShippingAddressFullFromJson(json);

  @override
  @JsonKey(name: 'address_line_1')
  final String? addressLine1;
  @override
  @JsonKey(name: 'admin_area_2')
  final String? adminArea2;
  @override
  @JsonKey(name: 'admin_area_1')
  final String? adminArea1;
  @override
  @JsonKey(name: 'postal_code')
  final String? postalCode;
  @override
  @JsonKey(name: 'country_code')
  final String? countryCode;

  @override
  String toString() {
    return 'ShippingAddressFull(addressLine1: $addressLine1, adminArea2: $adminArea2, adminArea1: $adminArea1, postalCode: $postalCode, countryCode: $countryCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ShippingAddressFull &&
            (identical(other.addressLine1, addressLine1) ||
                other.addressLine1 == addressLine1) &&
            (identical(other.adminArea2, adminArea2) ||
                other.adminArea2 == adminArea2) &&
            (identical(other.adminArea1, adminArea1) ||
                other.adminArea1 == adminArea1) &&
            (identical(other.postalCode, postalCode) ||
                other.postalCode == postalCode) &&
            (identical(other.countryCode, countryCode) ||
                other.countryCode == countryCode));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, addressLine1, adminArea2,
      adminArea1, postalCode, countryCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ShippingAddressFullCopyWith<_$_ShippingAddressFull> get copyWith =>
      __$$_ShippingAddressFullCopyWithImpl<_$_ShippingAddressFull>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ShippingAddressFullToJson(
      this,
    );
  }
}

abstract class _ShippingAddressFull implements ShippingAddressFull {
  const factory _ShippingAddressFull(
          {@JsonKey(name: 'address_line_1') final String? addressLine1,
          @JsonKey(name: 'admin_area_2') final String? adminArea2,
          @JsonKey(name: 'admin_area_1') final String? adminArea1,
          @JsonKey(name: 'postal_code') final String? postalCode,
          @JsonKey(name: 'country_code') final String? countryCode}) =
      _$_ShippingAddressFull;

  factory _ShippingAddressFull.fromJson(Map<String, dynamic> json) =
      _$_ShippingAddressFull.fromJson;

  @override
  @JsonKey(name: 'address_line_1')
  String? get addressLine1;
  @override
  @JsonKey(name: 'admin_area_2')
  String? get adminArea2;
  @override
  @JsonKey(name: 'admin_area_1')
  String? get adminArea1;
  @override
  @JsonKey(name: 'postal_code')
  String? get postalCode;
  @override
  @JsonKey(name: 'country_code')
  String? get countryCode;
  @override
  @JsonKey(ignore: true)
  _$$_ShippingAddressFullCopyWith<_$_ShippingAddressFull> get copyWith =>
      throw _privateConstructorUsedError;
}

Payments _$PaymentsFromJson(Map<String, dynamic> json) {
  return _Payments.fromJson(json);
}

/// @nodoc
mixin _$Payments {
  List<Captures>? get captures => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentsCopyWith<Payments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentsCopyWith<$Res> {
  factory $PaymentsCopyWith(Payments value, $Res Function(Payments) then) =
      _$PaymentsCopyWithImpl<$Res, Payments>;
  @useResult
  $Res call({List<Captures>? captures});
}

/// @nodoc
class _$PaymentsCopyWithImpl<$Res, $Val extends Payments>
    implements $PaymentsCopyWith<$Res> {
  _$PaymentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? captures = freezed,
  }) {
    return _then(_value.copyWith(
      captures: freezed == captures
          ? _value.captures
          : captures // ignore: cast_nullable_to_non_nullable
              as List<Captures>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaymentsCopyWith<$Res> implements $PaymentsCopyWith<$Res> {
  factory _$$_PaymentsCopyWith(
          _$_Payments value, $Res Function(_$_Payments) then) =
      __$$_PaymentsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Captures>? captures});
}

/// @nodoc
class __$$_PaymentsCopyWithImpl<$Res>
    extends _$PaymentsCopyWithImpl<$Res, _$_Payments>
    implements _$$_PaymentsCopyWith<$Res> {
  __$$_PaymentsCopyWithImpl(
      _$_Payments _value, $Res Function(_$_Payments) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? captures = freezed,
  }) {
    return _then(_$_Payments(
      captures: freezed == captures
          ? _value._captures
          : captures // ignore: cast_nullable_to_non_nullable
              as List<Captures>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Payments implements _Payments {
  const _$_Payments({final List<Captures>? captures}) : _captures = captures;

  factory _$_Payments.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentsFromJson(json);

  final List<Captures>? _captures;
  @override
  List<Captures>? get captures {
    final value = _captures;
    if (value == null) return null;
    if (_captures is EqualUnmodifiableListView) return _captures;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Payments(captures: $captures)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Payments &&
            const DeepCollectionEquality().equals(other._captures, _captures));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_captures));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentsCopyWith<_$_Payments> get copyWith =>
      __$$_PaymentsCopyWithImpl<_$_Payments>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentsToJson(
      this,
    );
  }
}

abstract class _Payments implements Payments {
  const factory _Payments({final List<Captures>? captures}) = _$_Payments;

  factory _Payments.fromJson(Map<String, dynamic> json) = _$_Payments.fromJson;

  @override
  List<Captures>? get captures;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentsCopyWith<_$_Payments> get copyWith =>
      throw _privateConstructorUsedError;
}

Captures _$CapturesFromJson(Map<String, dynamic> json) {
  return _Captures.fromJson(json);
}

/// @nodoc
mixin _$Captures {
  String? get id => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  Amount? get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'final_capture')
  bool? get finalCapture => throw _privateConstructorUsedError;
  @JsonKey(name: 'seller_protection')
  SellerProtection? get sellerProtection => throw _privateConstructorUsedError;
  @JsonKey(name: 'seller_receivable_breakdown')
  SellerReceivableBreakdown? get sellerReceivableBreakdown =>
      throw _privateConstructorUsedError;
  List<Links>? get links => throw _privateConstructorUsedError;
  @JsonKey(name: 'create_time')
  String? get createTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'update_time')
  String? get updateTime => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CapturesCopyWith<Captures> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CapturesCopyWith<$Res> {
  factory $CapturesCopyWith(Captures value, $Res Function(Captures) then) =
      _$CapturesCopyWithImpl<$Res, Captures>;
  @useResult
  $Res call(
      {String? id,
      String? status,
      Amount? amount,
      @JsonKey(name: 'final_capture') bool? finalCapture,
      @JsonKey(name: 'seller_protection') SellerProtection? sellerProtection,
      @JsonKey(name: 'seller_receivable_breakdown')
      SellerReceivableBreakdown? sellerReceivableBreakdown,
      List<Links>? links,
      @JsonKey(name: 'create_time') String? createTime,
      @JsonKey(name: 'update_time') String? updateTime});

  $AmountCopyWith<$Res>? get amount;
  $SellerProtectionCopyWith<$Res>? get sellerProtection;
  $SellerReceivableBreakdownCopyWith<$Res>? get sellerReceivableBreakdown;
}

/// @nodoc
class _$CapturesCopyWithImpl<$Res, $Val extends Captures>
    implements $CapturesCopyWith<$Res> {
  _$CapturesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? amount = freezed,
    Object? finalCapture = freezed,
    Object? sellerProtection = freezed,
    Object? sellerReceivableBreakdown = freezed,
    Object? links = freezed,
    Object? createTime = freezed,
    Object? updateTime = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Amount?,
      finalCapture: freezed == finalCapture
          ? _value.finalCapture
          : finalCapture // ignore: cast_nullable_to_non_nullable
              as bool?,
      sellerProtection: freezed == sellerProtection
          ? _value.sellerProtection
          : sellerProtection // ignore: cast_nullable_to_non_nullable
              as SellerProtection?,
      sellerReceivableBreakdown: freezed == sellerReceivableBreakdown
          ? _value.sellerReceivableBreakdown
          : sellerReceivableBreakdown // ignore: cast_nullable_to_non_nullable
              as SellerReceivableBreakdown?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Links>?,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      updateTime: freezed == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $AmountCopyWith<$Res>? get amount {
    if (_value.amount == null) {
      return null;
    }

    return $AmountCopyWith<$Res>(_value.amount!, (value) {
      return _then(_value.copyWith(amount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SellerProtectionCopyWith<$Res>? get sellerProtection {
    if (_value.sellerProtection == null) {
      return null;
    }

    return $SellerProtectionCopyWith<$Res>(_value.sellerProtection!, (value) {
      return _then(_value.copyWith(sellerProtection: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SellerReceivableBreakdownCopyWith<$Res>? get sellerReceivableBreakdown {
    if (_value.sellerReceivableBreakdown == null) {
      return null;
    }

    return $SellerReceivableBreakdownCopyWith<$Res>(
        _value.sellerReceivableBreakdown!, (value) {
      return _then(_value.copyWith(sellerReceivableBreakdown: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_CapturesCopyWith<$Res> implements $CapturesCopyWith<$Res> {
  factory _$$_CapturesCopyWith(
          _$_Captures value, $Res Function(_$_Captures) then) =
      __$$_CapturesCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? status,
      Amount? amount,
      @JsonKey(name: 'final_capture') bool? finalCapture,
      @JsonKey(name: 'seller_protection') SellerProtection? sellerProtection,
      @JsonKey(name: 'seller_receivable_breakdown')
      SellerReceivableBreakdown? sellerReceivableBreakdown,
      List<Links>? links,
      @JsonKey(name: 'create_time') String? createTime,
      @JsonKey(name: 'update_time') String? updateTime});

  @override
  $AmountCopyWith<$Res>? get amount;
  @override
  $SellerProtectionCopyWith<$Res>? get sellerProtection;
  @override
  $SellerReceivableBreakdownCopyWith<$Res>? get sellerReceivableBreakdown;
}

/// @nodoc
class __$$_CapturesCopyWithImpl<$Res>
    extends _$CapturesCopyWithImpl<$Res, _$_Captures>
    implements _$$_CapturesCopyWith<$Res> {
  __$$_CapturesCopyWithImpl(
      _$_Captures _value, $Res Function(_$_Captures) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? status = freezed,
    Object? amount = freezed,
    Object? finalCapture = freezed,
    Object? sellerProtection = freezed,
    Object? sellerReceivableBreakdown = freezed,
    Object? links = freezed,
    Object? createTime = freezed,
    Object? updateTime = freezed,
  }) {
    return _then(_$_Captures(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Amount?,
      finalCapture: freezed == finalCapture
          ? _value.finalCapture
          : finalCapture // ignore: cast_nullable_to_non_nullable
              as bool?,
      sellerProtection: freezed == sellerProtection
          ? _value.sellerProtection
          : sellerProtection // ignore: cast_nullable_to_non_nullable
              as SellerProtection?,
      sellerReceivableBreakdown: freezed == sellerReceivableBreakdown
          ? _value.sellerReceivableBreakdown
          : sellerReceivableBreakdown // ignore: cast_nullable_to_non_nullable
              as SellerReceivableBreakdown?,
      links: freezed == links
          ? _value._links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Links>?,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      updateTime: freezed == updateTime
          ? _value.updateTime
          : updateTime // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Captures implements _Captures {
  const _$_Captures(
      {this.id,
      this.status,
      this.amount,
      @JsonKey(name: 'final_capture') this.finalCapture,
      @JsonKey(name: 'seller_protection') this.sellerProtection,
      @JsonKey(name: 'seller_receivable_breakdown')
      this.sellerReceivableBreakdown,
      final List<Links>? links,
      @JsonKey(name: 'create_time') this.createTime,
      @JsonKey(name: 'update_time') this.updateTime})
      : _links = links;

  factory _$_Captures.fromJson(Map<String, dynamic> json) =>
      _$$_CapturesFromJson(json);

  @override
  final String? id;
  @override
  final String? status;
  @override
  final Amount? amount;
  @override
  @JsonKey(name: 'final_capture')
  final bool? finalCapture;
  @override
  @JsonKey(name: 'seller_protection')
  final SellerProtection? sellerProtection;
  @override
  @JsonKey(name: 'seller_receivable_breakdown')
  final SellerReceivableBreakdown? sellerReceivableBreakdown;
  final List<Links>? _links;
  @override
  List<Links>? get links {
    final value = _links;
    if (value == null) return null;
    if (_links is EqualUnmodifiableListView) return _links;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'create_time')
  final String? createTime;
  @override
  @JsonKey(name: 'update_time')
  final String? updateTime;

  @override
  String toString() {
    return 'Captures(id: $id, status: $status, amount: $amount, finalCapture: $finalCapture, sellerProtection: $sellerProtection, sellerReceivableBreakdown: $sellerReceivableBreakdown, links: $links, createTime: $createTime, updateTime: $updateTime)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Captures &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.finalCapture, finalCapture) ||
                other.finalCapture == finalCapture) &&
            (identical(other.sellerProtection, sellerProtection) ||
                other.sellerProtection == sellerProtection) &&
            (identical(other.sellerReceivableBreakdown,
                    sellerReceivableBreakdown) ||
                other.sellerReceivableBreakdown == sellerReceivableBreakdown) &&
            const DeepCollectionEquality().equals(other._links, _links) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            (identical(other.updateTime, updateTime) ||
                other.updateTime == updateTime));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      status,
      amount,
      finalCapture,
      sellerProtection,
      sellerReceivableBreakdown,
      const DeepCollectionEquality().hash(_links),
      createTime,
      updateTime);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CapturesCopyWith<_$_Captures> get copyWith =>
      __$$_CapturesCopyWithImpl<_$_Captures>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CapturesToJson(
      this,
    );
  }
}

abstract class _Captures implements Captures {
  const factory _Captures(
      {final String? id,
      final String? status,
      final Amount? amount,
      @JsonKey(name: 'final_capture') final bool? finalCapture,
      @JsonKey(name: 'seller_protection')
      final SellerProtection? sellerProtection,
      @JsonKey(name: 'seller_receivable_breakdown')
      final SellerReceivableBreakdown? sellerReceivableBreakdown,
      final List<Links>? links,
      @JsonKey(name: 'create_time') final String? createTime,
      @JsonKey(name: 'update_time') final String? updateTime}) = _$_Captures;

  factory _Captures.fromJson(Map<String, dynamic> json) = _$_Captures.fromJson;

  @override
  String? get id;
  @override
  String? get status;
  @override
  Amount? get amount;
  @override
  @JsonKey(name: 'final_capture')
  bool? get finalCapture;
  @override
  @JsonKey(name: 'seller_protection')
  SellerProtection? get sellerProtection;
  @override
  @JsonKey(name: 'seller_receivable_breakdown')
  SellerReceivableBreakdown? get sellerReceivableBreakdown;
  @override
  List<Links>? get links;
  @override
  @JsonKey(name: 'create_time')
  String? get createTime;
  @override
  @JsonKey(name: 'update_time')
  String? get updateTime;
  @override
  @JsonKey(ignore: true)
  _$$_CapturesCopyWith<_$_Captures> get copyWith =>
      throw _privateConstructorUsedError;
}

SellerProtection _$SellerProtectionFromJson(Map<String, dynamic> json) {
  return _SellerProtection.fromJson(json);
}

/// @nodoc
mixin _$SellerProtection {
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'dispute_categories')
  List<String>? get disputeCategories => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SellerProtectionCopyWith<SellerProtection> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SellerProtectionCopyWith<$Res> {
  factory $SellerProtectionCopyWith(
          SellerProtection value, $Res Function(SellerProtection) then) =
      _$SellerProtectionCopyWithImpl<$Res, SellerProtection>;
  @useResult
  $Res call(
      {String? status,
      @JsonKey(name: 'dispute_categories') List<String>? disputeCategories});
}

/// @nodoc
class _$SellerProtectionCopyWithImpl<$Res, $Val extends SellerProtection>
    implements $SellerProtectionCopyWith<$Res> {
  _$SellerProtectionCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? disputeCategories = freezed,
  }) {
    return _then(_value.copyWith(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      disputeCategories: freezed == disputeCategories
          ? _value.disputeCategories
          : disputeCategories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SellerProtectionCopyWith<$Res>
    implements $SellerProtectionCopyWith<$Res> {
  factory _$$_SellerProtectionCopyWith(
          _$_SellerProtection value, $Res Function(_$_SellerProtection) then) =
      __$$_SellerProtectionCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? status,
      @JsonKey(name: 'dispute_categories') List<String>? disputeCategories});
}

/// @nodoc
class __$$_SellerProtectionCopyWithImpl<$Res>
    extends _$SellerProtectionCopyWithImpl<$Res, _$_SellerProtection>
    implements _$$_SellerProtectionCopyWith<$Res> {
  __$$_SellerProtectionCopyWithImpl(
      _$_SellerProtection _value, $Res Function(_$_SellerProtection) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? status = freezed,
    Object? disputeCategories = freezed,
  }) {
    return _then(_$_SellerProtection(
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as String?,
      disputeCategories: freezed == disputeCategories
          ? _value._disputeCategories
          : disputeCategories // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SellerProtection implements _SellerProtection {
  const _$_SellerProtection(
      {this.status,
      @JsonKey(name: 'dispute_categories')
      final List<String>? disputeCategories})
      : _disputeCategories = disputeCategories;

  factory _$_SellerProtection.fromJson(Map<String, dynamic> json) =>
      _$$_SellerProtectionFromJson(json);

  @override
  final String? status;
  final List<String>? _disputeCategories;
  @override
  @JsonKey(name: 'dispute_categories')
  List<String>? get disputeCategories {
    final value = _disputeCategories;
    if (value == null) return null;
    if (_disputeCategories is EqualUnmodifiableListView)
      return _disputeCategories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SellerProtection(status: $status, disputeCategories: $disputeCategories)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SellerProtection &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._disputeCategories, _disputeCategories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, status,
      const DeepCollectionEquality().hash(_disputeCategories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SellerProtectionCopyWith<_$_SellerProtection> get copyWith =>
      __$$_SellerProtectionCopyWithImpl<_$_SellerProtection>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SellerProtectionToJson(
      this,
    );
  }
}

abstract class _SellerProtection implements SellerProtection {
  const factory _SellerProtection(
      {final String? status,
      @JsonKey(name: 'dispute_categories')
      final List<String>? disputeCategories}) = _$_SellerProtection;

  factory _SellerProtection.fromJson(Map<String, dynamic> json) =
      _$_SellerProtection.fromJson;

  @override
  String? get status;
  @override
  @JsonKey(name: 'dispute_categories')
  List<String>? get disputeCategories;
  @override
  @JsonKey(ignore: true)
  _$$_SellerProtectionCopyWith<_$_SellerProtection> get copyWith =>
      throw _privateConstructorUsedError;
}

SellerReceivableBreakdown _$SellerReceivableBreakdownFromJson(
    Map<String, dynamic> json) {
  return _SellerReceivableBreakdown.fromJson(json);
}

/// @nodoc
mixin _$SellerReceivableBreakdown {
  @JsonKey(name: 'gross_amount')
  CurrencyCodeWithValue? get grossAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'paypal_fee')
  CurrencyCodeWithValue? get paypalFee => throw _privateConstructorUsedError;
  @JsonKey(name: 'net_amount')
  CurrencyCodeWithValue? get netAmount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SellerReceivableBreakdownCopyWith<SellerReceivableBreakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SellerReceivableBreakdownCopyWith<$Res> {
  factory $SellerReceivableBreakdownCopyWith(SellerReceivableBreakdown value,
          $Res Function(SellerReceivableBreakdown) then) =
      _$SellerReceivableBreakdownCopyWithImpl<$Res, SellerReceivableBreakdown>;
  @useResult
  $Res call(
      {@JsonKey(name: 'gross_amount') CurrencyCodeWithValue? grossAmount,
      @JsonKey(name: 'paypal_fee') CurrencyCodeWithValue? paypalFee,
      @JsonKey(name: 'net_amount') CurrencyCodeWithValue? netAmount});

  $CurrencyCodeWithValueCopyWith<$Res>? get grossAmount;
  $CurrencyCodeWithValueCopyWith<$Res>? get paypalFee;
  $CurrencyCodeWithValueCopyWith<$Res>? get netAmount;
}

/// @nodoc
class _$SellerReceivableBreakdownCopyWithImpl<$Res,
        $Val extends SellerReceivableBreakdown>
    implements $SellerReceivableBreakdownCopyWith<$Res> {
  _$SellerReceivableBreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grossAmount = freezed,
    Object? paypalFee = freezed,
    Object? netAmount = freezed,
  }) {
    return _then(_value.copyWith(
      grossAmount: freezed == grossAmount
          ? _value.grossAmount
          : grossAmount // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      paypalFee: freezed == paypalFee
          ? _value.paypalFee
          : paypalFee // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      netAmount: freezed == netAmount
          ? _value.netAmount
          : netAmount // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrencyCodeWithValueCopyWith<$Res>? get grossAmount {
    if (_value.grossAmount == null) {
      return null;
    }

    return $CurrencyCodeWithValueCopyWith<$Res>(_value.grossAmount!, (value) {
      return _then(_value.copyWith(grossAmount: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrencyCodeWithValueCopyWith<$Res>? get paypalFee {
    if (_value.paypalFee == null) {
      return null;
    }

    return $CurrencyCodeWithValueCopyWith<$Res>(_value.paypalFee!, (value) {
      return _then(_value.copyWith(paypalFee: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CurrencyCodeWithValueCopyWith<$Res>? get netAmount {
    if (_value.netAmount == null) {
      return null;
    }

    return $CurrencyCodeWithValueCopyWith<$Res>(_value.netAmount!, (value) {
      return _then(_value.copyWith(netAmount: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SellerReceivableBreakdownCopyWith<$Res>
    implements $SellerReceivableBreakdownCopyWith<$Res> {
  factory _$$_SellerReceivableBreakdownCopyWith(
          _$_SellerReceivableBreakdown value,
          $Res Function(_$_SellerReceivableBreakdown) then) =
      __$$_SellerReceivableBreakdownCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'gross_amount') CurrencyCodeWithValue? grossAmount,
      @JsonKey(name: 'paypal_fee') CurrencyCodeWithValue? paypalFee,
      @JsonKey(name: 'net_amount') CurrencyCodeWithValue? netAmount});

  @override
  $CurrencyCodeWithValueCopyWith<$Res>? get grossAmount;
  @override
  $CurrencyCodeWithValueCopyWith<$Res>? get paypalFee;
  @override
  $CurrencyCodeWithValueCopyWith<$Res>? get netAmount;
}

/// @nodoc
class __$$_SellerReceivableBreakdownCopyWithImpl<$Res>
    extends _$SellerReceivableBreakdownCopyWithImpl<$Res,
        _$_SellerReceivableBreakdown>
    implements _$$_SellerReceivableBreakdownCopyWith<$Res> {
  __$$_SellerReceivableBreakdownCopyWithImpl(
      _$_SellerReceivableBreakdown _value,
      $Res Function(_$_SellerReceivableBreakdown) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? grossAmount = freezed,
    Object? paypalFee = freezed,
    Object? netAmount = freezed,
  }) {
    return _then(_$_SellerReceivableBreakdown(
      grossAmount: freezed == grossAmount
          ? _value.grossAmount
          : grossAmount // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      paypalFee: freezed == paypalFee
          ? _value.paypalFee
          : paypalFee // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
      netAmount: freezed == netAmount
          ? _value.netAmount
          : netAmount // ignore: cast_nullable_to_non_nullable
              as CurrencyCodeWithValue?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SellerReceivableBreakdown implements _SellerReceivableBreakdown {
  const _$_SellerReceivableBreakdown(
      {@JsonKey(name: 'gross_amount') this.grossAmount,
      @JsonKey(name: 'paypal_fee') this.paypalFee,
      @JsonKey(name: 'net_amount') this.netAmount});

  factory _$_SellerReceivableBreakdown.fromJson(Map<String, dynamic> json) =>
      _$$_SellerReceivableBreakdownFromJson(json);

  @override
  @JsonKey(name: 'gross_amount')
  final CurrencyCodeWithValue? grossAmount;
  @override
  @JsonKey(name: 'paypal_fee')
  final CurrencyCodeWithValue? paypalFee;
  @override
  @JsonKey(name: 'net_amount')
  final CurrencyCodeWithValue? netAmount;

  @override
  String toString() {
    return 'SellerReceivableBreakdown(grossAmount: $grossAmount, paypalFee: $paypalFee, netAmount: $netAmount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SellerReceivableBreakdown &&
            (identical(other.grossAmount, grossAmount) ||
                other.grossAmount == grossAmount) &&
            (identical(other.paypalFee, paypalFee) ||
                other.paypalFee == paypalFee) &&
            (identical(other.netAmount, netAmount) ||
                other.netAmount == netAmount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, grossAmount, paypalFee, netAmount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SellerReceivableBreakdownCopyWith<_$_SellerReceivableBreakdown>
      get copyWith => __$$_SellerReceivableBreakdownCopyWithImpl<
          _$_SellerReceivableBreakdown>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SellerReceivableBreakdownToJson(
      this,
    );
  }
}

abstract class _SellerReceivableBreakdown implements SellerReceivableBreakdown {
  const factory _SellerReceivableBreakdown(
      {@JsonKey(name: 'gross_amount') final CurrencyCodeWithValue? grossAmount,
      @JsonKey(name: 'paypal_fee') final CurrencyCodeWithValue? paypalFee,
      @JsonKey(name: 'net_amount')
      final CurrencyCodeWithValue? netAmount}) = _$_SellerReceivableBreakdown;

  factory _SellerReceivableBreakdown.fromJson(Map<String, dynamic> json) =
      _$_SellerReceivableBreakdown.fromJson;

  @override
  @JsonKey(name: 'gross_amount')
  CurrencyCodeWithValue? get grossAmount;
  @override
  @JsonKey(name: 'paypal_fee')
  CurrencyCodeWithValue? get paypalFee;
  @override
  @JsonKey(name: 'net_amount')
  CurrencyCodeWithValue? get netAmount;
  @override
  @JsonKey(ignore: true)
  _$$_SellerReceivableBreakdownCopyWith<_$_SellerReceivableBreakdown>
      get copyWith => throw _privateConstructorUsedError;
}

Links _$LinksFromJson(Map<String, dynamic> json) {
  return _Links.fromJson(json);
}

/// @nodoc
mixin _$Links {
  String? get href => throw _privateConstructorUsedError;
  String? get rel => throw _privateConstructorUsedError;
  String? get method => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LinksCopyWith<Links> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LinksCopyWith<$Res> {
  factory $LinksCopyWith(Links value, $Res Function(Links) then) =
      _$LinksCopyWithImpl<$Res, Links>;
  @useResult
  $Res call({String? href, String? rel, String? method});
}

/// @nodoc
class _$LinksCopyWithImpl<$Res, $Val extends Links>
    implements $LinksCopyWith<$Res> {
  _$LinksCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? href = freezed,
    Object? rel = freezed,
    Object? method = freezed,
  }) {
    return _then(_value.copyWith(
      href: freezed == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String?,
      rel: freezed == rel
          ? _value.rel
          : rel // ignore: cast_nullable_to_non_nullable
              as String?,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LinksCopyWith<$Res> implements $LinksCopyWith<$Res> {
  factory _$$_LinksCopyWith(_$_Links value, $Res Function(_$_Links) then) =
      __$$_LinksCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String? href, String? rel, String? method});
}

/// @nodoc
class __$$_LinksCopyWithImpl<$Res> extends _$LinksCopyWithImpl<$Res, _$_Links>
    implements _$$_LinksCopyWith<$Res> {
  __$$_LinksCopyWithImpl(_$_Links _value, $Res Function(_$_Links) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? href = freezed,
    Object? rel = freezed,
    Object? method = freezed,
  }) {
    return _then(_$_Links(
      href: freezed == href
          ? _value.href
          : href // ignore: cast_nullable_to_non_nullable
              as String?,
      rel: freezed == rel
          ? _value.rel
          : rel // ignore: cast_nullable_to_non_nullable
              as String?,
      method: freezed == method
          ? _value.method
          : method // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Links implements _Links {
  const _$_Links({this.href, this.rel, this.method});

  factory _$_Links.fromJson(Map<String, dynamic> json) =>
      _$$_LinksFromJson(json);

  @override
  final String? href;
  @override
  final String? rel;
  @override
  final String? method;

  @override
  String toString() {
    return 'Links(href: $href, rel: $rel, method: $method)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Links &&
            (identical(other.href, href) || other.href == href) &&
            (identical(other.rel, rel) || other.rel == rel) &&
            (identical(other.method, method) || other.method == method));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, href, rel, method);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LinksCopyWith<_$_Links> get copyWith =>
      __$$_LinksCopyWithImpl<_$_Links>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LinksToJson(
      this,
    );
  }
}

abstract class _Links implements Links {
  const factory _Links(
      {final String? href, final String? rel, final String? method}) = _$_Links;

  factory _Links.fromJson(Map<String, dynamic> json) = _$_Links.fromJson;

  @override
  String? get href;
  @override
  String? get rel;
  @override
  String? get method;
  @override
  @JsonKey(ignore: true)
  _$$_LinksCopyWith<_$_Links> get copyWith =>
      throw _privateConstructorUsedError;
}

Payer _$PayerFromJson(Map<String, dynamic> json) {
  return _Payer.fromJson(json);
}

/// @nodoc
mixin _$Payer {
  Name? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'email_address')
  String? get emailAddress => throw _privateConstructorUsedError;
  @JsonKey(name: 'payer_id')
  String? get payerId => throw _privateConstructorUsedError;
  CountryCode? get address => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PayerCopyWith<Payer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PayerCopyWith<$Res> {
  factory $PayerCopyWith(Payer value, $Res Function(Payer) then) =
      _$PayerCopyWithImpl<$Res, Payer>;
  @useResult
  $Res call(
      {Name? name,
      @JsonKey(name: 'email_address') String? emailAddress,
      @JsonKey(name: 'payer_id') String? payerId,
      CountryCode? address});

  $NameCopyWith<$Res>? get name;
  $CountryCodeCopyWith<$Res>? get address;
}

/// @nodoc
class _$PayerCopyWithImpl<$Res, $Val extends Payer>
    implements $PayerCopyWith<$Res> {
  _$PayerCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? emailAddress = freezed,
    Object? payerId = freezed,
    Object? address = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Name?,
      emailAddress: freezed == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      payerId: freezed == payerId
          ? _value.payerId
          : payerId // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as CountryCode?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $NameCopyWith<$Res>? get name {
    if (_value.name == null) {
      return null;
    }

    return $NameCopyWith<$Res>(_value.name!, (value) {
      return _then(_value.copyWith(name: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $CountryCodeCopyWith<$Res>? get address {
    if (_value.address == null) {
      return null;
    }

    return $CountryCodeCopyWith<$Res>(_value.address!, (value) {
      return _then(_value.copyWith(address: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PayerCopyWith<$Res> implements $PayerCopyWith<$Res> {
  factory _$$_PayerCopyWith(_$_Payer value, $Res Function(_$_Payer) then) =
      __$$_PayerCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Name? name,
      @JsonKey(name: 'email_address') String? emailAddress,
      @JsonKey(name: 'payer_id') String? payerId,
      CountryCode? address});

  @override
  $NameCopyWith<$Res>? get name;
  @override
  $CountryCodeCopyWith<$Res>? get address;
}

/// @nodoc
class __$$_PayerCopyWithImpl<$Res> extends _$PayerCopyWithImpl<$Res, _$_Payer>
    implements _$$_PayerCopyWith<$Res> {
  __$$_PayerCopyWithImpl(_$_Payer _value, $Res Function(_$_Payer) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? emailAddress = freezed,
    Object? payerId = freezed,
    Object? address = freezed,
  }) {
    return _then(_$_Payer(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as Name?,
      emailAddress: freezed == emailAddress
          ? _value.emailAddress
          : emailAddress // ignore: cast_nullable_to_non_nullable
              as String?,
      payerId: freezed == payerId
          ? _value.payerId
          : payerId // ignore: cast_nullable_to_non_nullable
              as String?,
      address: freezed == address
          ? _value.address
          : address // ignore: cast_nullable_to_non_nullable
              as CountryCode?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Payer implements _Payer {
  const _$_Payer(
      {this.name,
      @JsonKey(name: 'email_address') this.emailAddress,
      @JsonKey(name: 'payer_id') this.payerId,
      this.address});

  factory _$_Payer.fromJson(Map<String, dynamic> json) =>
      _$$_PayerFromJson(json);

  @override
  final Name? name;
  @override
  @JsonKey(name: 'email_address')
  final String? emailAddress;
  @override
  @JsonKey(name: 'payer_id')
  final String? payerId;
  @override
  final CountryCode? address;

  @override
  String toString() {
    return 'Payer(name: $name, emailAddress: $emailAddress, payerId: $payerId, address: $address)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Payer &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.emailAddress, emailAddress) ||
                other.emailAddress == emailAddress) &&
            (identical(other.payerId, payerId) || other.payerId == payerId) &&
            (identical(other.address, address) || other.address == address));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, emailAddress, payerId, address);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PayerCopyWith<_$_Payer> get copyWith =>
      __$$_PayerCopyWithImpl<_$_Payer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PayerToJson(
      this,
    );
  }
}

abstract class _Payer implements Payer {
  const factory _Payer(
      {final Name? name,
      @JsonKey(name: 'email_address') final String? emailAddress,
      @JsonKey(name: 'payer_id') final String? payerId,
      final CountryCode? address}) = _$_Payer;

  factory _Payer.fromJson(Map<String, dynamic> json) = _$_Payer.fromJson;

  @override
  Name? get name;
  @override
  @JsonKey(name: 'email_address')
  String? get emailAddress;
  @override
  @JsonKey(name: 'payer_id')
  String? get payerId;
  @override
  CountryCode? get address;
  @override
  @JsonKey(ignore: true)
  _$$_PayerCopyWith<_$_Payer> get copyWith =>
      throw _privateConstructorUsedError;
}
