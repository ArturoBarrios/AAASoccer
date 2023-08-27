import 'package:freezed_annotation/freezed_annotation.dart';

import 'event_summary_data_response_model.dart';
import 'user_mid_info_response_model.dart';
part 'social_media_apps_response_model.freezed.dart';
part 'social_media_apps_response_model.g.dart';

@freezed
class SocialMediaAppsResponseModel with _$SocialMediaAppsResponseModel {
  const factory SocialMediaAppsResponseModel({
    @JsonKey(name: 'data') List<SocialMediaAppsDataResponseModel>? data,
  }) = _SocialMediaAppsResponseModel;

  factory SocialMediaAppsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$SocialMediaAppsResponseModelFromJson(json);
}

@freezed
class SocialMediaAppsDataResponseModel with _$SocialMediaAppsDataResponseModel {
  const factory SocialMediaAppsDataResponseModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'user') UserMidInfoResponseModel? user,
    @JsonKey(name: 'team') String? team,
    @JsonKey(name: 'event') EventSummaryDataResponseModel? event,
  }) = _SocialMediaAppsDataResponseModel;

  factory SocialMediaAppsDataResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$SocialMediaAppsDataResponseModelFromJson(json);
}
