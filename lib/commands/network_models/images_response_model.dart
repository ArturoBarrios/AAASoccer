// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'images_response_model.freezed.dart';
part 'images_response_model.g.dart';

@freezed
class ImagesResponseModel with _$ImagesResponseModel {
  const factory ImagesResponseModel({
    @JsonKey(name: 'data') List<String>? data,
  }) = _ImagesResponseModel;

  factory ImagesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ImagesResponseModelFromJson(json);
}
