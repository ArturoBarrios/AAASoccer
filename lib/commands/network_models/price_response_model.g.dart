// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_PriceResponseModel _$$_PriceResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_PriceResponseModel(
      id: json['_id'] as String?,
      amount: json['amount'] as String?,
      teamAmount: json['teamAmount'] as String?,
      event: json['event'] == null
          ? null
          : EventSummaryDataResponseModel.fromJson(
              json['event'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_PriceResponseModelToJson(
        _$_PriceResponseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'amount': instance.amount,
      'teamAmount': instance.teamAmount,
      'event': instance.event,
    };
