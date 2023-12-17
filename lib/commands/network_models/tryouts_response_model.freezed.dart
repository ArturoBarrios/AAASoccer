// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tryouts_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TryoutsResponseModel _$TryoutsResponseModelFromJson(Map<String, dynamic> json) {
  return _TryoutsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$TryoutsResponseModel {
  @JsonKey(name: 'data')
  List<String>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TryoutsResponseModelCopyWith<TryoutsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TryoutsResponseModelCopyWith<$Res> {
  factory $TryoutsResponseModelCopyWith(TryoutsResponseModel value,
          $Res Function(TryoutsResponseModel) then) =
      _$TryoutsResponseModelCopyWithImpl<$Res, TryoutsResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class _$TryoutsResponseModelCopyWithImpl<$Res,
        $Val extends TryoutsResponseModel>
    implements $TryoutsResponseModelCopyWith<$Res> {
  _$TryoutsResponseModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_TryoutsResponseModelCopyWith<$Res>
    implements $TryoutsResponseModelCopyWith<$Res> {
  factory _$$_TryoutsResponseModelCopyWith(_$_TryoutsResponseModel value,
          $Res Function(_$_TryoutsResponseModel) then) =
      __$$_TryoutsResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class __$$_TryoutsResponseModelCopyWithImpl<$Res>
    extends _$TryoutsResponseModelCopyWithImpl<$Res, _$_TryoutsResponseModel>
    implements _$$_TryoutsResponseModelCopyWith<$Res> {
  __$$_TryoutsResponseModelCopyWithImpl(_$_TryoutsResponseModel _value,
      $Res Function(_$_TryoutsResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_TryoutsResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TryoutsResponseModel implements _TryoutsResponseModel {
  const _$_TryoutsResponseModel(
      {@JsonKey(name: 'data') final List<String>? data})
      : _data = data;

  factory _$_TryoutsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_TryoutsResponseModelFromJson(json);

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
    return 'TryoutsResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TryoutsResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TryoutsResponseModelCopyWith<_$_TryoutsResponseModel> get copyWith =>
      __$$_TryoutsResponseModelCopyWithImpl<_$_TryoutsResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TryoutsResponseModelToJson(
      this,
    );
  }
}

abstract class _TryoutsResponseModel implements TryoutsResponseModel {
  const factory _TryoutsResponseModel(
          {@JsonKey(name: 'data') final List<String>? data}) =
      _$_TryoutsResponseModel;

  factory _TryoutsResponseModel.fromJson(Map<String, dynamic> json) =
      _$_TryoutsResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<String>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_TryoutsResponseModelCopyWith<_$_TryoutsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
