import 'package:freezed_annotation/freezed_annotation.dart';
part 'teams_response_model.freezed.dart';
part 'teams_response_model.g.dart';

@freezed
class TeamsResponseModel with _$TeamsResponseModel {
  const factory TeamsResponseModel({
    @JsonKey(name: 'data') List<String>? data,
  }) = _TeamsResponseModel;

  factory TeamsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TeamsResponseModelFromJson(json);
}
