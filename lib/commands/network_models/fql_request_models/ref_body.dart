import 'package:freezed_annotation/freezed_annotation.dart';

import 'collection_body.dart';
part 'ref_body.freezed.dart';
part 'ref_body.g.dart';

@freezed
class RefBody with _$RefBody {
  const factory RefBody({
    @JsonKey(name: 'ref') CollectionBody? ref,
    @JsonKey(name: 'id') String? id,
  }) = _RefBody;

  factory RefBody.fromJson(Map<String, Object?> json) =>
      _$RefBodyFromJson(json);
}
