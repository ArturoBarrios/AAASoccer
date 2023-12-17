// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'leagues_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LeaguesResponseModel _$LeaguesResponseModelFromJson(Map<String, dynamic> json) {
  return _LeaguesResponseModel.fromJson(json);
}

/// @nodoc
mixin _$LeaguesResponseModel {
  @JsonKey(name: 'data')
  List<String>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LeaguesResponseModelCopyWith<LeaguesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LeaguesResponseModelCopyWith<$Res> {
  factory $LeaguesResponseModelCopyWith(LeaguesResponseModel value,
          $Res Function(LeaguesResponseModel) then) =
      _$LeaguesResponseModelCopyWithImpl<$Res, LeaguesResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class _$LeaguesResponseModelCopyWithImpl<$Res,
        $Val extends LeaguesResponseModel>
    implements $LeaguesResponseModelCopyWith<$Res> {
  _$LeaguesResponseModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_LeaguesResponseModelCopyWith<$Res>
    implements $LeaguesResponseModelCopyWith<$Res> {
  factory _$$_LeaguesResponseModelCopyWith(_$_LeaguesResponseModel value,
          $Res Function(_$_LeaguesResponseModel) then) =
      __$$_LeaguesResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class __$$_LeaguesResponseModelCopyWithImpl<$Res>
    extends _$LeaguesResponseModelCopyWithImpl<$Res, _$_LeaguesResponseModel>
    implements _$$_LeaguesResponseModelCopyWith<$Res> {
  __$$_LeaguesResponseModelCopyWithImpl(_$_LeaguesResponseModel _value,
      $Res Function(_$_LeaguesResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_LeaguesResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LeaguesResponseModel implements _LeaguesResponseModel {
  const _$_LeaguesResponseModel(
      {@JsonKey(name: 'data') final List<String>? data})
      : _data = data;

  factory _$_LeaguesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_LeaguesResponseModelFromJson(json);

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
    return 'LeaguesResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LeaguesResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LeaguesResponseModelCopyWith<_$_LeaguesResponseModel> get copyWith =>
      __$$_LeaguesResponseModelCopyWithImpl<_$_LeaguesResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LeaguesResponseModelToJson(
      this,
    );
  }
}

abstract class _LeaguesResponseModel implements LeaguesResponseModel {
  const factory _LeaguesResponseModel(
          {@JsonKey(name: 'data') final List<String>? data}) =
      _$_LeaguesResponseModel;

  factory _LeaguesResponseModel.fromJson(Map<String, dynamic> json) =
      _$_LeaguesResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<String>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_LeaguesResponseModelCopyWith<_$_LeaguesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
