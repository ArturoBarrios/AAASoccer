// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'add_social_media_apps_let.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_AddSocialMediaAppsLet _$$_AddSocialMediaAppsLetFromJson(
        Map<String, dynamic> json) =>
    _$_AddSocialMediaAppsLet(
      eventRef: json['eventRef'] == null
          ? null
          : RefBody.fromJson(json['eventRef'] as Map<String, dynamic>),
      userRef: json['userRef'] == null
          ? null
          : RefBody.fromJson(json['userRef'] as Map<String, dynamic>),
      socialMediaAppData: json['socialMediaAppData'] == null
          ? null
          : SocialMediaAppData.fromJson(
              json['socialMediaAppData'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_AddSocialMediaAppsLetToJson(
    _$_AddSocialMediaAppsLet instance) {
  final val = <String, dynamic>{};

  void writeNotNull(String key, dynamic value) {
    if (value != null) {
      val[key] = value;
    }
  }

  writeNotNull('eventRef', instance.eventRef);
  writeNotNull('userRef', instance.userRef);
  writeNotNull('socialMediaAppData', instance.socialMediaAppData);
  return val;
}
