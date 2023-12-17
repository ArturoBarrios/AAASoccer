import 'package:freezed_annotation/freezed_annotation.dart';

import 'event_response_model.dart';
part 'update_event_data_model.freezed.dart';
part 'update_event_data_model.g.dart';

@freezed
class UpdateEventDataModel with _$UpdateEventDataModel {
  const factory UpdateEventDataModel({
    @JsonKey(name: 'updateEvent') EventResponseModel? updateEvent,
  }) = _UpdateEventDataModel;

  factory UpdateEventDataModel.fromJson(Map<String, dynamic> json) =>
      _$UpdateEventDataModelFromJson(json);
}
