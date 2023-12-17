// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'join_conditions_response_model.freezed.dart';
part 'join_conditions_response_model.g.dart';

@freezed
class JoinConditionsResponseModel with _$JoinConditionsResponseModel {
  const factory JoinConditionsResponseModel({
    @JsonKey(name: 'data') List<JoinConditionsDataResponseModel>? data,
  }) = _JoinConditionsResponseModel;

  factory JoinConditionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$JoinConditionsResponseModelFromJson(json);
}

@freezed
class JoinConditionsDataResponseModel with _$JoinConditionsDataResponseModel {
  const factory JoinConditionsDataResponseModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'withRequest') bool? withRequest,
    @JsonKey(name: 'withPayment') bool? withPayment,
    @JsonKey(name: 'forTeam') bool? forTeam,
    @JsonKey(name: 'forEvent') bool? forEvent,
  }) = _JoinConditionsDataResponseModel;

  factory JoinConditionsDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$JoinConditionsDataResponseModelFromJson(json);
}
