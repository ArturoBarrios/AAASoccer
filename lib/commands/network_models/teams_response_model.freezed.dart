// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'teams_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TeamsResponseModel _$TeamsResponseModelFromJson(Map<String, dynamic> json) {
  return _TeamsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$TeamsResponseModel {
  @JsonKey(name: 'data')
  List<String>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TeamsResponseModelCopyWith<TeamsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TeamsResponseModelCopyWith<$Res> {
  factory $TeamsResponseModelCopyWith(
          TeamsResponseModel value, $Res Function(TeamsResponseModel) then) =
      _$TeamsResponseModelCopyWithImpl<$Res, TeamsResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class _$TeamsResponseModelCopyWithImpl<$Res, $Val extends TeamsResponseModel>
    implements $TeamsResponseModelCopyWith<$Res> {
  _$TeamsResponseModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_TeamsResponseModelCopyWith<$Res>
    implements $TeamsResponseModelCopyWith<$Res> {
  factory _$$_TeamsResponseModelCopyWith(_$_TeamsResponseModel value,
          $Res Function(_$_TeamsResponseModel) then) =
      __$$_TeamsResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class __$$_TeamsResponseModelCopyWithImpl<$Res>
    extends _$TeamsResponseModelCopyWithImpl<$Res, _$_TeamsResponseModel>
    implements _$$_TeamsResponseModelCopyWith<$Res> {
  __$$_TeamsResponseModelCopyWithImpl(
      _$_TeamsResponseModel _value, $Res Function(_$_TeamsResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_TeamsResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TeamsResponseModel implements _TeamsResponseModel {
  const _$_TeamsResponseModel({@JsonKey(name: 'data') final List<String>? data})
      : _data = data;

  factory _$_TeamsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_TeamsResponseModelFromJson(json);

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
    return 'TeamsResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TeamsResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TeamsResponseModelCopyWith<_$_TeamsResponseModel> get copyWith =>
      __$$_TeamsResponseModelCopyWithImpl<_$_TeamsResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TeamsResponseModelToJson(
      this,
    );
  }
}

abstract class _TeamsResponseModel implements TeamsResponseModel {
  const factory _TeamsResponseModel(
          {@JsonKey(name: 'data') final List<String>? data}) =
      _$_TeamsResponseModel;

  factory _TeamsResponseModel.fromJson(Map<String, dynamic> json) =
      _$_TeamsResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<String>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_TeamsResponseModelCopyWith<_$_TeamsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
