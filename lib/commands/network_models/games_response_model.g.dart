// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'games_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_GamesResponseModel _$$_GamesResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_GamesResponseModel(
      data: (json['data'] as List<dynamic>?)
          ?.map(
              (e) => GamesDataResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_GamesResponseModelToJson(
        _$_GamesResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$_GamesDataResponseModel _$$_GamesDataResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_GamesDataResponseModel(
      id: json['_id'] as String?,
      pickup: json['pickup'] as bool?,
    );

Map<String, dynamic> _$$_GamesDataResponseModelToJson(
        _$_GamesDataResponseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'pickup': instance.pickup,
    };
