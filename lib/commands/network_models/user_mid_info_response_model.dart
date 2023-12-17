import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_mid_info_response_model.freezed.dart';
part 'user_mid_info_response_model.g.dart';

@freezed
class UserMidInfoResponseModel with _$UserMidInfoResponseModel {
  const factory UserMidInfoResponseModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: 'email') String? email,
    @JsonKey(name: 'username') String? username,
    @JsonKey(name: 'userType') String? userType,
  }) = _UserMidInfoResponseModel;

  factory UserMidInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserMidInfoResponseModelFromJson(json);
}
