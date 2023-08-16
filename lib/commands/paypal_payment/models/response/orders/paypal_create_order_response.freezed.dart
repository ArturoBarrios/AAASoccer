// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'paypal_create_order_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaypalCreateOrderResponse _$PaypalCreateOrderResponseFromJson(
    Map<String, dynamic> json) {
  return _PaypalCreateOrderResponse.fromJson(json);
}

/// @nodoc
mixin _$PaypalCreateOrderResponse {
  String? get id => throw _privateConstructorUsedError;
  String? get intent => throw _privateConstructorUsedError;
  String? get status => throw _privateConstructorUsedError;
  @JsonKey(name: 'purchase_units')
  List<PurchaseUnits>? get purchaseUnits => throw _privateConstructorUsedError;
  @JsonKey(name: 'create_time')
  String? get createTime => throw _privateConstructorUsedError;
  List<Links>? get links => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaypalCreateOrderResponseCopyWith<PaypalCreateOrderResponse> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaypalCreateOrderResponseCopyWith<$Res> {
  factory $PaypalCreateOrderResponseCopyWith(PaypalCreateOrderResponse value,
          $Res Function(PaypalCreateOrderResponse) then) =
      _$PaypalCreateOrderResponseCopyWithImpl<$Res, PaypalCreateOrderResponse>;
  @useResult
  $Res call(
      {String? id,
      String? intent,
      String? status,
      @JsonKey(name: 'purchase_units') List<PurchaseUnits>? purchaseUnits,
      @JsonKey(name: 'create_time') String? createTime,
      List<Links>? links});
}

/// @nodoc
class _$PaypalCreateOrderResponseCopyWithImpl<$Res,
        $Val extends PaypalCreateOrderResponse>
    implements $PaypalCreateOrderResponseCopyWith<$Res> {
  _$PaypalCreateOrderResponseCopyWithImpl(this._value, this._then);

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
    Object? purchaseUnits = freezed,
    Object? createTime = freezed,
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
      purchaseUnits: freezed == purchaseUnits
          ? _value.purchaseUnits
          : purchaseUnits // ignore: cast_nullable_to_non_nullable
              as List<PurchaseUnits>?,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
              as String?,
      links: freezed == links
          ? _value.links
          : links // ignore: cast_nullable_to_non_nullable
              as List<Links>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaypalCreateOrderResponseCopyWith<$Res>
    implements $PaypalCreateOrderResponseCopyWith<$Res> {
  factory _$$_PaypalCreateOrderResponseCopyWith(
          _$_PaypalCreateOrderResponse value,
          $Res Function(_$_PaypalCreateOrderResponse) then) =
      __$$_PaypalCreateOrderResponseCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? id,
      String? intent,
      String? status,
      @JsonKey(name: 'purchase_units') List<PurchaseUnits>? purchaseUnits,
      @JsonKey(name: 'create_time') String? createTime,
      List<Links>? links});
}

/// @nodoc
class __$$_PaypalCreateOrderResponseCopyWithImpl<$Res>
    extends _$PaypalCreateOrderResponseCopyWithImpl<$Res,
        _$_PaypalCreateOrderResponse>
    implements _$$_PaypalCreateOrderResponseCopyWith<$Res> {
  __$$_PaypalCreateOrderResponseCopyWithImpl(
      _$_PaypalCreateOrderResponse _value,
      $Res Function(_$_PaypalCreateOrderResponse) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? intent = freezed,
    Object? status = freezed,
    Object? purchaseUnits = freezed,
    Object? createTime = freezed,
    Object? links = freezed,
  }) {
    return _then(_$_PaypalCreateOrderResponse(
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
      purchaseUnits: freezed == purchaseUnits
          ? _value._purchaseUnits
          : purchaseUnits // ignore: cast_nullable_to_non_nullable
              as List<PurchaseUnits>?,
      createTime: freezed == createTime
          ? _value.createTime
          : createTime // ignore: cast_nullable_to_non_nullable
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
class _$_PaypalCreateOrderResponse implements _PaypalCreateOrderResponse {
  const _$_PaypalCreateOrderResponse(
      {this.id,
      this.intent,
      this.status,
      @JsonKey(name: 'purchase_units') final List<PurchaseUnits>? purchaseUnits,
      @JsonKey(name: 'create_time') this.createTime,
      final List<Links>? links})
      : _purchaseUnits = purchaseUnits,
        _links = links;

  factory _$_PaypalCreateOrderResponse.fromJson(Map<String, dynamic> json) =>
      _$$_PaypalCreateOrderResponseFromJson(json);

  @override
  final String? id;
  @override
  final String? intent;
  @override
  final String? status;
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
  @JsonKey(name: 'create_time')
  final String? createTime;
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
    return 'PaypalCreateOrderResponse(id: $id, intent: $intent, status: $status, purchaseUnits: $purchaseUnits, createTime: $createTime, links: $links)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaypalCreateOrderResponse &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.intent, intent) || other.intent == intent) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality()
                .equals(other._purchaseUnits, _purchaseUnits) &&
            (identical(other.createTime, createTime) ||
                other.createTime == createTime) &&
            const DeepCollectionEquality().equals(other._links, _links));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      intent,
      status,
      const DeepCollectionEquality().hash(_purchaseUnits),
      createTime,
      const DeepCollectionEquality().hash(_links));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaypalCreateOrderResponseCopyWith<_$_PaypalCreateOrderResponse>
      get copyWith => __$$_PaypalCreateOrderResponseCopyWithImpl<
          _$_PaypalCreateOrderResponse>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaypalCreateOrderResponseToJson(
      this,
    );
  }
}

abstract class _PaypalCreateOrderResponse implements PaypalCreateOrderResponse {
  const factory _PaypalCreateOrderResponse(
      {final String? id,
      final String? intent,
      final String? status,
      @JsonKey(name: 'purchase_units') final List<PurchaseUnits>? purchaseUnits,
      @JsonKey(name: 'create_time') final String? createTime,
      final List<Links>? links}) = _$_PaypalCreateOrderResponse;

  factory _PaypalCreateOrderResponse.fromJson(Map<String, dynamic> json) =
      _$_PaypalCreateOrderResponse.fromJson;

  @override
  String? get id;
  @override
  String? get intent;
  @override
  String? get status;
  @override
  @JsonKey(name: 'purchase_units')
  List<PurchaseUnits>? get purchaseUnits;
  @override
  @JsonKey(name: 'create_time')
  String? get createTime;
  @override
  List<Links>? get links;
  @override
  @JsonKey(ignore: true)
  _$$_PaypalCreateOrderResponseCopyWith<_$_PaypalCreateOrderResponse>
      get copyWith => throw _privateConstructorUsedError;
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
  List<Items>? get items => throw _privateConstructorUsedError;

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
      List<Items>? items});

  $AmountCopyWith<$Res>? get amount;
  $PayeeCopyWith<$Res>? get payee;
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
    Object? items = freezed,
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
      items: freezed == items
          ? _value.items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Items>?,
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
      List<Items>? items});

  @override
  $AmountCopyWith<$Res>? get amount;
  @override
  $PayeeCopyWith<$Res>? get payee;
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
    Object? items = freezed,
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
      items: freezed == items
          ? _value._items
          : items // ignore: cast_nullable_to_non_nullable
              as List<Items>?,
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
      final List<Items>? items})
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
  String toString() {
    return 'PurchaseUnits(referenceId: $referenceId, amount: $amount, payee: $payee, items: $items)';
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
            const DeepCollectionEquality().equals(other._items, _items));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, referenceId, amount, payee,
      const DeepCollectionEquality().hash(_items));

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
      final List<Items>? items}) = _$_PurchaseUnits;

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
  List<Items>? get items;
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
      {@JsonKey(name: 'currency_code') this.currencyCode = 'USD',
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
  ItemTotal? get itemTotal => throw _privateConstructorUsedError;

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
  $Res call({@JsonKey(name: 'item_total') ItemTotal? itemTotal});

  $ItemTotalCopyWith<$Res>? get itemTotal;
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
  }) {
    return _then(_value.copyWith(
      itemTotal: freezed == itemTotal
          ? _value.itemTotal
          : itemTotal // ignore: cast_nullable_to_non_nullable
              as ItemTotal?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ItemTotalCopyWith<$Res>? get itemTotal {
    if (_value.itemTotal == null) {
      return null;
    }

    return $ItemTotalCopyWith<$Res>(_value.itemTotal!, (value) {
      return _then(_value.copyWith(itemTotal: value) as $Val);
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
  $Res call({@JsonKey(name: 'item_total') ItemTotal? itemTotal});

  @override
  $ItemTotalCopyWith<$Res>? get itemTotal;
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
  }) {
    return _then(_$_Breakdown(
      itemTotal: freezed == itemTotal
          ? _value.itemTotal
          : itemTotal // ignore: cast_nullable_to_non_nullable
              as ItemTotal?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Breakdown implements _Breakdown {
  const _$_Breakdown({@JsonKey(name: 'item_total') this.itemTotal});

  factory _$_Breakdown.fromJson(Map<String, dynamic> json) =>
      _$$_BreakdownFromJson(json);

  @override
  @JsonKey(name: 'item_total')
  final ItemTotal? itemTotal;

  @override
  String toString() {
    return 'Breakdown(itemTotal: $itemTotal)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Breakdown &&
            (identical(other.itemTotal, itemTotal) ||
                other.itemTotal == itemTotal));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, itemTotal);

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
      {@JsonKey(name: 'item_total') final ItemTotal? itemTotal}) = _$_Breakdown;

  factory _Breakdown.fromJson(Map<String, dynamic> json) =
      _$_Breakdown.fromJson;

  @override
  @JsonKey(name: 'item_total')
  ItemTotal? get itemTotal;
  @override
  @JsonKey(ignore: true)
  _$$_BreakdownCopyWith<_$_Breakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

ItemTotal _$ItemTotalFromJson(Map<String, dynamic> json) {
  return _ItemTotal.fromJson(json);
}

/// @nodoc
mixin _$ItemTotal {
  @JsonKey(name: 'currency_code')
  String? get currencyCode => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ItemTotalCopyWith<ItemTotal> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ItemTotalCopyWith<$Res> {
  factory $ItemTotalCopyWith(ItemTotal value, $Res Function(ItemTotal) then) =
      _$ItemTotalCopyWithImpl<$Res, ItemTotal>;
  @useResult
  $Res call(
      {@JsonKey(name: 'currency_code') String? currencyCode, String? value});
}

/// @nodoc
class _$ItemTotalCopyWithImpl<$Res, $Val extends ItemTotal>
    implements $ItemTotalCopyWith<$Res> {
  _$ItemTotalCopyWithImpl(this._value, this._then);

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
abstract class _$$_ItemTotalCopyWith<$Res> implements $ItemTotalCopyWith<$Res> {
  factory _$$_ItemTotalCopyWith(
          _$_ItemTotal value, $Res Function(_$_ItemTotal) then) =
      __$$_ItemTotalCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'currency_code') String? currencyCode, String? value});
}

/// @nodoc
class __$$_ItemTotalCopyWithImpl<$Res>
    extends _$ItemTotalCopyWithImpl<$Res, _$_ItemTotal>
    implements _$$_ItemTotalCopyWith<$Res> {
  __$$_ItemTotalCopyWithImpl(
      _$_ItemTotal _value, $Res Function(_$_ItemTotal) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currencyCode = freezed,
    Object? value = freezed,
  }) {
    return _then(_$_ItemTotal(
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
class _$_ItemTotal implements _ItemTotal {
  const _$_ItemTotal(
      {@JsonKey(name: 'currency_code') this.currencyCode = 'USD', this.value});

  factory _$_ItemTotal.fromJson(Map<String, dynamic> json) =>
      _$$_ItemTotalFromJson(json);

  @override
  @JsonKey(name: 'currency_code')
  final String? currencyCode;
  @override
  final String? value;

  @override
  String toString() {
    return 'ItemTotal(currencyCode: $currencyCode, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ItemTotal &&
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
  _$$_ItemTotalCopyWith<_$_ItemTotal> get copyWith =>
      __$$_ItemTotalCopyWithImpl<_$_ItemTotal>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ItemTotalToJson(
      this,
    );
  }
}

abstract class _ItemTotal implements ItemTotal {
  const factory _ItemTotal(
      {@JsonKey(name: 'currency_code') final String? currencyCode,
      final String? value}) = _$_ItemTotal;

  factory _ItemTotal.fromJson(Map<String, dynamic> json) =
      _$_ItemTotal.fromJson;

  @override
  @JsonKey(name: 'currency_code')
  String? get currencyCode;
  @override
  String? get value;
  @override
  @JsonKey(ignore: true)
  _$$_ItemTotalCopyWith<_$_ItemTotal> get copyWith =>
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
  UnitAmount? get unitAmount => throw _privateConstructorUsedError;
  String? get quantity => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;

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
      @JsonKey(name: 'unit_amount') UnitAmount? unitAmount,
      String? quantity,
      String? description});

  $UnitAmountCopyWith<$Res>? get unitAmount;
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
    Object? quantity = freezed,
    Object? description = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      unitAmount: freezed == unitAmount
          ? _value.unitAmount
          : unitAmount // ignore: cast_nullable_to_non_nullable
              as UnitAmount?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UnitAmountCopyWith<$Res>? get unitAmount {
    if (_value.unitAmount == null) {
      return null;
    }

    return $UnitAmountCopyWith<$Res>(_value.unitAmount!, (value) {
      return _then(_value.copyWith(unitAmount: value) as $Val);
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
      @JsonKey(name: 'unit_amount') UnitAmount? unitAmount,
      String? quantity,
      String? description});

  @override
  $UnitAmountCopyWith<$Res>? get unitAmount;
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
    Object? quantity = freezed,
    Object? description = freezed,
  }) {
    return _then(_$_Items(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      unitAmount: freezed == unitAmount
          ? _value.unitAmount
          : unitAmount // ignore: cast_nullable_to_non_nullable
              as UnitAmount?,
      quantity: freezed == quantity
          ? _value.quantity
          : quantity // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
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
      this.quantity,
      this.description});

  factory _$_Items.fromJson(Map<String, dynamic> json) =>
      _$$_ItemsFromJson(json);

  @override
  final String? name;
  @override
  @JsonKey(name: 'unit_amount')
  final UnitAmount? unitAmount;
  @override
  final String? quantity;
  @override
  final String? description;

  @override
  String toString() {
    return 'Items(name: $name, unitAmount: $unitAmount, quantity: $quantity, description: $description)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_Items &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.unitAmount, unitAmount) ||
                other.unitAmount == unitAmount) &&
            (identical(other.quantity, quantity) ||
                other.quantity == quantity) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, name, unitAmount, quantity, description);

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
      @JsonKey(name: 'unit_amount') final UnitAmount? unitAmount,
      final String? quantity,
      final String? description}) = _$_Items;

  factory _Items.fromJson(Map<String, dynamic> json) = _$_Items.fromJson;

  @override
  String? get name;
  @override
  @JsonKey(name: 'unit_amount')
  UnitAmount? get unitAmount;
  @override
  String? get quantity;
  @override
  String? get description;
  @override
  @JsonKey(ignore: true)
  _$$_ItemsCopyWith<_$_Items> get copyWith =>
      throw _privateConstructorUsedError;
}

UnitAmount _$UnitAmountFromJson(Map<String, dynamic> json) {
  return _UnitAmount.fromJson(json);
}

/// @nodoc
mixin _$UnitAmount {
  @JsonKey(name: 'currency_code')
  String? get currencyCode => throw _privateConstructorUsedError;
  String? get value => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UnitAmountCopyWith<UnitAmount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UnitAmountCopyWith<$Res> {
  factory $UnitAmountCopyWith(
          UnitAmount value, $Res Function(UnitAmount) then) =
      _$UnitAmountCopyWithImpl<$Res, UnitAmount>;
  @useResult
  $Res call(
      {@JsonKey(name: 'currency_code') String? currencyCode, String? value});
}

/// @nodoc
class _$UnitAmountCopyWithImpl<$Res, $Val extends UnitAmount>
    implements $UnitAmountCopyWith<$Res> {
  _$UnitAmountCopyWithImpl(this._value, this._then);

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
abstract class _$$_UnitAmountCopyWith<$Res>
    implements $UnitAmountCopyWith<$Res> {
  factory _$$_UnitAmountCopyWith(
          _$_UnitAmount value, $Res Function(_$_UnitAmount) then) =
      __$$_UnitAmountCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'currency_code') String? currencyCode, String? value});
}

/// @nodoc
class __$$_UnitAmountCopyWithImpl<$Res>
    extends _$UnitAmountCopyWithImpl<$Res, _$_UnitAmount>
    implements _$$_UnitAmountCopyWith<$Res> {
  __$$_UnitAmountCopyWithImpl(
      _$_UnitAmount _value, $Res Function(_$_UnitAmount) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? currencyCode = freezed,
    Object? value = freezed,
  }) {
    return _then(_$_UnitAmount(
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
class _$_UnitAmount implements _UnitAmount {
  const _$_UnitAmount(
      {@JsonKey(name: 'currency_code') this.currencyCode = 'USD', this.value});

  factory _$_UnitAmount.fromJson(Map<String, dynamic> json) =>
      _$$_UnitAmountFromJson(json);

  @override
  @JsonKey(name: 'currency_code')
  final String? currencyCode;
  @override
  final String? value;

  @override
  String toString() {
    return 'UnitAmount(currencyCode: $currencyCode, value: $value)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UnitAmount &&
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
  _$$_UnitAmountCopyWith<_$_UnitAmount> get copyWith =>
      __$$_UnitAmountCopyWithImpl<_$_UnitAmount>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UnitAmountToJson(
      this,
    );
  }
}

abstract class _UnitAmount implements UnitAmount {
  const factory _UnitAmount(
      {@JsonKey(name: 'currency_code') final String? currencyCode,
      final String? value}) = _$_UnitAmount;

  factory _UnitAmount.fromJson(Map<String, dynamic> json) =
      _$_UnitAmount.fromJson;

  @override
  @JsonKey(name: 'currency_code')
  String? get currencyCode;
  @override
  String? get value;
  @override
  @JsonKey(ignore: true)
  _$$_UnitAmountCopyWith<_$_UnitAmount> get copyWith =>
      throw _privateConstructorUsedError;
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
