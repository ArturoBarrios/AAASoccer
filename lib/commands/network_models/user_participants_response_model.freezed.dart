// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_participants_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserParticipantsResponseModel _$UserParticipantsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _UserParticipantsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$UserParticipantsResponseModel {
  @JsonKey(name: 'data')
  List<UserParticipantsDataResponseModel>? get data =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserParticipantsResponseModelCopyWith<UserParticipantsResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserParticipantsResponseModelCopyWith<$Res> {
  factory $UserParticipantsResponseModelCopyWith(
          UserParticipantsResponseModel value,
          $Res Function(UserParticipantsResponseModel) then) =
      _$UserParticipantsResponseModelCopyWithImpl<$Res,
          UserParticipantsResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<UserParticipantsDataResponseModel>? data});
}

/// @nodoc
class _$UserParticipantsResponseModelCopyWithImpl<$Res,
        $Val extends UserParticipantsResponseModel>
    implements $UserParticipantsResponseModelCopyWith<$Res> {
  _$UserParticipantsResponseModelCopyWithImpl(this._value, this._then);

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
              as List<UserParticipantsDataResponseModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_UserParticipantsResponseModelCopyWith<$Res>
    implements $UserParticipantsResponseModelCopyWith<$Res> {
  factory _$$_UserParticipantsResponseModelCopyWith(
          _$_UserParticipantsResponseModel value,
          $Res Function(_$_UserParticipantsResponseModel) then) =
      __$$_UserParticipantsResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<UserParticipantsDataResponseModel>? data});
}

/// @nodoc
class __$$_UserParticipantsResponseModelCopyWithImpl<$Res>
    extends _$UserParticipantsResponseModelCopyWithImpl<$Res,
        _$_UserParticipantsResponseModel>
    implements _$$_UserParticipantsResponseModelCopyWith<$Res> {
  __$$_UserParticipantsResponseModelCopyWithImpl(
      _$_UserParticipantsResponseModel _value,
      $Res Function(_$_UserParticipantsResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_UserParticipantsResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<UserParticipantsDataResponseModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserParticipantsResponseModel
    implements _UserParticipantsResponseModel {
  const _$_UserParticipantsResponseModel(
      {@JsonKey(name: 'data')
      final List<UserParticipantsDataResponseModel>? data})
      : _data = data;

  factory _$_UserParticipantsResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_UserParticipantsResponseModelFromJson(json);

  final List<UserParticipantsDataResponseModel>? _data;
  @override
  @JsonKey(name: 'data')
  List<UserParticipantsDataResponseModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'UserParticipantsResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserParticipantsResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserParticipantsResponseModelCopyWith<_$_UserParticipantsResponseModel>
      get copyWith => __$$_UserParticipantsResponseModelCopyWithImpl<
          _$_UserParticipantsResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserParticipantsResponseModelToJson(
      this,
    );
  }
}

abstract class _UserParticipantsResponseModel
    implements UserParticipantsResponseModel {
  const factory _UserParticipantsResponseModel(
          {@JsonKey(name: 'data')
          final List<UserParticipantsDataResponseModel>? data}) =
      _$_UserParticipantsResponseModel;

  factory _UserParticipantsResponseModel.fromJson(Map<String, dynamic> json) =
      _$_UserParticipantsResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<UserParticipantsDataResponseModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_UserParticipantsResponseModelCopyWith<_$_UserParticipantsResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

UserParticipantsDataResponseModel _$UserParticipantsDataResponseModelFromJson(
    Map<String, dynamic> json) {
  return _UserParticipantsDataResponseModel.fromJson(json);
}

/// @nodoc
mixin _$UserParticipantsDataResponseModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'event')
  EventSummaryDataResponseModel? get event =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  UserInfoWithTeamResponseModel? get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'roles')
  String? get roles => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserParticipantsDataResponseModelCopyWith<UserParticipantsDataResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserParticipantsDataResponseModelCopyWith<$Res> {
  factory $UserParticipantsDataResponseModelCopyWith(
          UserParticipantsDataResponseModel value,
          $Res Function(UserParticipantsDataResponseModel) then) =
      _$UserParticipantsDataResponseModelCopyWithImpl<$Res,
          UserParticipantsDataResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'event') EventSummaryDataResponseModel? event,
      @JsonKey(name: 'user') UserInfoWithTeamResponseModel? user,
      @JsonKey(name: 'roles') String? roles});

  $EventSummaryDataResponseModelCopyWith<$Res>? get event;
  $UserInfoWithTeamResponseModelCopyWith<$Res>? get user;
}

/// @nodoc
class _$UserParticipantsDataResponseModelCopyWithImpl<$Res,
        $Val extends UserParticipantsDataResponseModel>
    implements $UserParticipantsDataResponseModelCopyWith<$Res> {
  _$UserParticipantsDataResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? event = freezed,
    Object? user = freezed,
    Object? roles = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as EventSummaryDataResponseModel?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserInfoWithTeamResponseModel?,
      roles: freezed == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EventSummaryDataResponseModelCopyWith<$Res>? get event {
    if (_value.event == null) {
      return null;
    }

    return $EventSummaryDataResponseModelCopyWith<$Res>(_value.event!, (value) {
      return _then(_value.copyWith(event: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserInfoWithTeamResponseModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserInfoWithTeamResponseModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserParticipantsDataResponseModelCopyWith<$Res>
    implements $UserParticipantsDataResponseModelCopyWith<$Res> {
  factory _$$_UserParticipantsDataResponseModelCopyWith(
          _$_UserParticipantsDataResponseModel value,
          $Res Function(_$_UserParticipantsDataResponseModel) then) =
      __$$_UserParticipantsDataResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'event') EventSummaryDataResponseModel? event,
      @JsonKey(name: 'user') UserInfoWithTeamResponseModel? user,
      @JsonKey(name: 'roles') String? roles});

  @override
  $EventSummaryDataResponseModelCopyWith<$Res>? get event;
  @override
  $UserInfoWithTeamResponseModelCopyWith<$Res>? get user;
}

/// @nodoc
class __$$_UserParticipantsDataResponseModelCopyWithImpl<$Res>
    extends _$UserParticipantsDataResponseModelCopyWithImpl<$Res,
        _$_UserParticipantsDataResponseModel>
    implements _$$_UserParticipantsDataResponseModelCopyWith<$Res> {
  __$$_UserParticipantsDataResponseModelCopyWithImpl(
      _$_UserParticipantsDataResponseModel _value,
      $Res Function(_$_UserParticipantsDataResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? event = freezed,
    Object? user = freezed,
    Object? roles = freezed,
  }) {
    return _then(_$_UserParticipantsDataResponseModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as EventSummaryDataResponseModel?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserInfoWithTeamResponseModel?,
      roles: freezed == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserParticipantsDataResponseModel
    implements _UserParticipantsDataResponseModel {
  const _$_UserParticipantsDataResponseModel(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'event') this.event,
      @JsonKey(name: 'user') this.user,
      @JsonKey(name: 'roles') this.roles});

  factory _$_UserParticipantsDataResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_UserParticipantsDataResponseModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'event')
  final EventSummaryDataResponseModel? event;
  @override
  @JsonKey(name: 'user')
  final UserInfoWithTeamResponseModel? user;
  @override
  @JsonKey(name: 'roles')
  final String? roles;

  @override
  String toString() {
    return 'UserParticipantsDataResponseModel(id: $id, event: $event, user: $user, roles: $roles)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserParticipantsDataResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.event, event) || other.event == event) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.roles, roles) || other.roles == roles));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, event, user, roles);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserParticipantsDataResponseModelCopyWith<
          _$_UserParticipantsDataResponseModel>
      get copyWith => __$$_UserParticipantsDataResponseModelCopyWithImpl<
          _$_UserParticipantsDataResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserParticipantsDataResponseModelToJson(
      this,
    );
  }
}

abstract class _UserParticipantsDataResponseModel
    implements UserParticipantsDataResponseModel {
  const factory _UserParticipantsDataResponseModel(
          {@JsonKey(name: '_id') final String? id,
          @JsonKey(name: 'event') final EventSummaryDataResponseModel? event,
          @JsonKey(name: 'user') final UserInfoWithTeamResponseModel? user,
          @JsonKey(name: 'roles') final String? roles}) =
      _$_UserParticipantsDataResponseModel;

  factory _UserParticipantsDataResponseModel.fromJson(
          Map<String, dynamic> json) =
      _$_UserParticipantsDataResponseModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'event')
  EventSummaryDataResponseModel? get event;
  @override
  @JsonKey(name: 'user')
  UserInfoWithTeamResponseModel? get user;
  @override
  @JsonKey(name: 'roles')
  String? get roles;
  @override
  @JsonKey(ignore: true)
  _$$_UserParticipantsDataResponseModelCopyWith<
          _$_UserParticipantsDataResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
