// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_EventResponseModel _$$_EventResponseModelFromJson(
        Map<String, dynamic> json) =>
    _$_EventResponseModel(
      name: json['name'] as String?,
      id: json['_id'] as String?,
      type: json['type'] as String?,
      isMainEvent: json['isMainEvent'] as bool?,
      mainImageKey: json['mainImageKey'] as String?,
      archived: json['archived'] as bool?,
      deleted: json['deleted'] as String?,
      startTime: json['startTime'] as String?,
      endTime: json['endTime'] as String?,
      capacity: json['capacity'] as int?,
      createdAt: json['createdAt'] as String?,
      requests: json['requests'] == null
          ? null
          : RequestsResponseModel.fromJson(
              json['requests'] as Map<String, dynamic>),
      images: json['images'] == null
          ? null
          : ImagesResponseModel.fromJson(
              json['images'] as Map<String, dynamic>),
      chats: json['chats'] == null
          ? null
          : ChatsResponseModel.fromJson(json['chats'] as Map<String, dynamic>),
      socialMediaApps: json['SocialMediaApps'] == null
          ? null
          : SocialMediaAppsResponseModel.fromJson(
              json['SocialMediaApps'] as Map<String, dynamic>),
      joinConditions: json['joinConditions'] == null
          ? null
          : JoinConditionsResponseModel.fromJson(
              json['joinConditions'] as Map<String, dynamic>),
      price: json['price'] == null
          ? null
          : PriceResponseModel.fromJson(json['price'] as Map<String, dynamic>),
      games: json['games'] == null
          ? null
          : GamesResponseModel.fromJson(json['games'] as Map<String, dynamic>),
      trainings: json['trainings'] == null
          ? null
          : TrainingsResponseModel.fromJson(
              json['trainings'] as Map<String, dynamic>),
      tryouts: json['tryouts'] == null
          ? null
          : TryoutsResponseModel.fromJson(
              json['tryouts'] as Map<String, dynamic>),
      tournaments: json['tournaments'] == null
          ? null
          : TournamentsResponseModel.fromJson(
              json['tournaments'] as Map<String, dynamic>),
      leagues: json['leagues'] == null
          ? null
          : LeaguesResponseModel.fromJson(
              json['leagues'] as Map<String, dynamic>),
      teams: json['teams'] == null
          ? null
          : TeamsResponseModel.fromJson(json['teams'] as Map<String, dynamic>),
      location: json['location'] == null
          ? null
          : LocationResponseModel.fromJson(
              json['location'] as Map<String, dynamic>),
      userParticipants: json['userParticipants'] == null
          ? null
          : UserParticipantsResponseModel.fromJson(
              json['userParticipants'] as Map<String, dynamic>),
      payments: json['payments'] == null
          ? null
          : PaymentsResponseModel.fromJson(
              json['payments'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$_EventResponseModelToJson(
        _$_EventResponseModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      '_id': instance.id,
      'type': instance.type,
      'isMainEvent': instance.isMainEvent,
      'mainImageKey': instance.mainImageKey,
      'archived': instance.archived,
      'deleted': instance.deleted,
      'startTime': instance.startTime,
      'endTime': instance.endTime,
      'capacity': instance.capacity,
      'createdAt': instance.createdAt,
      'requests': instance.requests,
      'images': instance.images,
      'chats': instance.chats,
      'SocialMediaApps': instance.socialMediaApps,
      'joinConditions': instance.joinConditions,
      'price': instance.price,
      'games': instance.games,
      'trainings': instance.trainings,
      'tryouts': instance.tryouts,
      'tournaments': instance.tournaments,
      'leagues': instance.leagues,
      'teams': instance.teams,
      'location': instance.location,
      'userParticipants': instance.userParticipants,
      'payments': instance.payments,
    };
