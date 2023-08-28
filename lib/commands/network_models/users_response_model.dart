import 'package:freezed_annotation/freezed_annotation.dart';
part 'users_response_model.freezed.dart';
part 'users_response_model.g.dart';

@freezed
class UsersResponseModel with _$UsersResponseModel {
  const factory UsersResponseModel({
    @JsonKey(name: 'data') List<UserLowInfoResponseModel>? data,
  }) = _UsersResponseModel;

  factory UsersResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UsersResponseModelFromJson(json);
}

@freezed
class UserLowInfoResponseModel with _$UserLowInfoResponseModel {
  const factory UserLowInfoResponseModel({
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'name') String? name,
  }) = _UserLowInfoResponseModel;

  factory UserLowInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      _$UserLowInfoResponseModelFromJson(json);
}
