// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'chats_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ChatsResponseModel _$$_ChatsResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_ChatsResponseModel(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => ChatsDataResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_ChatsResponseModelToJson(
        _$_ChatsResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$_ChatsDataResponseModel _$$_ChatsDataResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_ChatsDataResponseModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
      isPrivate: json['isPrivate'] as bool?,
      mainImageKey: json['mainImageKey'] as String?,
      users: json['users'] == null
          ? null
          : UsersResponseModel.fromJson(json['users'] as Map<String, dynamic>),
      eventDataChats: json['event'] == null
          ? null
          : EventSummaryDataResponseModel.fromJson(
              json['event'] as Map<String, dynamic>),
      team: json['team'] as String?,
      messages: json['messages'] == null
          ? null
          : MessagesResponseModel.fromJson(
              json['messages'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ChatsDataResponseModelToJson(
        _$_ChatsDataResponseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
      'isPrivate': instance.isPrivate,
      'mainImageKey': instance.mainImageKey,
      'users': instance.users,
      'event': instance.eventDataChats,
      'team': instance.team,
      'messages': instance.messages,
    };
