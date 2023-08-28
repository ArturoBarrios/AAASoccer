// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_update_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_BaseUpdateResponseModel _$$_BaseUpdateResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_BaseUpdateResponseModel(
      data: json['data'] == null
          ? null
          : UpdateEventDataModel.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_BaseUpdateResponseModelToJson(
        _$_BaseUpdateResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
