import 'package:freezed_annotation/freezed_annotation.dart';
part 'requests_response_model.freezed.dart';
part 'requests_response_model.g.dart';

@freezed
class RequestsResponseModel with _$RequestsResponseModel {
  const factory RequestsResponseModel({
    @JsonKey(name: 'data') List<String>? data,
  }) = _RequestsResponseModel;

  factory RequestsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$RequestsResponseModelFromJson(json);
}
