import 'package:freezed_annotation/freezed_annotation.dart';
part 'tournaments_response_model.freezed.dart';
part 'tournaments_response_model.g.dart';

@freezed
class TournamentsResponseModel with _$TournamentsResponseModel {
  const factory TournamentsResponseModel({
    @JsonKey(name: 'data') List<String>? data,
  }) = _TournamentsResponseModel;

  factory TournamentsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TournamentsResponseModelFromJson(json);
}
