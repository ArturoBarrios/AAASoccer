// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'users_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_UsersResponseModel _$$_UsersResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_UsersResponseModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) =>
              UserLowInfoResponseModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_UsersResponseModelToJson(
        _$_UsersResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$_UserLowInfoResponseModel _$$_UserLowInfoResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_UserLowInfoResponseModel(
      id: json['_id'] as String?,
      name: json['name'] as String?,
    );

Map<String, dynamic> _$$_UserLowInfoResponseModelToJson(
        _$_UserLowInfoResponseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'name': instance.name,
    };
