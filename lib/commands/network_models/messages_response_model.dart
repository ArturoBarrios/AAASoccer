// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
part 'messages_response_model.freezed.dart';
part 'messages_response_model.g.dart';

@freezed
class MessagesResponseModel with _$MessagesResponseModel {
  const factory MessagesResponseModel({
    @JsonKey(name: 'data') List<String>? data,
  }) = _MessagesResponseModel;

  factory MessagesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$MessagesResponseModelFromJson(json);
}
