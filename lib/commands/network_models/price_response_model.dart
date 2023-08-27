import 'package:freezed_annotation/freezed_annotation.dart';

import 'event_summary_data_response_model.dart';
part 'price_response_model.freezed.dart';
part 'price_response_model.g.dart';

@freezed
class PriceResponseModel with _$PriceResponseModel {
  const factory PriceResponseModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'amount') String? amount,
    @JsonKey(name: 'teamAmount') String? teamAmount,
    @JsonKey(name: 'event') EventSummaryDataResponseModel? event,
  }) = _PriceResponseModel;

  factory PriceResponseModel.fromJson(Map<String, dynamic> json) =>
      _$PriceResponseModelFromJson(json);
}
