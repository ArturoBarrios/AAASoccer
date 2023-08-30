import 'package:freezed_annotation/freezed_annotation.dart';
part 'var_body.freezed.dart';
part 'var_body.g.dart';

@freezed
class VarBody with _$VarBody {
  const factory VarBody({
    @JsonKey(name: 'var') String? varProperty,
  }) = _VarBody;

  factory VarBody.fromJson(Map<String, dynamic> json) =>
      _$VarBodyFromJson(json);
}
