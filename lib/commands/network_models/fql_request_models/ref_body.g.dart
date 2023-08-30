// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ref_body.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_RefBody _$$_RefBodyFromJson(Map<String, dynamic> json) => _$_RefBody(
      ref: json['ref'] == null
          ? null
          : CollectionBody.fromJson(json['ref'] as Map<String, dynamic>),
      id: json['id'] as String?,
    );

Map<String, dynamic> _$$_RefBodyToJson(_$_RefBody instance) =>
    <String, dynamic>{
      'ref': instance.ref,
      'id': instance.id,
    };
