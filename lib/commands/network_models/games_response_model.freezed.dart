// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'games_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

GamesResponseModel _$GamesResponseModelFromJson(Map<String, dynamic> json) {
  return _GamesResponseModel.fromJson(json);
}

/// @nodoc
mixin _$GamesResponseModel {
  @JsonKey(name: 'data')
  List<GamesDataResponseModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GamesResponseModelCopyWith<GamesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamesResponseModelCopyWith<$Res> {
  factory $GamesResponseModelCopyWith(
          GamesResponseModel value, $Res Function(GamesResponseModel) then) =
      _$GamesResponseModelCopyWithImpl<$Res, GamesResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<GamesDataResponseModel>? data});
}

/// @nodoc
class _$GamesResponseModelCopyWithImpl<$Res, $Val extends GamesResponseModel>
    implements $GamesResponseModelCopyWith<$Res> {
  _$GamesResponseModelCopyWithImpl(this._value, this._then);

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
              as List<GamesDataResponseModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GamesResponseModelCopyWith<$Res>
    implements $GamesResponseModelCopyWith<$Res> {
  factory _$$_GamesResponseModelCopyWith(_$_GamesResponseModel value,
          $Res Function(_$_GamesResponseModel) then) =
      __$$_GamesResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<GamesDataResponseModel>? data});
}

/// @nodoc
class __$$_GamesResponseModelCopyWithImpl<$Res>
    extends _$GamesResponseModelCopyWithImpl<$Res, _$_GamesResponseModel>
    implements _$$_GamesResponseModelCopyWith<$Res> {
  __$$_GamesResponseModelCopyWithImpl(
      _$_GamesResponseModel _value, $Res Function(_$_GamesResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_GamesResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<GamesDataResponseModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GamesResponseModel implements _GamesResponseModel {
  const _$_GamesResponseModel(
      {@JsonKey(name: 'data') final List<GamesDataResponseModel>? data})
      : _data = data;

  factory _$_GamesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_GamesResponseModelFromJson(json);

  final List<GamesDataResponseModel>? _data;
  @override
  @JsonKey(name: 'data')
  List<GamesDataResponseModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'GamesResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GamesResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GamesResponseModelCopyWith<_$_GamesResponseModel> get copyWith =>
      __$$_GamesResponseModelCopyWithImpl<_$_GamesResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GamesResponseModelToJson(
      this,
    );
  }
}

abstract class _GamesResponseModel implements GamesResponseModel {
  const factory _GamesResponseModel(
          {@JsonKey(name: 'data') final List<GamesDataResponseModel>? data}) =
      _$_GamesResponseModel;

  factory _GamesResponseModel.fromJson(Map<String, dynamic> json) =
      _$_GamesResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<GamesDataResponseModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_GamesResponseModelCopyWith<_$_GamesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

GamesDataResponseModel _$GamesDataResponseModelFromJson(
    Map<String, dynamic> json) {
  return _GamesDataResponseModel.fromJson(json);
}

/// @nodoc
mixin _$GamesDataResponseModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'pickup')
  bool? get pickup => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GamesDataResponseModelCopyWith<GamesDataResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GamesDataResponseModelCopyWith<$Res> {
  factory $GamesDataResponseModelCopyWith(GamesDataResponseModel value,
          $Res Function(GamesDataResponseModel) then) =
      _$GamesDataResponseModelCopyWithImpl<$Res, GamesDataResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'pickup') bool? pickup});
}

/// @nodoc
class _$GamesDataResponseModelCopyWithImpl<$Res,
        $Val extends GamesDataResponseModel>
    implements $GamesDataResponseModelCopyWith<$Res> {
  _$GamesDataResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? pickup = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      pickup: freezed == pickup
          ? _value.pickup
          : pickup // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_GamesDataResponseModelCopyWith<$Res>
    implements $GamesDataResponseModelCopyWith<$Res> {
  factory _$$_GamesDataResponseModelCopyWith(_$_GamesDataResponseModel value,
          $Res Function(_$_GamesDataResponseModel) then) =
      __$$_GamesDataResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'pickup') bool? pickup});
}

/// @nodoc
class __$$_GamesDataResponseModelCopyWithImpl<$Res>
    extends _$GamesDataResponseModelCopyWithImpl<$Res,
        _$_GamesDataResponseModel>
    implements _$$_GamesDataResponseModelCopyWith<$Res> {
  __$$_GamesDataResponseModelCopyWithImpl(_$_GamesDataResponseModel _value,
      $Res Function(_$_GamesDataResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? pickup = freezed,
  }) {
    return _then(_$_GamesDataResponseModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      pickup: freezed == pickup
          ? _value.pickup
          : pickup // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_GamesDataResponseModel implements _GamesDataResponseModel {
  const _$_GamesDataResponseModel(
      {@JsonKey(name: '_id') this.id, @JsonKey(name: 'pickup') this.pickup});

  factory _$_GamesDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_GamesDataResponseModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'pickup')
  final bool? pickup;

  @override
  String toString() {
    return 'GamesDataResponseModel(id: $id, pickup: $pickup)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_GamesDataResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.pickup, pickup) || other.pickup == pickup));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, pickup);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_GamesDataResponseModelCopyWith<_$_GamesDataResponseModel> get copyWith =>
      __$$_GamesDataResponseModelCopyWithImpl<_$_GamesDataResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GamesDataResponseModelToJson(
      this,
    );
  }
}

abstract class _GamesDataResponseModel implements GamesDataResponseModel {
  const factory _GamesDataResponseModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'pickup') final bool? pickup}) = _$_GamesDataResponseModel;

  factory _GamesDataResponseModel.fromJson(Map<String, dynamic> json) =
      _$_GamesDataResponseModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'pickup')
  bool? get pickup;
  @override
  @JsonKey(ignore: true)
  _$$_GamesDataResponseModelCopyWith<_$_GamesDataResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
