// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'object_params_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ObjectParamsBody _$ObjectParamsBodyFromJson(Map<String, dynamic> json) {
  return _ObjectParamsBody.fromJson(json);
}

/// @nodoc
mixin _$ObjectParamsBody {
  @JsonKey(name: 'object')
  ObjectParamsBodyData? get objectObjectParamsBody =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ObjectParamsBodyCopyWith<ObjectParamsBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObjectParamsBodyCopyWith<$Res> {
  factory $ObjectParamsBodyCopyWith(
          ObjectParamsBody value, $Res Function(ObjectParamsBody) then) =
      _$ObjectParamsBodyCopyWithImpl<$Res, ObjectParamsBody>;
  @useResult
  $Res call(
      {@JsonKey(name: 'object') ObjectParamsBodyData? objectObjectParamsBody});

  $ObjectParamsBodyDataCopyWith<$Res>? get objectObjectParamsBody;
}

/// @nodoc
class _$ObjectParamsBodyCopyWithImpl<$Res, $Val extends ObjectParamsBody>
    implements $ObjectParamsBodyCopyWith<$Res> {
  _$ObjectParamsBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectObjectParamsBody = freezed,
  }) {
    return _then(_value.copyWith(
      objectObjectParamsBody: freezed == objectObjectParamsBody
          ? _value.objectObjectParamsBody
          : objectObjectParamsBody // ignore: cast_nullable_to_non_nullable
              as ObjectParamsBodyData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $ObjectParamsBodyDataCopyWith<$Res>? get objectObjectParamsBody {
    if (_value.objectObjectParamsBody == null) {
      return null;
    }

    return $ObjectParamsBodyDataCopyWith<$Res>(_value.objectObjectParamsBody!,
        (value) {
      return _then(_value.copyWith(objectObjectParamsBody: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ObjectParamsBodyCopyWith<$Res>
    implements $ObjectParamsBodyCopyWith<$Res> {
  factory _$$_ObjectParamsBodyCopyWith(
          _$_ObjectParamsBody value, $Res Function(_$_ObjectParamsBody) then) =
      __$$_ObjectParamsBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'object') ObjectParamsBodyData? objectObjectParamsBody});

  @override
  $ObjectParamsBodyDataCopyWith<$Res>? get objectObjectParamsBody;
}

/// @nodoc
class __$$_ObjectParamsBodyCopyWithImpl<$Res>
    extends _$ObjectParamsBodyCopyWithImpl<$Res, _$_ObjectParamsBody>
    implements _$$_ObjectParamsBodyCopyWith<$Res> {
  __$$_ObjectParamsBodyCopyWithImpl(
      _$_ObjectParamsBody _value, $Res Function(_$_ObjectParamsBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? objectObjectParamsBody = freezed,
  }) {
    return _then(_$_ObjectParamsBody(
      objectObjectParamsBody: freezed == objectObjectParamsBody
          ? _value.objectObjectParamsBody
          : objectObjectParamsBody // ignore: cast_nullable_to_non_nullable
              as ObjectParamsBodyData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ObjectParamsBody implements _ObjectParamsBody {
  const _$_ObjectParamsBody(
      {@JsonKey(name: 'object') this.objectObjectParamsBody});

  factory _$_ObjectParamsBody.fromJson(Map<String, dynamic> json) =>
      _$$_ObjectParamsBodyFromJson(json);

  @override
  @JsonKey(name: 'object')
  final ObjectParamsBodyData? objectObjectParamsBody;

  @override
  String toString() {
    return 'ObjectParamsBody(objectObjectParamsBody: $objectObjectParamsBody)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ObjectParamsBody &&
            (identical(other.objectObjectParamsBody, objectObjectParamsBody) ||
                other.objectObjectParamsBody == objectObjectParamsBody));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, objectObjectParamsBody);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ObjectParamsBodyCopyWith<_$_ObjectParamsBody> get copyWith =>
      __$$_ObjectParamsBodyCopyWithImpl<_$_ObjectParamsBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ObjectParamsBodyToJson(
      this,
    );
  }
}

abstract class _ObjectParamsBody implements ObjectParamsBody {
  const factory _ObjectParamsBody(
          {@JsonKey(name: 'object')
          final ObjectParamsBodyData? objectObjectParamsBody}) =
      _$_ObjectParamsBody;

  factory _ObjectParamsBody.fromJson(Map<String, dynamic> json) =
      _$_ObjectParamsBody.fromJson;

  @override
  @JsonKey(name: 'object')
  ObjectParamsBodyData? get objectObjectParamsBody;
  @override
  @JsonKey(ignore: true)
  _$$_ObjectParamsBodyCopyWith<_$_ObjectParamsBody> get copyWith =>
      throw _privateConstructorUsedError;
}

ObjectParamsBodyData _$ObjectParamsBodyDataFromJson(Map<String, dynamic> json) {
  return _ObjectParamsBodyData.fromJson(json);
}

/// @nodoc
mixin _$ObjectParamsBodyData {
  @JsonKey(name: 'data')
  VarBody? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ObjectParamsBodyDataCopyWith<ObjectParamsBodyData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ObjectParamsBodyDataCopyWith<$Res> {
  factory $ObjectParamsBodyDataCopyWith(ObjectParamsBodyData value,
          $Res Function(ObjectParamsBodyData) then) =
      _$ObjectParamsBodyDataCopyWithImpl<$Res, ObjectParamsBodyData>;
  @useResult
  $Res call({@JsonKey(name: 'data') VarBody? data});

  $VarBodyCopyWith<$Res>? get data;
}

/// @nodoc
class _$ObjectParamsBodyDataCopyWithImpl<$Res,
        $Val extends ObjectParamsBodyData>
    implements $ObjectParamsBodyDataCopyWith<$Res> {
  _$ObjectParamsBodyDataCopyWithImpl(this._value, this._then);

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
              as VarBody?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VarBodyCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $VarBodyCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ObjectParamsBodyDataCopyWith<$Res>
    implements $ObjectParamsBodyDataCopyWith<$Res> {
  factory _$$_ObjectParamsBodyDataCopyWith(_$_ObjectParamsBodyData value,
          $Res Function(_$_ObjectParamsBodyData) then) =
      __$$_ObjectParamsBodyDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') VarBody? data});

  @override
  $VarBodyCopyWith<$Res>? get data;
}

/// @nodoc
class __$$_ObjectParamsBodyDataCopyWithImpl<$Res>
    extends _$ObjectParamsBodyDataCopyWithImpl<$Res, _$_ObjectParamsBodyData>
    implements _$$_ObjectParamsBodyDataCopyWith<$Res> {
  __$$_ObjectParamsBodyDataCopyWithImpl(_$_ObjectParamsBodyData _value,
      $Res Function(_$_ObjectParamsBodyData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_ObjectParamsBodyData(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as VarBody?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ObjectParamsBodyData implements _ObjectParamsBodyData {
  const _$_ObjectParamsBodyData({@JsonKey(name: 'data') this.data});

  factory _$_ObjectParamsBodyData.fromJson(Map<String, dynamic> json) =>
      _$$_ObjectParamsBodyDataFromJson(json);

  @override
  @JsonKey(name: 'data')
  final VarBody? data;

  @override
  String toString() {
    return 'ObjectParamsBodyData(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ObjectParamsBodyData &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ObjectParamsBodyDataCopyWith<_$_ObjectParamsBodyData> get copyWith =>
      __$$_ObjectParamsBodyDataCopyWithImpl<_$_ObjectParamsBodyData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ObjectParamsBodyDataToJson(
      this,
    );
  }
}

abstract class _ObjectParamsBodyData implements ObjectParamsBodyData {
  const factory _ObjectParamsBodyData(
      {@JsonKey(name: 'data') final VarBody? data}) = _$_ObjectParamsBodyData;

  factory _ObjectParamsBodyData.fromJson(Map<String, dynamic> json) =
      _$_ObjectParamsBodyData.fromJson;

  @override
  @JsonKey(name: 'data')
  VarBody? get data;
  @override
  @JsonKey(ignore: true)
  _$$_ObjectParamsBodyDataCopyWith<_$_ObjectParamsBodyData> get copyWith =>
      throw _privateConstructorUsedError;
}
