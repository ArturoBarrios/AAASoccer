// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PriceResponseModel _$PriceResponseModelFromJson(Map<String, dynamic> json) {
  return _PriceResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PriceResponseModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'amount')
  String? get amount => throw _privateConstructorUsedError;
  @JsonKey(name: 'teamAmount')
  String? get teamAmount => throw _privateConstructorUsedError;
  @JsonKey(name: 'event')
  EventSummaryDataResponseModel? get event =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PriceResponseModelCopyWith<PriceResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PriceResponseModelCopyWith<$Res> {
  factory $PriceResponseModelCopyWith(
          PriceResponseModel value, $Res Function(PriceResponseModel) then) =
      _$PriceResponseModelCopyWithImpl<$Res, PriceResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'amount') String? amount,
      @JsonKey(name: 'teamAmount') String? teamAmount,
      @JsonKey(name: 'event') EventSummaryDataResponseModel? event});

  $EventSummaryDataResponseModelCopyWith<$Res>? get event;
}

/// @nodoc
class _$PriceResponseModelCopyWithImpl<$Res, $Val extends PriceResponseModel>
    implements $PriceResponseModelCopyWith<$Res> {
  _$PriceResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? teamAmount = freezed,
    Object? event = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      teamAmount: freezed == teamAmount
          ? _value.teamAmount
          : teamAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as EventSummaryDataResponseModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EventSummaryDataResponseModelCopyWith<$Res>? get event {
    if (_value.event == null) {
      return null;
    }

    return $EventSummaryDataResponseModelCopyWith<$Res>(_value.event!, (value) {
      return _then(_value.copyWith(event: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_PriceResponseModelCopyWith<$Res>
    implements $PriceResponseModelCopyWith<$Res> {
  factory _$$_PriceResponseModelCopyWith(_$_PriceResponseModel value,
          $Res Function(_$_PriceResponseModel) then) =
      __$$_PriceResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'amount') String? amount,
      @JsonKey(name: 'teamAmount') String? teamAmount,
      @JsonKey(name: 'event') EventSummaryDataResponseModel? event});

  @override
  $EventSummaryDataResponseModelCopyWith<$Res>? get event;
}

/// @nodoc
class __$$_PriceResponseModelCopyWithImpl<$Res>
    extends _$PriceResponseModelCopyWithImpl<$Res, _$_PriceResponseModel>
    implements _$$_PriceResponseModelCopyWith<$Res> {
  __$$_PriceResponseModelCopyWithImpl(
      _$_PriceResponseModel _value, $Res Function(_$_PriceResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? amount = freezed,
    Object? teamAmount = freezed,
    Object? event = freezed,
  }) {
    return _then(_$_PriceResponseModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      amount: freezed == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as String?,
      teamAmount: freezed == teamAmount
          ? _value.teamAmount
          : teamAmount // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as EventSummaryDataResponseModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PriceResponseModel implements _PriceResponseModel {
  const _$_PriceResponseModel(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'amount') this.amount,
      @JsonKey(name: 'teamAmount') this.teamAmount,
      @JsonKey(name: 'event') this.event});

  factory _$_PriceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_PriceResponseModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'amount')
  final String? amount;
  @override
  @JsonKey(name: 'teamAmount')
  final String? teamAmount;
  @override
  @JsonKey(name: 'event')
  final EventSummaryDataResponseModel? event;

  @override
  String toString() {
    return 'PriceResponseModel(id: $id, amount: $amount, teamAmount: $teamAmount, event: $event)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PriceResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.teamAmount, teamAmount) ||
                other.teamAmount == teamAmount) &&
            (identical(other.event, event) || other.event == event));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, amount, teamAmount, event);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PriceResponseModelCopyWith<_$_PriceResponseModel> get copyWith =>
      __$$_PriceResponseModelCopyWithImpl<_$_PriceResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PriceResponseModelToJson(
      this,
    );
  }
}

abstract class _PriceResponseModel implements PriceResponseModel {
  const factory _PriceResponseModel(
          {@JsonKey(name: '_id') final String? id,
          @JsonKey(name: 'amount') final String? amount,
          @JsonKey(name: 'teamAmount') final String? teamAmount,
          @JsonKey(name: 'event') final EventSummaryDataResponseModel? event}) =
      _$_PriceResponseModel;

  factory _PriceResponseModel.fromJson(Map<String, dynamic> json) =
      _$_PriceResponseModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'amount')
  String? get amount;
  @override
  @JsonKey(name: 'teamAmount')
  String? get teamAmount;
  @override
  @JsonKey(name: 'event')
  EventSummaryDataResponseModel? get event;
  @override
  @JsonKey(ignore: true)
  _$$_PriceResponseModelCopyWith<_$_PriceResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
