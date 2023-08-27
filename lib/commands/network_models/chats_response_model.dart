// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';

import 'event_summary_data_response_model.dart';
import 'messages_response_model.dart';
import 'users_response_model.dart';
part 'chats_response_model.freezed.dart';
part 'chats_response_model.g.dart';

@freezed
class ChatsResponseModel with _$ChatsResponseModel {
  const factory ChatsResponseModel({
    @JsonKey(name: 'data') List<ChatsDataResponseModel>? data,
  }) = _ChatsResponseModel;

  factory ChatsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$ChatsResponseModelFromJson(json);
}

@freezed
class ChatsDataResponseModel with _$ChatsDataResponseModel {
  const factory ChatsDataResponseModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'isPrivate') bool? isPrivate,
    @JsonKey(name: 'mainImageKey') String? mainImageKey,
    @JsonKey(name: 'users') UsersResponseModel? users,
    @JsonKey(name: 'event') EventSummaryDataResponseModel? eventDataChats,
    @JsonKey(name: 'team') String? team,
    @JsonKey(name: 'messages') MessagesResponseModel? messages,
  }) = _ChatsDataResponseModel;

  factory ChatsDataResponseModel.fromJson(Map<String, Object?> json) =>
      _$ChatsDataResponseModelFromJson(json);
}
