// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_participants_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UserParticipantsResponseModel _$$_UserParticipantsResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_UserParticipantsResponseModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => UserParticipantsDataResponseModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UserParticipantsResponseModelToJson(
        _$_UserParticipantsResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$_UserParticipantsDataResponseModel
    _$$_UserParticipantsDataResponseModelFromJson(Map<String, dynamic> json) =>
        _$_UserParticipantsDataResponseModel(
          id: json['_id'] as String?,
          event: json['event'] == null
              ? null
              : EventSummaryDataResponseModel.fromJson(
                  json['event'] as Map<String, dynamic>),
          user: json['user'] == null
              ? null
              : UserInfoWithTeamResponseModel.fromJson(
                  json['user'] as Map<String, dynamic>),
          roles: json['roles'] as String?,
        );

Map<String, dynamic> _$$_UserParticipantsDataResponseModelToJson(
        _$_UserParticipantsDataResponseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'event': instance.event,
      'user': instance.user,
      'roles': instance.roles,
    };
