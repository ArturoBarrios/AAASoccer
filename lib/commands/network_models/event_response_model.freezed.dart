// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'event_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

EventResponseModel _$EventResponseModelFromJson(Map<String, dynamic> json) {
  return _EventResponseModel.fromJson(json);
}

/// @nodoc
mixin _$EventResponseModel {
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'isMainEvent')
  bool? get isMainEvent => throw _privateConstructorUsedError;
  @JsonKey(name: 'mainImageKey')
  String? get mainImageKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'archived')
  bool? get archived => throw _privateConstructorUsedError;
  @JsonKey(name: 'deleted')
  String? get deleted => throw _privateConstructorUsedError;
  @JsonKey(name: 'startTime')
  String? get startTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'endTime')
  String? get endTime => throw _privateConstructorUsedError;
  @JsonKey(name: 'capacity')
  int? get capacity => throw _privateConstructorUsedError;
  @JsonKey(name: 'createdAt')
  String? get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'requests')
  RequestsResponseModel? get requests => throw _privateConstructorUsedError;
  @JsonKey(name: 'images')
  ImagesResponseModel? get images => throw _privateConstructorUsedError;
  @JsonKey(name: 'chats')
  ChatsResponseModel? get chats => throw _privateConstructorUsedError;
  @JsonKey(name: 'SocialMediaApps')
  SocialMediaAppsResponseModel? get socialMediaApps =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'joinConditions')
  JoinConditionsResponseModel? get joinConditions =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'price')
  PriceResponseModel? get price => throw _privateConstructorUsedError;
  @JsonKey(name: 'games')
  GamesResponseModel? get games => throw _privateConstructorUsedError;
  @JsonKey(name: 'trainings')
  TrainingsResponseModel? get trainings => throw _privateConstructorUsedError;
  @JsonKey(name: 'tryouts')
  TryoutsResponseModel? get tryouts => throw _privateConstructorUsedError;
  @JsonKey(name: 'tournaments')
  TournamentsResponseModel? get tournaments =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'leagues')
  LeaguesResponseModel? get leagues => throw _privateConstructorUsedError;
  @JsonKey(name: 'teams')
  TeamsResponseModel? get teams => throw _privateConstructorUsedError;
  @JsonKey(name: 'location')
  LocationResponseModel? get location => throw _privateConstructorUsedError;
  @JsonKey(name: 'userParticipants')
  UserParticipantsResponseModel? get userParticipants =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'payments')
  PaymentsResponseModel? get payments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $EventResponseModelCopyWith<EventResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $EventResponseModelCopyWith<$Res> {
  factory $EventResponseModelCopyWith(
          EventResponseModel value, $Res Function(EventResponseModel) then) =
      _$EventResponseModelCopyWithImpl<$Res, EventResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
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
      @JsonKey(name: 'payments') PaymentsResponseModel? payments});

  $RequestsResponseModelCopyWith<$Res>? get requests;
  $ImagesResponseModelCopyWith<$Res>? get images;
  $ChatsResponseModelCopyWith<$Res>? get chats;
  $SocialMediaAppsResponseModelCopyWith<$Res>? get socialMediaApps;
  $JoinConditionsResponseModelCopyWith<$Res>? get joinConditions;
  $PriceResponseModelCopyWith<$Res>? get price;
  $GamesResponseModelCopyWith<$Res>? get games;
  $TrainingsResponseModelCopyWith<$Res>? get trainings;
  $TryoutsResponseModelCopyWith<$Res>? get tryouts;
  $TournamentsResponseModelCopyWith<$Res>? get tournaments;
  $LeaguesResponseModelCopyWith<$Res>? get leagues;
  $TeamsResponseModelCopyWith<$Res>? get teams;
  $LocationResponseModelCopyWith<$Res>? get location;
  $UserParticipantsResponseModelCopyWith<$Res>? get userParticipants;
  $PaymentsResponseModelCopyWith<$Res>? get payments;
}

/// @nodoc
class _$EventResponseModelCopyWithImpl<$Res, $Val extends EventResponseModel>
    implements $EventResponseModelCopyWith<$Res> {
  _$EventResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? type = freezed,
    Object? isMainEvent = freezed,
    Object? mainImageKey = freezed,
    Object? archived = freezed,
    Object? deleted = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? capacity = freezed,
    Object? createdAt = freezed,
    Object? requests = freezed,
    Object? images = freezed,
    Object? chats = freezed,
    Object? socialMediaApps = freezed,
    Object? joinConditions = freezed,
    Object? price = freezed,
    Object? games = freezed,
    Object? trainings = freezed,
    Object? tryouts = freezed,
    Object? tournaments = freezed,
    Object? leagues = freezed,
    Object? teams = freezed,
    Object? location = freezed,
    Object? userParticipants = freezed,
    Object? payments = freezed,
  }) {
    return _then(_value.copyWith(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      isMainEvent: freezed == isMainEvent
          ? _value.isMainEvent
          : isMainEvent // ignore: cast_nullable_to_non_nullable
              as bool?,
      mainImageKey: freezed == mainImageKey
          ? _value.mainImageKey
          : mainImageKey // ignore: cast_nullable_to_non_nullable
              as String?,
      archived: freezed == archived
          ? _value.archived
          : archived // ignore: cast_nullable_to_non_nullable
              as bool?,
      deleted: freezed == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      capacity: freezed == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      requests: freezed == requests
          ? _value.requests
          : requests // ignore: cast_nullable_to_non_nullable
              as RequestsResponseModel?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as ImagesResponseModel?,
      chats: freezed == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as ChatsResponseModel?,
      socialMediaApps: freezed == socialMediaApps
          ? _value.socialMediaApps
          : socialMediaApps // ignore: cast_nullable_to_non_nullable
              as SocialMediaAppsResponseModel?,
      joinConditions: freezed == joinConditions
          ? _value.joinConditions
          : joinConditions // ignore: cast_nullable_to_non_nullable
              as JoinConditionsResponseModel?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceResponseModel?,
      games: freezed == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as GamesResponseModel?,
      trainings: freezed == trainings
          ? _value.trainings
          : trainings // ignore: cast_nullable_to_non_nullable
              as TrainingsResponseModel?,
      tryouts: freezed == tryouts
          ? _value.tryouts
          : tryouts // ignore: cast_nullable_to_non_nullable
              as TryoutsResponseModel?,
      tournaments: freezed == tournaments
          ? _value.tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as TournamentsResponseModel?,
      leagues: freezed == leagues
          ? _value.leagues
          : leagues // ignore: cast_nullable_to_non_nullable
              as LeaguesResponseModel?,
      teams: freezed == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as TeamsResponseModel?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationResponseModel?,
      userParticipants: freezed == userParticipants
          ? _value.userParticipants
          : userParticipants // ignore: cast_nullable_to_non_nullable
              as UserParticipantsResponseModel?,
      payments: freezed == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as PaymentsResponseModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $RequestsResponseModelCopyWith<$Res>? get requests {
    if (_value.requests == null) {
      return null;
    }

    return $RequestsResponseModelCopyWith<$Res>(_value.requests!, (value) {
      return _then(_value.copyWith(requests: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ImagesResponseModelCopyWith<$Res>? get images {
    if (_value.images == null) {
      return null;
    }

    return $ImagesResponseModelCopyWith<$Res>(_value.images!, (value) {
      return _then(_value.copyWith(images: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ChatsResponseModelCopyWith<$Res>? get chats {
    if (_value.chats == null) {
      return null;
    }

    return $ChatsResponseModelCopyWith<$Res>(_value.chats!, (value) {
      return _then(_value.copyWith(chats: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $SocialMediaAppsResponseModelCopyWith<$Res>? get socialMediaApps {
    if (_value.socialMediaApps == null) {
      return null;
    }

    return $SocialMediaAppsResponseModelCopyWith<$Res>(_value.socialMediaApps!,
        (value) {
      return _then(_value.copyWith(socialMediaApps: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $JoinConditionsResponseModelCopyWith<$Res>? get joinConditions {
    if (_value.joinConditions == null) {
      return null;
    }

    return $JoinConditionsResponseModelCopyWith<$Res>(_value.joinConditions!,
        (value) {
      return _then(_value.copyWith(joinConditions: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PriceResponseModelCopyWith<$Res>? get price {
    if (_value.price == null) {
      return null;
    }

    return $PriceResponseModelCopyWith<$Res>(_value.price!, (value) {
      return _then(_value.copyWith(price: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $GamesResponseModelCopyWith<$Res>? get games {
    if (_value.games == null) {
      return null;
    }

    return $GamesResponseModelCopyWith<$Res>(_value.games!, (value) {
      return _then(_value.copyWith(games: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TrainingsResponseModelCopyWith<$Res>? get trainings {
    if (_value.trainings == null) {
      return null;
    }

    return $TrainingsResponseModelCopyWith<$Res>(_value.trainings!, (value) {
      return _then(_value.copyWith(trainings: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TryoutsResponseModelCopyWith<$Res>? get tryouts {
    if (_value.tryouts == null) {
      return null;
    }

    return $TryoutsResponseModelCopyWith<$Res>(_value.tryouts!, (value) {
      return _then(_value.copyWith(tryouts: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TournamentsResponseModelCopyWith<$Res>? get tournaments {
    if (_value.tournaments == null) {
      return null;
    }

    return $TournamentsResponseModelCopyWith<$Res>(_value.tournaments!,
        (value) {
      return _then(_value.copyWith(tournaments: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LeaguesResponseModelCopyWith<$Res>? get leagues {
    if (_value.leagues == null) {
      return null;
    }

    return $LeaguesResponseModelCopyWith<$Res>(_value.leagues!, (value) {
      return _then(_value.copyWith(leagues: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $TeamsResponseModelCopyWith<$Res>? get teams {
    if (_value.teams == null) {
      return null;
    }

    return $TeamsResponseModelCopyWith<$Res>(_value.teams!, (value) {
      return _then(_value.copyWith(teams: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $LocationResponseModelCopyWith<$Res>? get location {
    if (_value.location == null) {
      return null;
    }

    return $LocationResponseModelCopyWith<$Res>(_value.location!, (value) {
      return _then(_value.copyWith(location: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $UserParticipantsResponseModelCopyWith<$Res>? get userParticipants {
    if (_value.userParticipants == null) {
      return null;
    }

    return $UserParticipantsResponseModelCopyWith<$Res>(
        _value.userParticipants!, (value) {
      return _then(_value.copyWith(userParticipants: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $PaymentsResponseModelCopyWith<$Res>? get payments {
    if (_value.payments == null) {
      return null;
    }

    return $PaymentsResponseModelCopyWith<$Res>(_value.payments!, (value) {
      return _then(_value.copyWith(payments: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_EventResponseModelCopyWith<$Res>
    implements $EventResponseModelCopyWith<$Res> {
  factory _$$_EventResponseModelCopyWith(_$_EventResponseModel value,
          $Res Function(_$_EventResponseModel) then) =
      __$$_EventResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'name') String? name,
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
      @JsonKey(name: 'payments') PaymentsResponseModel? payments});

  @override
  $RequestsResponseModelCopyWith<$Res>? get requests;
  @override
  $ImagesResponseModelCopyWith<$Res>? get images;
  @override
  $ChatsResponseModelCopyWith<$Res>? get chats;
  @override
  $SocialMediaAppsResponseModelCopyWith<$Res>? get socialMediaApps;
  @override
  $JoinConditionsResponseModelCopyWith<$Res>? get joinConditions;
  @override
  $PriceResponseModelCopyWith<$Res>? get price;
  @override
  $GamesResponseModelCopyWith<$Res>? get games;
  @override
  $TrainingsResponseModelCopyWith<$Res>? get trainings;
  @override
  $TryoutsResponseModelCopyWith<$Res>? get tryouts;
  @override
  $TournamentsResponseModelCopyWith<$Res>? get tournaments;
  @override
  $LeaguesResponseModelCopyWith<$Res>? get leagues;
  @override
  $TeamsResponseModelCopyWith<$Res>? get teams;
  @override
  $LocationResponseModelCopyWith<$Res>? get location;
  @override
  $UserParticipantsResponseModelCopyWith<$Res>? get userParticipants;
  @override
  $PaymentsResponseModelCopyWith<$Res>? get payments;
}

/// @nodoc
class __$$_EventResponseModelCopyWithImpl<$Res>
    extends _$EventResponseModelCopyWithImpl<$Res, _$_EventResponseModel>
    implements _$$_EventResponseModelCopyWith<$Res> {
  __$$_EventResponseModelCopyWithImpl(
      _$_EventResponseModel _value, $Res Function(_$_EventResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? name = freezed,
    Object? id = freezed,
    Object? type = freezed,
    Object? isMainEvent = freezed,
    Object? mainImageKey = freezed,
    Object? archived = freezed,
    Object? deleted = freezed,
    Object? startTime = freezed,
    Object? endTime = freezed,
    Object? capacity = freezed,
    Object? createdAt = freezed,
    Object? requests = freezed,
    Object? images = freezed,
    Object? chats = freezed,
    Object? socialMediaApps = freezed,
    Object? joinConditions = freezed,
    Object? price = freezed,
    Object? games = freezed,
    Object? trainings = freezed,
    Object? tryouts = freezed,
    Object? tournaments = freezed,
    Object? leagues = freezed,
    Object? teams = freezed,
    Object? location = freezed,
    Object? userParticipants = freezed,
    Object? payments = freezed,
  }) {
    return _then(_$_EventResponseModel(
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      isMainEvent: freezed == isMainEvent
          ? _value.isMainEvent
          : isMainEvent // ignore: cast_nullable_to_non_nullable
              as bool?,
      mainImageKey: freezed == mainImageKey
          ? _value.mainImageKey
          : mainImageKey // ignore: cast_nullable_to_non_nullable
              as String?,
      archived: freezed == archived
          ? _value.archived
          : archived // ignore: cast_nullable_to_non_nullable
              as bool?,
      deleted: freezed == deleted
          ? _value.deleted
          : deleted // ignore: cast_nullable_to_non_nullable
              as String?,
      startTime: freezed == startTime
          ? _value.startTime
          : startTime // ignore: cast_nullable_to_non_nullable
              as String?,
      endTime: freezed == endTime
          ? _value.endTime
          : endTime // ignore: cast_nullable_to_non_nullable
              as String?,
      capacity: freezed == capacity
          ? _value.capacity
          : capacity // ignore: cast_nullable_to_non_nullable
              as int?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      requests: freezed == requests
          ? _value.requests
          : requests // ignore: cast_nullable_to_non_nullable
              as RequestsResponseModel?,
      images: freezed == images
          ? _value.images
          : images // ignore: cast_nullable_to_non_nullable
              as ImagesResponseModel?,
      chats: freezed == chats
          ? _value.chats
          : chats // ignore: cast_nullable_to_non_nullable
              as ChatsResponseModel?,
      socialMediaApps: freezed == socialMediaApps
          ? _value.socialMediaApps
          : socialMediaApps // ignore: cast_nullable_to_non_nullable
              as SocialMediaAppsResponseModel?,
      joinConditions: freezed == joinConditions
          ? _value.joinConditions
          : joinConditions // ignore: cast_nullable_to_non_nullable
              as JoinConditionsResponseModel?,
      price: freezed == price
          ? _value.price
          : price // ignore: cast_nullable_to_non_nullable
              as PriceResponseModel?,
      games: freezed == games
          ? _value.games
          : games // ignore: cast_nullable_to_non_nullable
              as GamesResponseModel?,
      trainings: freezed == trainings
          ? _value.trainings
          : trainings // ignore: cast_nullable_to_non_nullable
              as TrainingsResponseModel?,
      tryouts: freezed == tryouts
          ? _value.tryouts
          : tryouts // ignore: cast_nullable_to_non_nullable
              as TryoutsResponseModel?,
      tournaments: freezed == tournaments
          ? _value.tournaments
          : tournaments // ignore: cast_nullable_to_non_nullable
              as TournamentsResponseModel?,
      leagues: freezed == leagues
          ? _value.leagues
          : leagues // ignore: cast_nullable_to_non_nullable
              as LeaguesResponseModel?,
      teams: freezed == teams
          ? _value.teams
          : teams // ignore: cast_nullable_to_non_nullable
              as TeamsResponseModel?,
      location: freezed == location
          ? _value.location
          : location // ignore: cast_nullable_to_non_nullable
              as LocationResponseModel?,
      userParticipants: freezed == userParticipants
          ? _value.userParticipants
          : userParticipants // ignore: cast_nullable_to_non_nullable
              as UserParticipantsResponseModel?,
      payments: freezed == payments
          ? _value.payments
          : payments // ignore: cast_nullable_to_non_nullable
              as PaymentsResponseModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_EventResponseModel implements _EventResponseModel {
  const _$_EventResponseModel(
      {@JsonKey(name: 'name') this.name,
      @JsonKey(name: '_id') this.id,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'isMainEvent') this.isMainEvent,
      @JsonKey(name: 'mainImageKey') this.mainImageKey,
      @JsonKey(name: 'archived') this.archived,
      @JsonKey(name: 'deleted') this.deleted,
      @JsonKey(name: 'startTime') this.startTime,
      @JsonKey(name: 'endTime') this.endTime,
      @JsonKey(name: 'capacity') this.capacity,
      @JsonKey(name: 'createdAt') this.createdAt,
      @JsonKey(name: 'requests') this.requests,
      @JsonKey(name: 'images') this.images,
      @JsonKey(name: 'chats') this.chats,
      @JsonKey(name: 'SocialMediaApps') this.socialMediaApps,
      @JsonKey(name: 'joinConditions') this.joinConditions,
      @JsonKey(name: 'price') this.price,
      @JsonKey(name: 'games') this.games,
      @JsonKey(name: 'trainings') this.trainings,
      @JsonKey(name: 'tryouts') this.tryouts,
      @JsonKey(name: 'tournaments') this.tournaments,
      @JsonKey(name: 'leagues') this.leagues,
      @JsonKey(name: 'teams') this.teams,
      @JsonKey(name: 'location') this.location,
      @JsonKey(name: 'userParticipants') this.userParticipants,
      @JsonKey(name: 'payments') this.payments});

  factory _$_EventResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_EventResponseModelFromJson(json);

  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'isMainEvent')
  final bool? isMainEvent;
  @override
  @JsonKey(name: 'mainImageKey')
  final String? mainImageKey;
  @override
  @JsonKey(name: 'archived')
  final bool? archived;
  @override
  @JsonKey(name: 'deleted')
  final String? deleted;
  @override
  @JsonKey(name: 'startTime')
  final String? startTime;
  @override
  @JsonKey(name: 'endTime')
  final String? endTime;
  @override
  @JsonKey(name: 'capacity')
  final int? capacity;
  @override
  @JsonKey(name: 'createdAt')
  final String? createdAt;
  @override
  @JsonKey(name: 'requests')
  final RequestsResponseModel? requests;
  @override
  @JsonKey(name: 'images')
  final ImagesResponseModel? images;
  @override
  @JsonKey(name: 'chats')
  final ChatsResponseModel? chats;
  @override
  @JsonKey(name: 'SocialMediaApps')
  final SocialMediaAppsResponseModel? socialMediaApps;
  @override
  @JsonKey(name: 'joinConditions')
  final JoinConditionsResponseModel? joinConditions;
  @override
  @JsonKey(name: 'price')
  final PriceResponseModel? price;
  @override
  @JsonKey(name: 'games')
  final GamesResponseModel? games;
  @override
  @JsonKey(name: 'trainings')
  final TrainingsResponseModel? trainings;
  @override
  @JsonKey(name: 'tryouts')
  final TryoutsResponseModel? tryouts;
  @override
  @JsonKey(name: 'tournaments')
  final TournamentsResponseModel? tournaments;
  @override
  @JsonKey(name: 'leagues')
  final LeaguesResponseModel? leagues;
  @override
  @JsonKey(name: 'teams')
  final TeamsResponseModel? teams;
  @override
  @JsonKey(name: 'location')
  final LocationResponseModel? location;
  @override
  @JsonKey(name: 'userParticipants')
  final UserParticipantsResponseModel? userParticipants;
  @override
  @JsonKey(name: 'payments')
  final PaymentsResponseModel? payments;

  @override
  String toString() {
    return 'EventResponseModel(name: $name, id: $id, type: $type, isMainEvent: $isMainEvent, mainImageKey: $mainImageKey, archived: $archived, deleted: $deleted, startTime: $startTime, endTime: $endTime, capacity: $capacity, createdAt: $createdAt, requests: $requests, images: $images, chats: $chats, socialMediaApps: $socialMediaApps, joinConditions: $joinConditions, price: $price, games: $games, trainings: $trainings, tryouts: $tryouts, tournaments: $tournaments, leagues: $leagues, teams: $teams, location: $location, userParticipants: $userParticipants, payments: $payments)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_EventResponseModel &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.isMainEvent, isMainEvent) ||
                other.isMainEvent == isMainEvent) &&
            (identical(other.mainImageKey, mainImageKey) ||
                other.mainImageKey == mainImageKey) &&
            (identical(other.archived, archived) ||
                other.archived == archived) &&
            (identical(other.deleted, deleted) || other.deleted == deleted) &&
            (identical(other.startTime, startTime) ||
                other.startTime == startTime) &&
            (identical(other.endTime, endTime) || other.endTime == endTime) &&
            (identical(other.capacity, capacity) ||
                other.capacity == capacity) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.requests, requests) ||
                other.requests == requests) &&
            (identical(other.images, images) || other.images == images) &&
            (identical(other.chats, chats) || other.chats == chats) &&
            (identical(other.socialMediaApps, socialMediaApps) ||
                other.socialMediaApps == socialMediaApps) &&
            (identical(other.joinConditions, joinConditions) ||
                other.joinConditions == joinConditions) &&
            (identical(other.price, price) || other.price == price) &&
            (identical(other.games, games) || other.games == games) &&
            (identical(other.trainings, trainings) ||
                other.trainings == trainings) &&
            (identical(other.tryouts, tryouts) || other.tryouts == tryouts) &&
            (identical(other.tournaments, tournaments) ||
                other.tournaments == tournaments) &&
            (identical(other.leagues, leagues) || other.leagues == leagues) &&
            (identical(other.teams, teams) || other.teams == teams) &&
            (identical(other.location, location) ||
                other.location == location) &&
            (identical(other.userParticipants, userParticipants) ||
                other.userParticipants == userParticipants) &&
            (identical(other.payments, payments) ||
                other.payments == payments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        name,
        id,
        type,
        isMainEvent,
        mainImageKey,
        archived,
        deleted,
        startTime,
        endTime,
        capacity,
        createdAt,
        requests,
        images,
        chats,
        socialMediaApps,
        joinConditions,
        price,
        games,
        trainings,
        tryouts,
        tournaments,
        leagues,
        teams,
        location,
        userParticipants,
        payments
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_EventResponseModelCopyWith<_$_EventResponseModel> get copyWith =>
      __$$_EventResponseModelCopyWithImpl<_$_EventResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_EventResponseModelToJson(
      this,
    );
  }
}

abstract class _EventResponseModel implements EventResponseModel {
  const factory _EventResponseModel(
      {@JsonKey(name: 'name') final String? name,
      @JsonKey(name: '_id') final String? id,
      @JsonKey(name: 'type') final String? type,
      @JsonKey(name: 'isMainEvent') final bool? isMainEvent,
      @JsonKey(name: 'mainImageKey') final String? mainImageKey,
      @JsonKey(name: 'archived') final bool? archived,
      @JsonKey(name: 'deleted') final String? deleted,
      @JsonKey(name: 'startTime') final String? startTime,
      @JsonKey(name: 'endTime') final String? endTime,
      @JsonKey(name: 'capacity') final int? capacity,
      @JsonKey(name: 'createdAt') final String? createdAt,
      @JsonKey(name: 'requests') final RequestsResponseModel? requests,
      @JsonKey(name: 'images') final ImagesResponseModel? images,
      @JsonKey(name: 'chats') final ChatsResponseModel? chats,
      @JsonKey(name: 'SocialMediaApps')
      final SocialMediaAppsResponseModel? socialMediaApps,
      @JsonKey(name: 'joinConditions')
      final JoinConditionsResponseModel? joinConditions,
      @JsonKey(name: 'price') final PriceResponseModel? price,
      @JsonKey(name: 'games') final GamesResponseModel? games,
      @JsonKey(name: 'trainings') final TrainingsResponseModel? trainings,
      @JsonKey(name: 'tryouts') final TryoutsResponseModel? tryouts,
      @JsonKey(name: 'tournaments') final TournamentsResponseModel? tournaments,
      @JsonKey(name: 'leagues') final LeaguesResponseModel? leagues,
      @JsonKey(name: 'teams') final TeamsResponseModel? teams,
      @JsonKey(name: 'location') final LocationResponseModel? location,
      @JsonKey(name: 'userParticipants')
      final UserParticipantsResponseModel? userParticipants,
      @JsonKey(name: 'payments')
      final PaymentsResponseModel? payments}) = _$_EventResponseModel;

  factory _EventResponseModel.fromJson(Map<String, dynamic> json) =
      _$_EventResponseModel.fromJson;

  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'isMainEvent')
  bool? get isMainEvent;
  @override
  @JsonKey(name: 'mainImageKey')
  String? get mainImageKey;
  @override
  @JsonKey(name: 'archived')
  bool? get archived;
  @override
  @JsonKey(name: 'deleted')
  String? get deleted;
  @override
  @JsonKey(name: 'startTime')
  String? get startTime;
  @override
  @JsonKey(name: 'endTime')
  String? get endTime;
  @override
  @JsonKey(name: 'capacity')
  int? get capacity;
  @override
  @JsonKey(name: 'createdAt')
  String? get createdAt;
  @override
  @JsonKey(name: 'requests')
  RequestsResponseModel? get requests;
  @override
  @JsonKey(name: 'images')
  ImagesResponseModel? get images;
  @override
  @JsonKey(name: 'chats')
  ChatsResponseModel? get chats;
  @override
  @JsonKey(name: 'SocialMediaApps')
  SocialMediaAppsResponseModel? get socialMediaApps;
  @override
  @JsonKey(name: 'joinConditions')
  JoinConditionsResponseModel? get joinConditions;
  @override
  @JsonKey(name: 'price')
  PriceResponseModel? get price;
  @override
  @JsonKey(name: 'games')
  GamesResponseModel? get games;
  @override
  @JsonKey(name: 'trainings')
  TrainingsResponseModel? get trainings;
  @override
  @JsonKey(name: 'tryouts')
  TryoutsResponseModel? get tryouts;
  @override
  @JsonKey(name: 'tournaments')
  TournamentsResponseModel? get tournaments;
  @override
  @JsonKey(name: 'leagues')
  LeaguesResponseModel? get leagues;
  @override
  @JsonKey(name: 'teams')
  TeamsResponseModel? get teams;
  @override
  @JsonKey(name: 'location')
  LocationResponseModel? get location;
  @override
  @JsonKey(name: 'userParticipants')
  UserParticipantsResponseModel? get userParticipants;
  @override
  @JsonKey(name: 'payments')
  PaymentsResponseModel? get payments;
  @override
  @JsonKey(ignore: true)
  _$$_EventResponseModelCopyWith<_$_EventResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
