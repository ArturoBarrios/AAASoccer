// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'images_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ImagesResponseModel _$ImagesResponseModelFromJson(Map<String, dynamic> json) {
  return _ImagesResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ImagesResponseModel {
  @JsonKey(name: 'data')
  List<String>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ImagesResponseModelCopyWith<ImagesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ImagesResponseModelCopyWith<$Res> {
  factory $ImagesResponseModelCopyWith(
          ImagesResponseModel value, $Res Function(ImagesResponseModel) then) =
      _$ImagesResponseModelCopyWithImpl<$Res, ImagesResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class _$ImagesResponseModelCopyWithImpl<$Res, $Val extends ImagesResponseModel>
    implements $ImagesResponseModelCopyWith<$Res> {
  _$ImagesResponseModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_ImagesResponseModelCopyWith<$Res>
    implements $ImagesResponseModelCopyWith<$Res> {
  factory _$$_ImagesResponseModelCopyWith(_$_ImagesResponseModel value,
          $Res Function(_$_ImagesResponseModel) then) =
      __$$_ImagesResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class __$$_ImagesResponseModelCopyWithImpl<$Res>
    extends _$ImagesResponseModelCopyWithImpl<$Res, _$_ImagesResponseModel>
    implements _$$_ImagesResponseModelCopyWith<$Res> {
  __$$_ImagesResponseModelCopyWithImpl(_$_ImagesResponseModel _value,
      $Res Function(_$_ImagesResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_ImagesResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ImagesResponseModel implements _ImagesResponseModel {
  const _$_ImagesResponseModel(
      {@JsonKey(name: 'data') final List<String>? data})
      : _data = data;

  factory _$_ImagesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_ImagesResponseModelFromJson(json);

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
    return 'ImagesResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ImagesResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ImagesResponseModelCopyWith<_$_ImagesResponseModel> get copyWith =>
      __$$_ImagesResponseModelCopyWithImpl<_$_ImagesResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ImagesResponseModelToJson(
      this,
    );
  }
}

abstract class _ImagesResponseModel implements ImagesResponseModel {
  const factory _ImagesResponseModel(
          {@JsonKey(name: 'data') final List<String>? data}) =
      _$_ImagesResponseModel;

  factory _ImagesResponseModel.fromJson(Map<String, dynamic> json) =
      _$_ImagesResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<String>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_ImagesResponseModelCopyWith<_$_ImagesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
