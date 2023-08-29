// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'object_params_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_ObjectParamsBody _$$_ObjectParamsBodyFromJson(Map<String, dynamic> json) =>
    _$_ObjectParamsBody(
      objectObjectParamsBody: json['object'] == null
          ? null
          : ObjectParamsBodyData.fromJson(
              json['object'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ObjectParamsBodyToJson(_$_ObjectParamsBody instance) =>
    <String, dynamic>{
      'object': instance.objectObjectParamsBody,
    };

_$_ObjectParamsBodyData _$$_ObjectParamsBodyDataFromJson(
        Map<String, dynamic> json) =>
    _$_ObjectParamsBodyData(
      data: json['data'] == null
          ? null
          : VarBody.fromJson(json['data'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_ObjectParamsBodyDataToJson(
        _$_ObjectParamsBodyData instance) =>
    <String, dynamic>{
      'data': instance.data,
    };
