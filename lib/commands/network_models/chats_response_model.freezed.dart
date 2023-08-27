// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'chats_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

ChatsResponseModel _$ChatsResponseModelFromJson(Map<String, dynamic> json) {
  return _ChatsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ChatsResponseModel {
  @JsonKey(name: 'data')
  List<ChatsDataResponseModel>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatsResponseModelCopyWith<ChatsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatsResponseModelCopyWith<$Res> {
  factory $ChatsResponseModelCopyWith(
          ChatsResponseModel value, $Res Function(ChatsResponseModel) then) =
      _$ChatsResponseModelCopyWithImpl<$Res, ChatsResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<ChatsDataResponseModel>? data});
}

/// @nodoc
class _$ChatsResponseModelCopyWithImpl<$Res, $Val extends ChatsResponseModel>
    implements $ChatsResponseModelCopyWith<$Res> {
  _$ChatsResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_value.copyWith(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ChatsDataResponseModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_ChatsResponseModelCopyWith<$Res>
    implements $ChatsResponseModelCopyWith<$Res> {
  factory _$$_ChatsResponseModelCopyWith(_$_ChatsResponseModel value,
          $Res Function(_$_ChatsResponseModel) then) =
      __$$_ChatsResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<ChatsDataResponseModel>? data});
}

/// @nodoc
class __$$_ChatsResponseModelCopyWithImpl<$Res>
    extends _$ChatsResponseModelCopyWithImpl<$Res, _$_ChatsResponseModel>
    implements _$$_ChatsResponseModelCopyWith<$Res> {
  __$$_ChatsResponseModelCopyWithImpl(
      _$_ChatsResponseModel _value, $Res Function(_$_ChatsResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_ChatsResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<ChatsDataResponseModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatsResponseModel implements _ChatsResponseModel {
  const _$_ChatsResponseModel(
      {@JsonKey(name: 'data') final List<ChatsDataResponseModel>? data})
      : _data = data;

  factory _$_ChatsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChatsResponseModelFromJson(json);

  final List<ChatsDataResponseModel>? _data;
  @override
  @JsonKey(name: 'data')
  List<ChatsDataResponseModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'ChatsResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatsResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatsResponseModelCopyWith<_$_ChatsResponseModel> get copyWith =>
      __$$_ChatsResponseModelCopyWithImpl<_$_ChatsResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatsResponseModelToJson(
      this,
    );
  }
}

abstract class _ChatsResponseModel implements ChatsResponseModel {
  const factory _ChatsResponseModel(
          {@JsonKey(name: 'data') final List<ChatsDataResponseModel>? data}) =
      _$_ChatsResponseModel;

  factory _ChatsResponseModel.fromJson(Map<String, dynamic> json) =
      _$_ChatsResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<ChatsDataResponseModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_ChatsResponseModelCopyWith<_$_ChatsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

ChatsDataResponseModel _$ChatsDataResponseModelFromJson(
    Map<String, dynamic> json) {
  return _ChatsDataResponseModel.fromJson(json);
}

/// @nodoc
mixin _$ChatsDataResponseModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'name')
  String? get name => throw _privateConstructorUsedError;
  @JsonKey(name: 'isPrivate')
  bool? get isPrivate => throw _privateConstructorUsedError;
  @JsonKey(name: 'mainImageKey')
  String? get mainImageKey => throw _privateConstructorUsedError;
  @JsonKey(name: 'users')
  UsersResponseModel? get users => throw _privateConstructorUsedError;
  @JsonKey(name: 'event')
  EventSummaryDataResponseModel? get eventDataChats =>
      throw _privateConstructorUsedError;
  @JsonKey(name: 'team')
  String? get team => throw _privateConstructorUsedError;
  @JsonKey(name: 'messages')
  MessagesResponseModel? get messages => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $ChatsDataResponseModelCopyWith<ChatsDataResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ChatsDataResponseModelCopyWith<$Res> {
  factory $ChatsDataResponseModelCopyWith(ChatsDataResponseModel value,
          $Res Function(ChatsDataResponseModel) then) =
      _$ChatsDataResponseModelCopyWithImpl<$Res, ChatsDataResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'isPrivate') bool? isPrivate,
      @JsonKey(name: 'mainImageKey') String? mainImageKey,
      @JsonKey(name: 'users') UsersResponseModel? users,
      @JsonKey(name: 'event') EventSummaryDataResponseModel? eventDataChats,
      @JsonKey(name: 'team') String? team,
      @JsonKey(name: 'messages') MessagesResponseModel? messages});

  $UsersResponseModelCopyWith<$Res>? get users;
  $EventSummaryDataResponseModelCopyWith<$Res>? get eventDataChats;
  $MessagesResponseModelCopyWith<$Res>? get messages;
}

/// @nodoc
class _$ChatsDataResponseModelCopyWithImpl<$Res,
        $Val extends ChatsDataResponseModel>
    implements $ChatsDataResponseModelCopyWith<$Res> {
  _$ChatsDataResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? isPrivate = freezed,
    Object? mainImageKey = freezed,
    Object? users = freezed,
    Object? eventDataChats = freezed,
    Object? team = freezed,
    Object? messages = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: freezed == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool?,
      mainImageKey: freezed == mainImageKey
          ? _value.mainImageKey
          : mainImageKey // ignore: cast_nullable_to_non_nullable
              as String?,
      users: freezed == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as UsersResponseModel?,
      eventDataChats: freezed == eventDataChats
          ? _value.eventDataChats
          : eventDataChats // ignore: cast_nullable_to_non_nullable
              as EventSummaryDataResponseModel?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as MessagesResponseModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UsersResponseModelCopyWith<$Res>? get users {
    if (_value.users == null) {
      return null;
    }

    return $UsersResponseModelCopyWith<$Res>(_value.users!, (value) {
      return _then(_value.copyWith(users: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EventSummaryDataResponseModelCopyWith<$Res>? get eventDataChats {
    if (_value.eventDataChats == null) {
      return null;
    }

    return $EventSummaryDataResponseModelCopyWith<$Res>(_value.eventDataChats!,
        (value) {
      return _then(_value.copyWith(eventDataChats: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $MessagesResponseModelCopyWith<$Res>? get messages {
    if (_value.messages == null) {
      return null;
    }

    return $MessagesResponseModelCopyWith<$Res>(_value.messages!, (value) {
      return _then(_value.copyWith(messages: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_ChatsDataResponseModelCopyWith<$Res>
    implements $ChatsDataResponseModelCopyWith<$Res> {
  factory _$$_ChatsDataResponseModelCopyWith(_$_ChatsDataResponseModel value,
          $Res Function(_$_ChatsDataResponseModel) then) =
      __$$_ChatsDataResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'name') String? name,
      @JsonKey(name: 'isPrivate') bool? isPrivate,
      @JsonKey(name: 'mainImageKey') String? mainImageKey,
      @JsonKey(name: 'users') UsersResponseModel? users,
      @JsonKey(name: 'event') EventSummaryDataResponseModel? eventDataChats,
      @JsonKey(name: 'team') String? team,
      @JsonKey(name: 'messages') MessagesResponseModel? messages});

  @override
  $UsersResponseModelCopyWith<$Res>? get users;
  @override
  $EventSummaryDataResponseModelCopyWith<$Res>? get eventDataChats;
  @override
  $MessagesResponseModelCopyWith<$Res>? get messages;
}

/// @nodoc
class __$$_ChatsDataResponseModelCopyWithImpl<$Res>
    extends _$ChatsDataResponseModelCopyWithImpl<$Res,
        _$_ChatsDataResponseModel>
    implements _$$_ChatsDataResponseModelCopyWith<$Res> {
  __$$_ChatsDataResponseModelCopyWithImpl(_$_ChatsDataResponseModel _value,
      $Res Function(_$_ChatsDataResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? isPrivate = freezed,
    Object? mainImageKey = freezed,
    Object? users = freezed,
    Object? eventDataChats = freezed,
    Object? team = freezed,
    Object? messages = freezed,
  }) {
    return _then(_$_ChatsDataResponseModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: freezed == isPrivate
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool?,
      mainImageKey: freezed == mainImageKey
          ? _value.mainImageKey
          : mainImageKey // ignore: cast_nullable_to_non_nullable
              as String?,
      users: freezed == users
          ? _value.users
          : users // ignore: cast_nullable_to_non_nullable
              as UsersResponseModel?,
      eventDataChats: freezed == eventDataChats
          ? _value.eventDataChats
          : eventDataChats // ignore: cast_nullable_to_non_nullable
              as EventSummaryDataResponseModel?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as String?,
      messages: freezed == messages
          ? _value.messages
          : messages // ignore: cast_nullable_to_non_nullable
              as MessagesResponseModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_ChatsDataResponseModel implements _ChatsDataResponseModel {
  const _$_ChatsDataResponseModel(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'name') this.name,
      @JsonKey(name: 'isPrivate') this.isPrivate,
      @JsonKey(name: 'mainImageKey') this.mainImageKey,
      @JsonKey(name: 'users') this.users,
      @JsonKey(name: 'event') this.eventDataChats,
      @JsonKey(name: 'team') this.team,
      @JsonKey(name: 'messages') this.messages});

  factory _$_ChatsDataResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_ChatsDataResponseModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'name')
  final String? name;
  @override
  @JsonKey(name: 'isPrivate')
  final bool? isPrivate;
  @override
  @JsonKey(name: 'mainImageKey')
  final String? mainImageKey;
  @override
  @JsonKey(name: 'users')
  final UsersResponseModel? users;
  @override
  @JsonKey(name: 'event')
  final EventSummaryDataResponseModel? eventDataChats;
  @override
  @JsonKey(name: 'team')
  final String? team;
  @override
  @JsonKey(name: 'messages')
  final MessagesResponseModel? messages;

  @override
  String toString() {
    return 'ChatsDataResponseModel(id: $id, name: $name, isPrivate: $isPrivate, mainImageKey: $mainImageKey, users: $users, eventDataChats: $eventDataChats, team: $team, messages: $messages)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_ChatsDataResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.isPrivate, isPrivate) ||
                other.isPrivate == isPrivate) &&
            (identical(other.mainImageKey, mainImageKey) ||
                other.mainImageKey == mainImageKey) &&
            (identical(other.users, users) || other.users == users) &&
            (identical(other.eventDataChats, eventDataChats) ||
                other.eventDataChats == eventDataChats) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.messages, messages) ||
                other.messages == messages));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, isPrivate,
      mainImageKey, users, eventDataChats, team, messages);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_ChatsDataResponseModelCopyWith<_$_ChatsDataResponseModel> get copyWith =>
      __$$_ChatsDataResponseModelCopyWithImpl<_$_ChatsDataResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_ChatsDataResponseModelToJson(
      this,
    );
  }
}

abstract class _ChatsDataResponseModel implements ChatsDataResponseModel {
  const factory _ChatsDataResponseModel(
          {@JsonKey(name: '_id') final String? id,
          @JsonKey(name: 'name') final String? name,
          @JsonKey(name: 'isPrivate') final bool? isPrivate,
          @JsonKey(name: 'mainImageKey') final String? mainImageKey,
          @JsonKey(name: 'users') final UsersResponseModel? users,
          @JsonKey(name: 'event')
          final EventSummaryDataResponseModel? eventDataChats,
          @JsonKey(name: 'team') final String? team,
          @JsonKey(name: 'messages') final MessagesResponseModel? messages}) =
      _$_ChatsDataResponseModel;

  factory _ChatsDataResponseModel.fromJson(Map<String, dynamic> json) =
      _$_ChatsDataResponseModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'name')
  String? get name;
  @override
  @JsonKey(name: 'isPrivate')
  bool? get isPrivate;
  @override
  @JsonKey(name: 'mainImageKey')
  String? get mainImageKey;
  @override
  @JsonKey(name: 'users')
  UsersResponseModel? get users;
  @override
  @JsonKey(name: 'event')
  EventSummaryDataResponseModel? get eventDataChats;
  @override
  @JsonKey(name: 'team')
  String? get team;
  @override
  @JsonKey(name: 'messages')
  MessagesResponseModel? get messages;
  @override
  @JsonKey(ignore: true)
  _$$_ChatsDataResponseModelCopyWith<_$_ChatsDataResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
