// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'social_media_app_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_SocialMediaAppData _$$_SocialMediaAppDataFromJson(
        Map<String, dynamic> json) =>
    _$_SocialMediaAppData(
      object: json['object'] == null
          ? null
          : SocialMediaAppObjectData.fromJson(
              json['object'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SocialMediaAppDataToJson(
        _$_SocialMediaAppData instance) =>
    <String, dynamic>{
      'object': instance.object,
    };

_$_SocialMediaAppObjectData _$$_SocialMediaAppObjectDataFromJson(
        Map<String, dynamic> json) =>
    _$_SocialMediaAppObjectData(
      type: json['type'] as String?,
      url: json['url'] as String?,
      user: json['user'] == null
          ? null
          : VarBody.fromJson(json['user'] as Map<String, dynamic>),
      event: json['event'] == null
          ? null
          : VarBody.fromJson(json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_SocialMediaAppObjectDataToJson(
        _$_SocialMediaAppObjectData instance) =>
    <String, dynamic>{
      'type': instance.type,
      'url': instance.url,
      'user': instance.user,
      'event': instance.event,
    };
