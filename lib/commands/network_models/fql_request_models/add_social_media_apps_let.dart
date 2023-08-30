import 'package:freezed_annotation/freezed_annotation.dart';

import 'collection_body.dart';
import 'ref_body.dart';
import 'social_media_app_data.dart';
part 'add_social_media_apps_let.freezed.dart';
part 'add_social_media_apps_let.g.dart';

@freezed
class AddSocialMediaAppsLet with _$AddSocialMediaAppsLet {
  const factory AddSocialMediaAppsLet({
    @JsonKey(name: 'eventRef', includeIfNull: false) RefBody? eventRef,
    @JsonKey(name: 'userRef', includeIfNull: false) RefBody? userRef,
    @JsonKey(name: 'socialMediaAppData', includeIfNull: false)
        SocialMediaAppData? socialMediaAppData,
  }) = _AddSocialMediaAppsLet;

  factory AddSocialMediaAppsLet.fromJson(Map<String, Object?> json) =>
      _$AddSocialMediaAppsLetFromJson(json);
}
