// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_info_with_team_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UserInfoWithTeamResponseModel _$UserInfoWithTeamResponseModelFromJson(
    Map<String, dynamic> json) {
  return _UserInfoWithTeamResponseModel.fromJson(json);
}

/// @nodoc
mixin _$UserInfoWithTeamResponseModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'email')
  String? get email => throw _privateConstructorUsedError;
  @JsonKey(name: 'username')
  String? get username => throw _privateConstructorUsedError;
  @JsonKey(name: 'userType')
  String? get userType => throw _privateConstructorUsedError;
  @JsonKey(name: 'teams')
  TeamsResponseModel? get teams => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UserInfoWithTeamResponseModelCopyWith<UserInfoWithTeamResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserInfoWithTeamResponseModelCopyWith<$Res> {
  factory $UserInfoWithTeamResponseModelCopyWith(
          UserInfoWithTeamResponseModel value,
          $Res Function(UserInfoWithTeamResponseModel) then) =
      _$UserInfoWithTeamResponseModelCopyWithImpl<$Res,
          UserInfoWithTeamResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'username') String? username,
      @JsonKey(name: 'userType') String? userType,
      @JsonKey(name: 'teams') TeamsResponseModel? teams});

  $TeamsResponseModelCopyWith<$Res>? get teams;
}

/// @nodoc
class _$UserInfoWithTeamResponseModelCopyWithImpl<$Res,
        $Val extends UserInfoWithTeamResponseModel>
    implements $UserInfoWithTeamResponseModelCopyWith<$Res> {
  _$UserInfoWithTeamResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? username = freezed,
    Object? userType = freezed,
    Object? teams = freezed,
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
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      teams: freezed == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as TeamsResponseModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $TeamsResponseModelCopyWith<$Res>? get teams {
    if (_value.teams == null) {
      return null;
    }

    return $TeamsResponseModelCopyWith<$Res>(_value.teams!, (value) {
      return _then(_value.copyWith(teams: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UserInfoWithTeamResponseModelCopyWith<$Res>
    implements $UserInfoWithTeamResponseModelCopyWith<$Res> {
  factory _$$_UserInfoWithTeamResponseModelCopyWith(
          _$_UserInfoWithTeamResponseModel value,
          $Res Function(_$_UserInfoWithTeamResponseModel) then) =
      __$$_UserInfoWithTeamResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'email') String? email,
      @JsonKey(name: 'username') String? username,
      @JsonKey(name: 'userType') String? userType,
      @JsonKey(name: 'teams') TeamsResponseModel? teams});

  @override
  $TeamsResponseModelCopyWith<$Res>? get teams;
}

/// @nodoc
class __$$_UserInfoWithTeamResponseModelCopyWithImpl<$Res>
    extends _$UserInfoWithTeamResponseModelCopyWithImpl<$Res,
        _$_UserInfoWithTeamResponseModel>
    implements _$$_UserInfoWithTeamResponseModelCopyWith<$Res> {
  __$$_UserInfoWithTeamResponseModelCopyWithImpl(
      _$_UserInfoWithTeamResponseModel _value,
      $Res Function(_$_UserInfoWithTeamResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? email = freezed,
    Object? username = freezed,
    Object? userType = freezed,
    Object? teams = freezed,
  }) {
    return _then(_$_UserInfoWithTeamResponseModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      username: freezed == username
          ? _value.username
          : username // ignore: cast_nullable_to_non_nullable
              as String?,
      userType: freezed == userType
          ? _value.userType
          : userType // ignore: cast_nullable_to_non_nullable
              as String?,
      teams: freezed == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as TeamsResponseModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UserInfoWithTeamResponseModel
    implements _UserInfoWithTeamResponseModel {
  const _$_UserInfoWithTeamResponseModel(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'email') this.email,
      @JsonKey(name: 'username') this.username,
      @JsonKey(name: 'userType') this.userType,
      @JsonKey(name: 'teams') this.teams});

  factory _$_UserInfoWithTeamResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_UserInfoWithTeamResponseModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'email')
  final String? email;
  @override
  @JsonKey(name: 'username')
  final String? username;
  @override
  @JsonKey(name: 'userType')
  final String? userType;
  @override
  @JsonKey(name: 'teams')
  final TeamsResponseModel? teams;

  @override
  String toString() {
    return 'UserInfoWithTeamResponseModel(id: $id, name: $name, email: $email, username: $username, userType: $userType, teams: $teams)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UserInfoWithTeamResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.username, username) ||
                other.username == username) &&
            (identical(other.userType, userType) ||
                other.userType == userType) &&
            (identical(other.teams, teams) || other.teams == teams));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, email, username, userType, teams);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UserInfoWithTeamResponseModelCopyWith<_$_UserInfoWithTeamResponseModel>
      get copyWith => __$$_UserInfoWithTeamResponseModelCopyWithImpl<
          _$_UserInfoWithTeamResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UserInfoWithTeamResponseModelToJson(
      this,
    );
  }
}

abstract class _UserInfoWithTeamResponseModel
    implements UserInfoWithTeamResponseModel {
  const factory _UserInfoWithTeamResponseModel(
          {@JsonKey(name: '_id') final String? id,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'email') final String? email,
          @JsonKey(name: 'username') final String? username,
          @JsonKey(name: 'userType') final String? userType,
          @JsonKey(name: 'teams') final TeamsResponseModel? teams}) =
      _$_UserInfoWithTeamResponseModel;

  factory _UserInfoWithTeamResponseModel.fromJson(Map<String, dynamic> json) =
      _$_UserInfoWithTeamResponseModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'email')
  String? get email;
  @override
  @JsonKey(name: 'username')
  String? get username;
  @override
  @JsonKey(name: 'userType')
  String? get userType;
  @override
  @JsonKey(name: 'teams')
  TeamsResponseModel? get teams;
  @override
  @JsonKey(ignore: true)
  _$$_UserInfoWithTeamResponseModelCopyWith<_$_UserInfoWithTeamResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
