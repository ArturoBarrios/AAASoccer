// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'payments_response_model.freezed.dart';
part 'payments_response_model.g.dart';

@freezed
class PaymentsResponseModel with _$PaymentsResponseModel {
  const factory PaymentsResponseModel({
    @JsonKey(name: 'data') List<String>? data,
  }) = _PaymentsResponseModel;

  factory PaymentsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PaymentsResponseModelFromJson(json);
}
