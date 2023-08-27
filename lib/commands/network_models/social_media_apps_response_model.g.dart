// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_media_apps_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SocialMediaAppsResponseModel _$$_SocialMediaAppsResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_SocialMediaAppsResponseModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => SocialMediaAppsDataResponseModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_SocialMediaAppsResponseModelToJson(
        _$_SocialMediaAppsResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$_SocialMediaAppsDataResponseModel
    _$$_SocialMediaAppsDataResponseModelFromJson(Map<String, dynamic> json) =>
        _$_SocialMediaAppsDataResponseModel(
          id: json['_id'] as String?,
          type: json['type'] as String?,
          url: json['url'] as String?,
          user: json['user'] == null
              ? null
              : UserMidInfoResponseModel.fromJson(
                  json['user'] as Map<String, dynamic>),
          team: json['team'] as String?,
          event: json['event'] == null
              ? null
              : EventSummaryDataResponseModel.fromJson(
                  json['event'] as Map<String, dynamic>),
        );

Map<String, dynamic> _$$_SocialMediaAppsDataResponseModelToJson(
        _$_SocialMediaAppsDataResponseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'type': instance.type,
      'url': instance.url,
      'user': instance.user,
      'team': instance.team,
      'event': instance.event,
    };
