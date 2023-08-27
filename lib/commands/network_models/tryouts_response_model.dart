import 'package:freezed_annotation/freezed_annotation.dart';
part 'tryouts_response_model.freezed.dart';
part 'tryouts_response_model.g.dart';

@freezed
class TryoutsResponseModel with _$TryoutsResponseModel {
  const factory TryoutsResponseModel({
    @JsonKey(name: 'data') List<String>? data,
  }) = _TryoutsResponseModel;

  factory TryoutsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$TryoutsResponseModelFromJson(json);
}
