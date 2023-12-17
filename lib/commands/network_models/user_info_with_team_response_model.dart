import 'package:freezed_annotation/freezed_annotation.dart';

import 'teams_response_model.dart';
part 'user_info_with_team_response_model.freezed.dart';
part 'user_info_with_team_response_model.g.dart';

@freezed
class UserInfoWithTeamResponseModel with _$UserInfoWithTeamResponseModel {
  const factory UserInfoWithTeamResponseModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'userType') String? userType,
    @JsonKey(name: 'teams') TeamsResponseModel? teams,
  }) = _UserInfoWithTeamResponseModel;

  factory UserInfoWithTeamResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserInfoWithTeamResponseModelFromJson(json);
}
