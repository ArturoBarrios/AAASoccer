// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'update_event_data_model.dart';
part 'base_update_response_model.freezed.dart';
part 'base_update_response_model.g.dart';

@freezed
class BaseUpdateResponseModel with _$BaseUpdateResponseModel {
  const factory BaseUpdateResponseModel({
    @JsonKey(name: 'data') UpdateEventDataModel? data,
  }) = _BaseUpdateResponseModel;

  factory BaseUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$BaseUpdateResponseModelFromJson(json);
}
