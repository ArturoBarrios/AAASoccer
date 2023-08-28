// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'update_event_data_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UpdateEventDataModel _$$_UpdateEventDataModelFromJson(
        Map<String, dynamic> json) =>
    _$_UpdateEventDataModel(
      updateEvent: json['updateEvent'] == null
          ? null
          : EventResponseModel.fromJson(
              json['updateEvent'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_UpdateEventDataModelToJson(
        _$_UpdateEventDataModel instance) =>
    <String, dynamic>{
      'updateEvent': instance.updateEvent,
    };
