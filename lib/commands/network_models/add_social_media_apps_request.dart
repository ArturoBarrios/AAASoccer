import 'package:freezed_annotation/freezed_annotation.dart';
part 'add_social_media_apps_request.freezed.dart';

@freezed
class AddSocialMediaAppsRequest with _$AddSocialMediaAppsRequest {
  const factory AddSocialMediaAppsRequest({
    String? eventId,
    String? userId,
    String? socialMediaType,
    String? socialMediaUrl,
  }) = _AddSocialMediaAppsRequest;
}
