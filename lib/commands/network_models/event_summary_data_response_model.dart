// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'event_summary_data_response_model.freezed.dart';
part 'event_summary_data_response_model.g.dart';

@freezed
class EventSummaryDataResponseModel with _$EventSummaryDataResponseModel {
  const factory EventSummaryDataResponseModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'name') String? name,
  }) = _EventSummaryDataResponseModel;

  factory EventSummaryDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$EventSummaryDataResponseModelFromJson(json);
}
