// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'requests_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RequestsResponseModel _$RequestsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _RequestsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$RequestsResponseModel {
  @JsonKey(name: 'data')
  List<String>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RequestsResponseModelCopyWith<RequestsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RequestsResponseModelCopyWith<$Res> {
  factory $RequestsResponseModelCopyWith(RequestsResponseModel value,
          $Res Function(RequestsResponseModel) then) =
      _$RequestsResponseModelCopyWithImpl<$Res, RequestsResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class _$RequestsResponseModelCopyWithImpl<$Res,
        $Val extends RequestsResponseModel>
    implements $RequestsResponseModelCopyWith<$Res> {
  _$RequestsResponseModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_RequestsResponseModelCopyWith<$Res>
    implements $RequestsResponseModelCopyWith<$Res> {
  factory _$$_RequestsResponseModelCopyWith(_$_RequestsResponseModel value,
          $Res Function(_$_RequestsResponseModel) then) =
      __$$_RequestsResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class __$$_RequestsResponseModelCopyWithImpl<$Res>
    extends _$RequestsResponseModelCopyWithImpl<$Res, _$_RequestsResponseModel>
    implements _$$_RequestsResponseModelCopyWith<$Res> {
  __$$_RequestsResponseModelCopyWithImpl(_$_RequestsResponseModel _value,
      $Res Function(_$_RequestsResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_RequestsResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RequestsResponseModel implements _RequestsResponseModel {
  const _$_RequestsResponseModel(
      {@JsonKey(name: 'data') final List<String>? data})
      : _data = data;

  factory _$_RequestsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_RequestsResponseModelFromJson(json);

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
    return 'RequestsResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RequestsResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RequestsResponseModelCopyWith<_$_RequestsResponseModel> get copyWith =>
      __$$_RequestsResponseModelCopyWithImpl<_$_RequestsResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RequestsResponseModelToJson(
      this,
    );
  }
}

abstract class _RequestsResponseModel implements RequestsResponseModel {
  const factory _RequestsResponseModel(
          {@JsonKey(name: 'data') final List<String>? data}) =
      _$_RequestsResponseModel;

  factory _RequestsResponseModel.fromJson(Map<String, dynamic> json) =
      _$_RequestsResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<String>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_RequestsResponseModelCopyWith<_$_RequestsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
