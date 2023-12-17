// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'leagues_response_model.freezed.dart';
part 'leagues_response_model.g.dart';

@freezed
class LeaguesResponseModel with _$LeaguesResponseModel {
  const factory LeaguesResponseModel({
    @JsonKey(name: 'data') List<String>? data,
  }) = _LeaguesResponseModel;

  factory LeaguesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LeaguesResponseModelFromJson(json);
}
