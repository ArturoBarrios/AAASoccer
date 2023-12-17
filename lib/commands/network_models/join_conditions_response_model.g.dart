// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'join_conditions_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_JoinConditionsResponseModel _$$_JoinConditionsResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_JoinConditionsResponseModel(
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => JoinConditionsDataResponseModel.fromJson(
              e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$_JoinConditionsResponseModelToJson(
        _$_JoinConditionsResponseModel instance) =>
    <String, dynamic>{
      'data': instance.data,
    };

_$_JoinConditionsDataResponseModel _$$_JoinConditionsDataResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_JoinConditionsDataResponseModel(
      id: json['_id'] as String?,
      withRequest: json['withRequest'] as bool?,
      withPayment: json['withPayment'] as bool?,
      forTeam: json['forTeam'] as bool?,
      forEvent: json['forEvent'] as bool?,
    );

Map<String, dynamic> _$$_JoinConditionsDataResponseModelToJson(
        _$_JoinConditionsDataResponseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'withRequest': instance.withRequest,
      'withPayment': instance.withPayment,
      'forTeam': instance.forTeam,
      'forEvent': instance.forEvent,
    };
