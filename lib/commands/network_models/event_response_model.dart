// ignore_for_file: invalid_annotation_target

import 'package:freezed_annotation/freezed_annotation.dart';
import 'chats_response_model.dart';
import 'games_response_model.dart';
import 'images_response_model.dart';
import 'join_conditions_response_model.dart';
import 'leagues_response_model.dart';
import 'location_response_model.dart';
import 'price_response_model.dart';
import 'requests_response_model.dart';
import 'social_media_apps_response_model.dart';
import 'teams_response_model.dart';
import 'tournaments_response_model.dart';
import 'trainings_response_model.dart';
import 'tryouts_response_model.dart';
import 'user_participants_response_model.dart';

import 'payments_response_model.dart';

part 'event_response_model.freezed.dart';
part 'event_response_model.g.dart';

@freezed
class EventResponseModel with _$EventResponseModel {
  const factory EventResponseModel({
    @JsonKey(name: 'name') String? name,
    @JsonKey(name: '_id') String? id,
    @JsonKey(name: 'type') String? type,
    @JsonKey(name: 'isMainEvent') bool? isMainEvent,
    @JsonKey(name: 'mainImageKey') String? mainImageKey,
    @JsonKey(name: 'archived') bool? archived,
    @JsonKey(name: 'deleted') String? deleted,
    @JsonKey(name: 'startTime') String? startTime,
    @JsonKey(name: 'endTime') String? endTime,
    @JsonKey(name: 'capacity') int? capacity,
    @JsonKey(name: 'createdAt') String? createdAt,
    @JsonKey(name: 'requests') RequestsResponseModel? requests,
    @JsonKey(name: 'images') ImagesResponseModel? images,
    @JsonKey(name: 'chats') ChatsResponseModel? chats,
    @JsonKey(name: 'SocialMediaApps')
        SocialMediaAppsResponseModel? socialMediaApps,
    @JsonKey(name: 'joinConditions')
        JoinConditionsResponseModel? joinConditions,
    @JsonKey(name: 'price') PriceResponseModel? price,
    @JsonKey(name: 'games') GamesResponseModel? games,
    @JsonKey(name: 'trainings') TrainingsResponseModel? trainings,
    @JsonKey(name: 'tryouts') TryoutsResponseModel? tryouts,
    @JsonKey(name: 'tournaments') TournamentsResponseModel? tournaments,
    @JsonKey(name: 'leagues') LeaguesResponseModel? leagues,
    @JsonKey(name: 'teams') TeamsResponseModel? teams,
    @JsonKey(name: 'location') LocationResponseModel? location,
    @JsonKey(name: 'userParticipants')
        UserParticipantsResponseModel? userParticipants,
    @JsonKey(name: 'payments') PaymentsResponseModel? payments,
  }) = _EventResponseModel;

  factory EventResponseModel.fromJson(Map<String, Object?> json) =>
      _$EventResponseModelFromJson(json);
}
