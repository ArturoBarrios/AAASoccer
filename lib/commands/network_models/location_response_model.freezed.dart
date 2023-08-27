// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

LocationResponseModel _$LocationResponseModelFromJson(
    Map<String, dynamic> json) {
  return _LocationResponseModel.fromJson(json);
}

/// @nodoc
mixin _$LocationResponseModel {
  @JsonKey(name: 'data')
  List<LocationDataResponseModel>? get data =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationResponseModelCopyWith<LocationResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationResponseModelCopyWith<$Res> {
  factory $LocationResponseModelCopyWith(LocationResponseModel value,
          $Res Function(LocationResponseModel) then) =
      _$LocationResponseModelCopyWithImpl<$Res, LocationResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<LocationDataResponseModel>? data});
}

/// @nodoc
class _$LocationResponseModelCopyWithImpl<$Res,
        $Val extends LocationResponseModel>
    implements $LocationResponseModelCopyWith<$Res> {
  _$LocationResponseModelCopyWithImpl(this._value, this._then);

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
              as List<LocationDataResponseModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocationResponseModelCopyWith<$Res>
    implements $LocationResponseModelCopyWith<$Res> {
  factory _$$_LocationResponseModelCopyWith(_$_LocationResponseModel value,
          $Res Function(_$_LocationResponseModel) then) =
      __$$_LocationResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<LocationDataResponseModel>? data});
}

/// @nodoc
class __$$_LocationResponseModelCopyWithImpl<$Res>
    extends _$LocationResponseModelCopyWithImpl<$Res, _$_LocationResponseModel>
    implements _$$_LocationResponseModelCopyWith<$Res> {
  __$$_LocationResponseModelCopyWithImpl(_$_LocationResponseModel _value,
      $Res Function(_$_LocationResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_LocationResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<LocationDataResponseModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocationResponseModel implements _LocationResponseModel {
  const _$_LocationResponseModel(
      {@JsonKey(name: 'data') final List<LocationDataResponseModel>? data})
      : _data = data;

  factory _$_LocationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_LocationResponseModelFromJson(json);

  final List<LocationDataResponseModel>? _data;
  @override
  @JsonKey(name: 'data')
  List<LocationDataResponseModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'LocationResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocationResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocationResponseModelCopyWith<_$_LocationResponseModel> get copyWith =>
      __$$_LocationResponseModelCopyWithImpl<_$_LocationResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationResponseModelToJson(
      this,
    );
  }
}

abstract class _LocationResponseModel implements LocationResponseModel {
  const factory _LocationResponseModel(
      {@JsonKey(name: 'data')
      final List<LocationDataResponseModel>? data}) = _$_LocationResponseModel;

  factory _LocationResponseModel.fromJson(Map<String, dynamic> json) =
      _$_LocationResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<LocationDataResponseModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_LocationResponseModelCopyWith<_$_LocationResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

LocationDataResponseModel _$LocationDataResponseModelFromJson(
    Map<String, dynamic> json) {
  return _LocationDataResponseModel.fromJson(json);
}

/// @nodoc
mixin _$LocationDataResponseModel {
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'latitude')
  double? get latitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'longitude')
  double? get longitude => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $LocationDataResponseModelCopyWith<LocationDataResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $LocationDataResponseModelCopyWith<$Res> {
  factory $LocationDataResponseModelCopyWith(LocationDataResponseModel value,
          $Res Function(LocationDataResponseModel) then) =
      _$LocationDataResponseModelCopyWithImpl<$Res, LocationDataResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: '_id') String? id,
      @JsonKey(name: 'latitude') double? latitude,
      @JsonKey(name: 'longitude') double? longitude});
}

/// @nodoc
class _$LocationDataResponseModelCopyWithImpl<$Res,
        $Val extends LocationDataResponseModel>
    implements $LocationDataResponseModelCopyWith<$Res> {
  _$LocationDataResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_LocationDataResponseModelCopyWith<$Res>
    implements $LocationDataResponseModelCopyWith<$Res> {
  factory _$$_LocationDataResponseModelCopyWith(
          _$_LocationDataResponseModel value,
          $Res Function(_$_LocationDataResponseModel) then) =
      __$$_LocationDataResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
      @JsonKey(name: '_id') String? id,
      @JsonKey(name: 'latitude') double? latitude,
      @JsonKey(name: 'longitude') double? longitude});
}

/// @nodoc
class __$$_LocationDataResponseModelCopyWithImpl<$Res>
    extends _$LocationDataResponseModelCopyWithImpl<$Res,
        _$_LocationDataResponseModel>
    implements _$$_LocationDataResponseModelCopyWith<$Res> {
  __$$_LocationDataResponseModelCopyWithImpl(
      _$_LocationDataResponseModel _value,
      $Res Function(_$_LocationDataResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? latitude = freezed,
    Object? longitude = freezed,
  }) {
    return _then(_$_LocationDataResponseModel(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      latitude: freezed == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double?,
      longitude: freezed == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_LocationDataResponseModel implements _LocationDataResponseModel {
  const _$_LocationDataResponseModel(
      {@JsonKey(name: 'name') this.name,
      @JsonKey(name: '_id') this.id,
      @JsonKey(name: 'latitude') this.latitude,
      @JsonKey(name: 'longitude') this.longitude});

  factory _$_LocationDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_LocationDataResponseModelFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'latitude')
  final double? latitude;
  @override
  @JsonKey(name: 'longitude')
  final double? longitude;

  @override
  String toString() {
    return 'LocationDataResponseModel(name: $name, id: $id, latitude: $latitude, longitude: $longitude)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_LocationDataResponseModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, name, id, latitude, longitude);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_LocationDataResponseModelCopyWith<_$_LocationDataResponseModel>
      get copyWith => __$$_LocationDataResponseModelCopyWithImpl<
          _$_LocationDataResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_LocationDataResponseModelToJson(
      this,
    );
  }
}

abstract class _LocationDataResponseModel implements LocationDataResponseModel {
  const factory _LocationDataResponseModel(
          {@JsonKey(name: 'name') final String? name,
          @JsonKey(name: '_id') final String? id,
          @JsonKey(name: 'latitude') final double? latitude,
          @JsonKey(name: 'longitude') final double? longitude}) =
      _$_LocationDataResponseModel;

  factory _LocationDataResponseModel.fromJson(Map<String, dynamic> json) =
      _$_LocationDataResponseModel.fromJson;

  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'latitude')
  double? get latitude;
  @override
  @JsonKey(name: 'longitude')
  double? get longitude;
  @override
  @JsonKey(ignore: true)
  _$$_LocationDataResponseModelCopyWith<_$_LocationDataResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
