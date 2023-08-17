// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paypal_create_order_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaypalCreateOrderRequest _$PaypalCreateOrderRequestFromJson(
    Map<String, dynamic> json) {
  return _PaypalCreateOrderRequest.fromJson(json);
}

/// @nodoc
mixin _$PaypalCreateOrderRequest {
  String? get intent => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_units')
  List<PurchaseUnitsRequest>? get purchaseUnits =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'application_context', includeIfNull: false)
  ApplicationContext? get applicationContext =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaypalCreateOrderRequestCopyWith<PaypalCreateOrderRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaypalCreateOrderRequestCopyWith<$Res> {
  factory $PaypalCreateOrderRequestCopyWith(PaypalCreateOrderRequest value,
          $Res Function(PaypalCreateOrderRequest) then) =
      _$PaypalCreateOrderRequestCopyWithImpl<$Res, PaypalCreateOrderRequest>;
  @useResult
  $Res call(
      {String? intent,
      @JsonKey(name: 'purchase_units')
          List<PurchaseUnitsRequest>? purchaseUnits,
      @JsonKey(name: 'application_context', includeIfNull: false)
          ApplicationContext? applicationContext});

  $ApplicationContextCopyWith<$Res>? get applicationContext;
}

/// @nodoc
class _$PaypalCreateOrderRequestCopyWithImpl<$Res,
        $Val extends PaypalCreateOrderRequest>
    implements $PaypalCreateOrderRequestCopyWith<$Res> {
  _$PaypalCreateOrderRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intent = freezed,
    Object? purchaseUnits = freezed,
    Object? applicationContext = freezed,
  }) {
    return _then(_value.copyWith(
      intent: freezed == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseUnits: freezed == purchaseUnits
          ? _value.purchaseUnits
          : purchaseUnits // ignore: cast_nullable_to_non_nullable
              as List<PurchaseUnitsRequest>?,
      applicationContext: freezed == applicationContext
          ? _value.applicationContext
          : applicationContext // ignore: cast_nullable_to_non_nullable
              as ApplicationContext?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ApplicationContextCopyWith<$Res>? get applicationContext {
    if (_value.applicationContext == null) {
      return null;
    }

    return $ApplicationContextCopyWith<$Res>(_value.applicationContext!,
        (value) {
      return _then(_value.copyWith(applicationContext: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PaypalCreateOrderRequestCopyWith<$Res>
    implements $PaypalCreateOrderRequestCopyWith<$Res> {
  factory _$$_PaypalCreateOrderRequestCopyWith(
          _$_PaypalCreateOrderRequest value,
          $Res Function(_$_PaypalCreateOrderRequest) then) =
      __$$_PaypalCreateOrderRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? intent,
      @JsonKey(name: 'purchase_units')
          List<PurchaseUnitsRequest>? purchaseUnits,
      @JsonKey(name: 'application_context', includeIfNull: false)
          ApplicationContext? applicationContext});

  @override
  $ApplicationContextCopyWith<$Res>? get applicationContext;
}

/// @nodoc
class __$$_PaypalCreateOrderRequestCopyWithImpl<$Res>
    extends _$PaypalCreateOrderRequestCopyWithImpl<$Res,
        _$_PaypalCreateOrderRequest>
    implements _$$_PaypalCreateOrderRequestCopyWith<$Res> {
  __$$_PaypalCreateOrderRequestCopyWithImpl(_$_PaypalCreateOrderRequest _value,
      $Res Function(_$_PaypalCreateOrderRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? intent = freezed,
    Object? purchaseUnits = freezed,
    Object? applicationContext = freezed,
  }) {
    return _then(_$_PaypalCreateOrderRequest(
      intent: freezed == intent
          ? _value.intent
          : intent // ignore: cast_nullable_to_non_nullable
              as String?,
      purchaseUnits: freezed == purchaseUnits
          ? _value._purchaseUnits
          : purchaseUnits // ignore: cast_nullable_to_non_nullable
              as List<PurchaseUnitsRequest>?,
      applicationContext: freezed == applicationContext
          ? _value.applicationContext
          : applicationContext // ignore: cast_nullable_to_non_nullable
              as ApplicationContext?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaypalCreateOrderRequest implements _PaypalCreateOrderRequest {
  const _$_PaypalCreateOrderRequest(
      {this.intent = 'CAPTURE',
      @JsonKey(name: 'purchase_units')
          final List<PurchaseUnitsRequest>? purchaseUnits,
      @JsonKey(name: 'application_context', includeIfNull: false)
          this.applicationContext})
      : _purchaseUnits = purchaseUnits;

  factory _$_PaypalCreateOrderRequest.fromJson(Map<String, dynamic> json) =>
      _$$_PaypalCreateOrderRequestFromJson(json);

  @override
  @JsonKey()
  final String? intent;
  final List<PurchaseUnitsRequest>? _purchaseUnits;
  @override
  @JsonKey(name: 'purchase_units')
  List<PurchaseUnitsRequest>? get purchaseUnits {
    final value = _purchaseUnits;
    if (value == null) return null;
    if (_purchaseUnits is EqualUnmodifiableListView) return _purchaseUnits;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'application_context', includeIfNull: false)
  final ApplicationContext? applicationContext;

  @override
  String toString() {
    return 'PaypalCreateOrderRequest(intent: $intent, purchaseUnits: $purchaseUnits, applicationContext: $applicationContext)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaypalCreateOrderRequest &&
            (identical(other.intent, intent) || other.intent == intent) &&
            const DeepCollectionEquality()
                .equals(other._purchaseUnits, _purchaseUnits) &&
            (identical(other.applicationContext, applicationContext) ||
                other.applicationContext == applicationContext));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, intent,
      const DeepCollectionEquality().hash(_purchaseUnits), applicationContext);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaypalCreateOrderRequestCopyWith<_$_PaypalCreateOrderRequest>
      get copyWith => __$$_PaypalCreateOrderRequestCopyWithImpl<
          _$_PaypalCreateOrderRequest>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaypalCreateOrderRequestToJson(
      this,
    );
  }
}

abstract class _PaypalCreateOrderRequest implements PaypalCreateOrderRequest {
  const factory _PaypalCreateOrderRequest(
          {final String? intent,
          @JsonKey(name: 'purchase_units')
              final List<PurchaseUnitsRequest>? purchaseUnits,
          @JsonKey(name: 'application_context', includeIfNull: false)
              final ApplicationContext? applicationContext}) =
      _$_PaypalCreateOrderRequest;

  factory _PaypalCreateOrderRequest.fromJson(Map<String, dynamic> json) =
      _$_PaypalCreateOrderRequest.fromJson;

  @override
  String? get intent;
  @override
  @JsonKey(name: 'purchase_units')
  List<PurchaseUnitsRequest>? get purchaseUnits;
  @override
  @JsonKey(name: 'application_context', includeIfNull: false)
  ApplicationContext? get applicationContext;
  @override
  @JsonKey(ignore: true)
  _$$_PaypalCreateOrderRequestCopyWith<_$_PaypalCreateOrderRequest>
      get copyWith => throw _privateConstructorUsedError;
}

PurchaseUnitsRequest _$PurchaseUnitsRequestFromJson(Map<String, dynamic> json) {
  return _PurchaseUnitsRequest.fromJson(json);
}

/// @nodoc
mixin _$PurchaseUnitsRequest {
  List<Items>? get items => throw _privateConstructorUsedError;
  Amount? get amount => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PurchaseUnitsRequestCopyWith<PurchaseUnitsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PurchaseUnitsRequestCopyWith<$Res> {
  factory $PurchaseUnitsRequestCopyWith(PurchaseUnitsRequest value,
          $Res Function(PurchaseUnitsRequest) then) =
      _$PurchaseUnitsRequestCopyWithImpl<$Res, PurchaseUnitsRequest>;
  @useResult
  $Res call({List<Items>? items, Amount? amount});

  $AmountCopyWith<$Res>? get amount;
}

/// @nodoc
class _$PurchaseUnitsRequestCopyWithImpl<$Res,
        $Val extends PurchaseUnitsRequest>
    implements $PurchaseUnitsRequestCopyWith<$Res> {
  _$PurchaseUnitsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
    Object? amount = freezed,
  }) {
    return _then(_value.copyWith(
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Items>?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Amount?,
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
}

/// @nodoc
abstract class _$$_PurchaseUnitsRequestCopyWith<$Res>
    implements $PurchaseUnitsRequestCopyWith<$Res> {
  factory _$$_PurchaseUnitsRequestCopyWith(_$_PurchaseUnitsRequest value,
          $Res Function(_$_PurchaseUnitsRequest) then) =
      __$$_PurchaseUnitsRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Items>? items, Amount? amount});

  @override
  $AmountCopyWith<$Res>? get amount;
}

/// @nodoc
class __$$_PurchaseUnitsRequestCopyWithImpl<$Res>
    extends _$PurchaseUnitsRequestCopyWithImpl<$Res, _$_PurchaseUnitsRequest>
    implements _$$_PurchaseUnitsRequestCopyWith<$Res> {
  __$$_PurchaseUnitsRequestCopyWithImpl(_$_PurchaseUnitsRequest _value,
      $Res Function(_$_PurchaseUnitsRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? items = freezed,
    Object? amount = freezed,
  }) {
    return _then(_$_PurchaseUnitsRequest(
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Items>?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as Amount?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PurchaseUnitsRequest implements _PurchaseUnitsRequest {
  const _$_PurchaseUnitsRequest({final List<Items>? items, this.amount})
      : _items = items;

  factory _$_PurchaseUnitsRequest.fromJson(Map<String, dynamic> json) =>
      _$$_PurchaseUnitsRequestFromJson(json);

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
  final Amount? amount;

  @override
  String toString() {
    return 'PurchaseUnitsRequest(items: $items, amount: $amount)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PurchaseUnitsRequest &&
            const DeepCollectionEquality().equals(other._items, _items) &&
            (identical(other.amount, amount) || other.amount == amount));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_items), amount);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PurchaseUnitsRequestCopyWith<_$_PurchaseUnitsRequest> get copyWith =>
      __$$_PurchaseUnitsRequestCopyWithImpl<_$_PurchaseUnitsRequest>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PurchaseUnitsRequestToJson(
      this,
    );
  }
}

abstract class _PurchaseUnitsRequest implements PurchaseUnitsRequest {
  const factory _PurchaseUnitsRequest(
      {final List<Items>? items,
      final Amount? amount}) = _$_PurchaseUnitsRequest;

  factory _PurchaseUnitsRequest.fromJson(Map<String, dynamic> json) =
      _$_PurchaseUnitsRequest.fromJson;

  @override
  List<Items>? get items;
  @override
  Amount? get amount;
  @override
  @JsonKey(ignore: true)
  _$$_PurchaseUnitsRequestCopyWith<_$_PurchaseUnitsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

ApplicationContext _$ApplicationContextFromJson(Map<String, dynamic> json) {
  return _ApplicationContext.fromJson(json);
}

/// @nodoc
mixin _$ApplicationContext {
  @JsonKey(name: 'return_url')
  String? get returnUrl => throw _privateConstructorUsedError;
  @JsonKey(name: 'cancel_url')
  String? get cancelUrl => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ApplicationContextCopyWith<ApplicationContext> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApplicationContextCopyWith<$Res> {
  factory $ApplicationContextCopyWith(
          ApplicationContext value, $Res Function(ApplicationContext) then) =
      _$ApplicationContextCopyWithImpl<$Res, ApplicationContext>;
  @useResult
  $Res call(
      {@JsonKey(name: 'return_url') String? returnUrl,
      @JsonKey(name: 'cancel_url') String? cancelUrl});
}

/// @nodoc
class _$ApplicationContextCopyWithImpl<$Res, $Val extends ApplicationContext>
    implements $ApplicationContextCopyWith<$Res> {
  _$ApplicationContextCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? returnUrl = freezed,
    Object? cancelUrl = freezed,
  }) {
    return _then(_value.copyWith(
      returnUrl: freezed == returnUrl
          ? _value.returnUrl
          : returnUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      cancelUrl: freezed == cancelUrl
          ? _value.cancelUrl
          : cancelUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ApplicationContextCopyWith<$Res>
    implements $ApplicationContextCopyWith<$Res> {
  factory _$$_ApplicationContextCopyWith(_$_ApplicationContext value,
          $Res Function(_$_ApplicationContext) then) =
      __$$_ApplicationContextCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'return_url') String? returnUrl,
      @JsonKey(name: 'cancel_url') String? cancelUrl});
}

/// @nodoc
class __$$_ApplicationContextCopyWithImpl<$Res>
    extends _$ApplicationContextCopyWithImpl<$Res, _$_ApplicationContext>
    implements _$$_ApplicationContextCopyWith<$Res> {
  __$$_ApplicationContextCopyWithImpl(
      _$_ApplicationContext _value, $Res Function(_$_ApplicationContext) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? returnUrl = freezed,
    Object? cancelUrl = freezed,
  }) {
    return _then(_$_ApplicationContext(
      returnUrl: freezed == returnUrl
          ? _value.returnUrl
          : returnUrl // ignore: cast_nullable_to_non_nullable
              as String?,
      cancelUrl: freezed == cancelUrl
          ? _value.cancelUrl
          : cancelUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ApplicationContext implements _ApplicationContext {
  const _$_ApplicationContext(
      {@JsonKey(name: 'return_url')
          this.returnUrl = 'https://example.com/return',
      @JsonKey(name: 'cancel_url')
          this.cancelUrl = 'https://example.com/cancel'});

  factory _$_ApplicationContext.fromJson(Map<String, dynamic> json) =>
      _$$_ApplicationContextFromJson(json);

  @override
  @JsonKey(name: 'return_url')
  final String? returnUrl;
  @override
  @JsonKey(name: 'cancel_url')
  final String? cancelUrl;

  @override
  String toString() {
    return 'ApplicationContext(returnUrl: $returnUrl, cancelUrl: $cancelUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ApplicationContext &&
            (identical(other.returnUrl, returnUrl) ||
                other.returnUrl == returnUrl) &&
            (identical(other.cancelUrl, cancelUrl) ||
                other.cancelUrl == cancelUrl));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, returnUrl, cancelUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ApplicationContextCopyWith<_$_ApplicationContext> get copyWith =>
      __$$_ApplicationContextCopyWithImpl<_$_ApplicationContext>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ApplicationContextToJson(
      this,
    );
  }
}

abstract class _ApplicationContext implements ApplicationContext {
  const factory _ApplicationContext(
          {@JsonKey(name: 'return_url') final String? returnUrl,
          @JsonKey(name: 'cancel_url') final String? cancelUrl}) =
      _$_ApplicationContext;

  factory _ApplicationContext.fromJson(Map<String, dynamic> json) =
      _$_ApplicationContext.fromJson;

  @override
  @JsonKey(name: 'return_url')
  String? get returnUrl;
  @override
  @JsonKey(name: 'cancel_url')
  String? get cancelUrl;
  @override
  @JsonKey(ignore: true)
  _$$_ApplicationContextCopyWith<_$_ApplicationContext> get copyWith =>
      throw _privateConstructorUsedError;
}
