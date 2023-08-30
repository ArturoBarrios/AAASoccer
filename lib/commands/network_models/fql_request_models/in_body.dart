import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:soccermadeeasy/commands/network_models/fql_request_models/collection_body.dart';

import 'object_params_body.dart';
part 'in_body.freezed.dart';
part 'in_body.g.dart';

@freezed
class InBody with _$InBody {
  const factory InBody({
    @JsonKey(name: 'create') CollectionBody? create,
    @JsonKey(name: 'params') ObjectParamsBody? params,
  }) = _InBody;

  factory InBody.fromJson(Map<String, Object?> json) => _$InBodyFromJson(json);
}
