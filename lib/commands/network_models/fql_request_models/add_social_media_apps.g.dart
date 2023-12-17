// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_social_media_apps.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddSocialMediaApps _$$_AddSocialMediaAppsFromJson(
        Map<String, dynamic> json) =>
    _$_AddSocialMediaApps(
      let: (json['let'] as List<dynamic>?)
          ?.map(
              (e) => AddSocialMediaAppsLet.fromJson(e as Map<String, dynamic>))
          .toList(),
      inProperty: json['in'] == null
          ? null
          : InBody.fromJson(json['in'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AddSocialMediaAppsToJson(
        _$_AddSocialMediaApps instance) =>
    <String, dynamic>{
      'let': instance.let,
      'in': instance.inProperty,
    };
