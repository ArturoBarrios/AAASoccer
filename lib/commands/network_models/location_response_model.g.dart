// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'location_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_LocationResponseModel _$$_LocationResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_LocationResponseModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              LocationDataResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_LocationResponseModelToJson(
        _$_LocationResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$_LocationDataResponseModel _$$_LocationDataResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_LocationDataResponseModel(
      name: json['name'] as String?,
      id: json['_id'] as String?,
      latitude: (json['latitude'] as num?)?.toDouble(),
      longitude: (json['longitude'] as num?)?.toDouble(),
    );

Map<String, dynamic> _$$_LocationDataResponseModelToJson(
        _$_LocationDataResponseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      '_id': instance.id,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
    };
