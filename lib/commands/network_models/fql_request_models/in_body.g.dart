// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'in_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_InBody _$$_InBodyFromJson(Map<String, dynamic> json) => _$_InBody(
      create: json['create'] == null
          ? null
          : CollectionBody.fromJson(json['create'] as Map<String, dynamic>),
      params: json['params'] == null
          ? null
          : ObjectParamsBody.fromJson(json['params'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_InBodyToJson(_$_InBody instance) => <String, dynamic>{
      'create': instance.create,
      'params': instance.params,
    };
