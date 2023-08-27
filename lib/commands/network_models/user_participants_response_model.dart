import 'package:freezed_annotation/freezed_annotation.dart';

import 'event_summary_data_response_model.dart';
import 'user_info_with_team_response_model.dart';

part 'user_participants_response_model.freezed.dart';
part 'user_participants_response_model.g.dart';

@freezed
class UserParticipantsResponseModel with _$UserParticipantsResponseModel {
  const factory UserParticipantsResponseModel({
    @JsonKey(name: 'data') List<UserParticipantsDataResponseModel>? data,
  }) = _UserParticipantsResponseModel;

  factory UserParticipantsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserParticipantsResponseModelFromJson(json);
}

@freezed
class UserParticipantsDataResponseModel
    with _$UserParticipantsDataResponseModel {
  const factory UserParticipantsDataResponseModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'event') EventSummaryDataResponseModel? event,
    @JsonKey(name: 'user') UserInfoWithTeamResponseModel? user,
    @JsonKey(name: 'roles') String? roles,
  }) = _UserParticipantsDataResponseModel;

  factory UserParticipantsDataResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$UserParticipantsDataResponseModelFromJson(json);
}
