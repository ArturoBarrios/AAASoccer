// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'users_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UsersResponseModel _$UsersResponseModelFromJson(Map<String, dynamic> json) {
  return _UsersResponseModel.fromJson(json);
}

/// @nodoc
mixin _$UsersResponseModel {
  @JsonKey(name: 'data')
  List<UserLowInfoResponseModel>? get data =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UsersResponseModelCopyWith<UsersResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsersResponseModelCopyWith<$Res> {
  factory $UsersResponseModelCopyWith(
          UsersResponseModel value, $Res Function(UsersResponseModel) then) =
      _$UsersResponseModelCopyWithImpl<$Res, UsersResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<UserLowInfoResponseModel>? data});
}

/// @nodoc
class _$UsersResponseModelCopyWithImpl<$Res, $Val extends UsersResponseModel>
    implements $UsersResponseModelCopyWith<$Res> {
  _$UsersResponseModelCopyWithImpl(this._value, this._then);

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
              as List<UserLowInfoResponseModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UsersResponseModelCopyWith<$Res>
    implements $UsersResponseModelCopyWith<$Res> {
  factory _$$_UsersResponseModelCopyWith(_$_UsersResponseModel value,
          $Res Function(_$_UsersResponseModel) then) =
      __$$_UsersResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<UserLowInfoResponseModel>? data});
}

/// @nodoc
class __$$_UsersResponseModelCopyWithImpl<$Res>
    extends _$UsersResponseModelCopyWithImpl<$Res, _$_UsersResponseModel>
    implements _$$_UsersResponseModelCopyWith<$Res> {
  __$$_UsersResponseModelCopyWithImpl(
      _$_UsersResponseModel _value, $Res Function(_$_UsersResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_UsersResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<UserLowInfoResponseModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UsersResponseModel implements _UsersResponseModel {
  const _$_UsersResponseModel(
      {@JsonKey(name: 'data') final List<UserLowInfoResponseModel>? data})
      : _data = data;

  factory _$_UsersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_UsersResponseModelFromJson(json);

  final List<UserLowInfoResponseModel>? _data;
  @override
  @JsonKey(name: 'data')
  List<UserLowInfoResponseModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UsersResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UsersResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UsersResponseModelCopyWith<_$_UsersResponseModel> get copyWith =>
      __$$_UsersResponseModelCopyWithImpl<_$_UsersResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UsersResponseModelToJson(
      this,
    );
  }
}

abstract class _UsersResponseModel implements UsersResponseModel {
  const factory _UsersResponseModel(
          {@JsonKey(name: 'data') final List<UserLowInfoResponseModel>? data}) =
      _$_UsersResponseModel;

  factory _UsersResponseModel.fromJson(Map<String, dynamic> json) =
      _$_UsersResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<UserLowInfoResponseModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_UsersResponseModelCopyWith<_$_UsersResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

UserLowInfoResponseModel _$UserLowInfoResponseModelFromJson(
    Map<String, dynamic> json) {
  return _UserLowInfoResponseModel.fromJson(json);
}

/// @nodoc
mixin _$UserLowInfoResponseModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserLowInfoResponseModelCopyWith<UserLowInfoResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserLowInfoResponseModelCopyWith<$Res> {
  factory $UserLowInfoResponseModelCopyWith(UserLowInfoResponseModel value,
          $Res Function(UserLowInfoResponseModel) then) =
      _$UserLowInfoResponseModelCopyWithImpl<$Res, UserLowInfoResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id, @JsonKey(name: 'name') String? name});
}

/// @nodoc
class _$UserLowInfoResponseModelCopyWithImpl<$Res,
        $Val extends UserLowInfoResponseModel>
    implements $UserLowInfoResponseModelCopyWith<$Res> {
  _$UserLowInfoResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserLowInfoResponseModelCopyWith<$Res>
    implements $UserLowInfoResponseModelCopyWith<$Res> {
  factory _$$_UserLowInfoResponseModelCopyWith(
          _$_UserLowInfoResponseModel value,
          $Res Function(_$_UserLowInfoResponseModel) then) =
      __$$_UserLowInfoResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id, @JsonKey(name: 'name') String? name});
}

/// @nodoc
class __$$_UserLowInfoResponseModelCopyWithImpl<$Res>
    extends _$UserLowInfoResponseModelCopyWithImpl<$Res,
        _$_UserLowInfoResponseModel>
    implements _$$_UserLowInfoResponseModelCopyWith<$Res> {
  __$$_UserLowInfoResponseModelCopyWithImpl(_$_UserLowInfoResponseModel _value,
      $Res Function(_$_UserLowInfoResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
  }) {
    return _then(_$_UserLowInfoResponseModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserLowInfoResponseModel implements _UserLowInfoResponseModel {
  const _$_UserLowInfoResponseModel(
      {@JsonKey(name: '_id') this.id, @JsonKey(name: 'name') this.name});

  factory _$_UserLowInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_UserLowInfoResponseModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;

  @override
  String toString() {
    return 'UserLowInfoResponseModel(id: $id, name: $name)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserLowInfoResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserLowInfoResponseModelCopyWith<_$_UserLowInfoResponseModel>
      get copyWith => __$$_UserLowInfoResponseModelCopyWithImpl<
          _$_UserLowInfoResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserLowInfoResponseModelToJson(
      this,
    );
  }
}

abstract class _UserLowInfoResponseModel implements UserLowInfoResponseModel {
  const factory _UserLowInfoResponseModel(
      {@JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'name') final String? name}) = _$_UserLowInfoResponseModel;

  factory _UserLowInfoResponseModel.fromJson(Map<String, dynamic> json) =
      _$_UserLowInfoResponseModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(ignore: true)
  _$$_UserLowInfoResponseModelCopyWith<_$_UserLowInfoResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
