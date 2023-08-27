// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_info_with_team_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserInfoWithTeamResponseModel _$$_UserInfoWithTeamResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_UserInfoWithTeamResponseModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      email: json['email'] as String?,
      username: json['username'] as String?,
      userType: json['userType'] as String?,
      teams: json['teams'] == null
          ? null
          : TeamsResponseModel.fromJson(json['teams'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UserInfoWithTeamResponseModelToJson(
        _$_UserInfoWithTeamResponseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'username': instance.username,
      'userType': instance.userType,
      'teams': instance.teams,
    };
