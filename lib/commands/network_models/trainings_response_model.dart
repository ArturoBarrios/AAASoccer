import 'package:freezed_annotation/freezed_annotation.dart';
part 'trainings_response_model.freezed.dart';
part 'trainings_response_model.g.dart';

@freezed
class TrainingsResponseModel with _$TrainingsResponseModel {
  const factory TrainingsResponseModel({
    @JsonKey(name: 'data') List<String>? data,
  }) = _TrainingsResponseModel;

  factory TrainingsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TrainingsResponseModelFromJson(json);
}
