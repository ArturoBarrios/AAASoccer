// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payments_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

PaymentsResponseModel _$PaymentsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _PaymentsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$PaymentsResponseModel {
  @JsonKey(name: 'data')
  List<String>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PaymentsResponseModelCopyWith<PaymentsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PaymentsResponseModelCopyWith<$Res> {
  factory $PaymentsResponseModelCopyWith(PaymentsResponseModel value,
          $Res Function(PaymentsResponseModel) then) =
      _$PaymentsResponseModelCopyWithImpl<$Res, PaymentsResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class _$PaymentsResponseModelCopyWithImpl<$Res,
        $Val extends PaymentsResponseModel>
    implements $PaymentsResponseModelCopyWith<$Res> {
  _$PaymentsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_PaymentsResponseModelCopyWith<$Res>
    implements $PaymentsResponseModelCopyWith<$Res> {
  factory _$$_PaymentsResponseModelCopyWith(_$_PaymentsResponseModel value,
          $Res Function(_$_PaymentsResponseModel) then) =
      __$$_PaymentsResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class __$$_PaymentsResponseModelCopyWithImpl<$Res>
    extends _$PaymentsResponseModelCopyWithImpl<$Res, _$_PaymentsResponseModel>
    implements _$$_PaymentsResponseModelCopyWith<$Res> {
  __$$_PaymentsResponseModelCopyWithImpl(_$_PaymentsResponseModel _value,
      $Res Function(_$_PaymentsResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_PaymentsResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_PaymentsResponseModel implements _PaymentsResponseModel {
  const _$_PaymentsResponseModel(
      {@JsonKey(name: 'data') final List<String>? data})
      : _data = data;

  factory _$_PaymentsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_PaymentsResponseModelFromJson(json);

  final List<String>? _data;
  @override
  @JsonKey(name: 'data')
  List<String>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'PaymentsResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_PaymentsResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_PaymentsResponseModelCopyWith<_$_PaymentsResponseModel> get copyWith =>
      __$$_PaymentsResponseModelCopyWithImpl<_$_PaymentsResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PaymentsResponseModelToJson(
      this,
    );
  }
}

abstract class _PaymentsResponseModel implements PaymentsResponseModel {
  const factory _PaymentsResponseModel(
          {@JsonKey(name: 'data') final List<String>? data}) =
      _$_PaymentsResponseModel;

  factory _PaymentsResponseModel.fromJson(Map<String, dynamic> json) =
      _$_PaymentsResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<String>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_PaymentsResponseModelCopyWith<_$_PaymentsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
