import 'package:freezed_annotation/freezed_annotation.dart';
part 'collection_body.freezed.dart';
part 'collection_body.g.dart';

@freezed
class CollectionBody with _$CollectionBody {
  const factory CollectionBody({
    @JsonKey(name: 'collection') String? collection,
  }) = _CollectionBody;

  factory CollectionBody.fromJson(Map<String, Object?> json) =>
      _$CollectionBodyFromJson(json);
}
