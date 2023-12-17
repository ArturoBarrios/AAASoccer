// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'games_response_model.freezed.dart';
part 'games_response_model.g.dart';

@freezed
class GamesResponseModel with _$GamesResponseModel {
  const factory GamesResponseModel({
    @JsonKey(name: 'data') List<GamesDataResponseModel>? data,
  }) = _GamesResponseModel;

  factory GamesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GamesResponseModelFromJson(json);
}

@freezed
class GamesDataResponseModel with _$GamesDataResponseModel {
  const factory GamesDataResponseModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'pickup') bool? pickup,
  }) = _GamesDataResponseModel;

  factory GamesDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$GamesDataResponseModelFromJson(json);
}
