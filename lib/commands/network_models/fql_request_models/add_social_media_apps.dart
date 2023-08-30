import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:soccermadeeasy/commands/network_models/fql_request_models/in_body.dart';

import 'add_social_media_apps_let.dart';
part 'add_social_media_apps.freezed.dart';
part 'add_social_media_apps.g.dart';

@freezed
class AddSocialMediaApps with _$AddSocialMediaApps {
  const factory AddSocialMediaApps({
    @JsonKey(name: 'let') List<AddSocialMediaAppsLet>? let,
    @JsonKey(name: 'in') InBody? inProperty,
  }) = _AddSocialMediaApps;

  factory AddSocialMediaApps.fromJson(Map<String, Object?> json) =>
      _$AddSocialMediaAppsFromJson(json);
}
