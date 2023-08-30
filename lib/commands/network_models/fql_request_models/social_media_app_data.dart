import 'package:freezed_annotation/freezed_annotation.dart';
import 'var_body.dart';

part 'social_media_app_data.freezed.dart';
part 'social_media_app_data.g.dart';

@freezed
class SocialMediaAppData with _$SocialMediaAppData {
  const factory SocialMediaAppData({
    @JsonKey(name: 'object') SocialMediaAppObjectData? object,
  }) = _SocialMediaAppData;

  factory SocialMediaAppData.fromJson(Map<String, Object?> json) =>
      _$SocialMediaAppDataFromJson(json);
}

@freezed
class SocialMediaAppObjectData with _$SocialMediaAppObjectData {
  const factory SocialMediaAppObjectData({
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'url') String? url,
    @JsonKey(name: 'user') VarBody? user,
    @JsonKey(name: 'event') VarBody? event,
  }) = _SocialMediaAppObjectData;

  factory SocialMediaAppObjectData.fromJson(Map<String, Object?> json) =>
      _$SocialMediaAppObjectDataFromJson(json);
}
