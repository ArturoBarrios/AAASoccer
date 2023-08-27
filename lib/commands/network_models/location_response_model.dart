// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'location_response_model.freezed.dart';
part 'location_response_model.g.dart';

@freezed
class LocationResponseModel with _$LocationResponseModel {
  const factory LocationResponseModel({
    @JsonKey(name: 'data') List<LocationDataResponseModel>? data,
  }) = _LocationResponseModel;

  factory LocationResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LocationResponseModelFromJson(json);
}

@freezed
class LocationDataResponseModel with _$LocationDataResponseModel {
  const factory LocationDataResponseModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'latitude') double? latitude,
    @JsonKey(name: 'longitude') double? longitude,
  }) = _LocationDataResponseModel;

  factory LocationDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$LocationDataResponseModelFromJson(json);
}
