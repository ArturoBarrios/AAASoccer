// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'trainings_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TrainingsResponseModel _$TrainingsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _TrainingsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$TrainingsResponseModel {
  @JsonKey(name: 'data')
  List<String>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TrainingsResponseModelCopyWith<TrainingsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TrainingsResponseModelCopyWith<$Res> {
  factory $TrainingsResponseModelCopyWith(TrainingsResponseModel value,
          $Res Function(TrainingsResponseModel) then) =
      _$TrainingsResponseModelCopyWithImpl<$Res, TrainingsResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class _$TrainingsResponseModelCopyWithImpl<$Res,
        $Val extends TrainingsResponseModel>
    implements $TrainingsResponseModelCopyWith<$Res> {
  _$TrainingsResponseModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_TrainingsResponseModelCopyWith<$Res>
    implements $TrainingsResponseModelCopyWith<$Res> {
  factory _$$_TrainingsResponseModelCopyWith(_$_TrainingsResponseModel value,
          $Res Function(_$_TrainingsResponseModel) then) =
      __$$_TrainingsResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class __$$_TrainingsResponseModelCopyWithImpl<$Res>
    extends _$TrainingsResponseModelCopyWithImpl<$Res,
        _$_TrainingsResponseModel>
    implements _$$_TrainingsResponseModelCopyWith<$Res> {
  __$$_TrainingsResponseModelCopyWithImpl(_$_TrainingsResponseModel _value,
      $Res Function(_$_TrainingsResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_TrainingsResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TrainingsResponseModel implements _TrainingsResponseModel {
  const _$_TrainingsResponseModel(
      {@JsonKey(name: 'data') final List<String>? data})
      : _data = data;

  factory _$_TrainingsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_TrainingsResponseModelFromJson(json);

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
    return 'TrainingsResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TrainingsResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TrainingsResponseModelCopyWith<_$_TrainingsResponseModel> get copyWith =>
      __$$_TrainingsResponseModelCopyWithImpl<_$_TrainingsResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TrainingsResponseModelToJson(
      this,
    );
  }
}

abstract class _TrainingsResponseModel implements TrainingsResponseModel {
  const factory _TrainingsResponseModel(
          {@JsonKey(name: 'data') final List<String>? data}) =
      _$_TrainingsResponseModel;

  factory _TrainingsResponseModel.fromJson(Map<String, dynamic> json) =
      _$_TrainingsResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<String>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_TrainingsResponseModelCopyWith<_$_TrainingsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
