import 'package:freezed_annotation/freezed_annotation.dart';

import 'var_body.dart';
part 'object_params_body.freezed.dart';
part 'object_params_body.g.dart';

@freezed
class ObjectParamsBody with _$ObjectParamsBody {
  const factory ObjectParamsBody({
    @JsonKey(name: 'object') ObjectParamsBodyData? objectObjectParamsBody,
  }) = _ObjectParamsBody;

  factory ObjectParamsBody.fromJson(Map<String, Object?> json) =>
      _$ObjectParamsBodyFromJson(json);
}

@freezed
class ObjectParamsBodyData with _$ObjectParamsBodyData {
  const factory ObjectParamsBodyData({
    @JsonKey(name: 'data') VarBody? data,
  }) = _ObjectParamsBodyData;

  factory ObjectParamsBodyData.fromJson(Map<String, Object?> json) =>
      _$ObjectParamsBodyDataFromJson(json);
}
