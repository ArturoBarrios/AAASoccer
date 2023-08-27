// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_media_apps_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SocialMediaAppsResponseModel _$SocialMediaAppsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _SocialMediaAppsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$SocialMediaAppsResponseModel {
  @JsonKey(name: 'data')
  List<SocialMediaAppsDataResponseModel>? get data =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SocialMediaAppsResponseModelCopyWith<SocialMediaAppsResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialMediaAppsResponseModelCopyWith<$Res> {
  factory $SocialMediaAppsResponseModelCopyWith(
          SocialMediaAppsResponseModel value,
          $Res Function(SocialMediaAppsResponseModel) then) =
      _$SocialMediaAppsResponseModelCopyWithImpl<$Res,
          SocialMediaAppsResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<SocialMediaAppsDataResponseModel>? data});
}

/// @nodoc
class _$SocialMediaAppsResponseModelCopyWithImpl<$Res,
        $Val extends SocialMediaAppsResponseModel>
    implements $SocialMediaAppsResponseModelCopyWith<$Res> {
  _$SocialMediaAppsResponseModelCopyWithImpl(this._value, this._then);

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
              as List<SocialMediaAppsDataResponseModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_SocialMediaAppsResponseModelCopyWith<$Res>
    implements $SocialMediaAppsResponseModelCopyWith<$Res> {
  factory _$$_SocialMediaAppsResponseModelCopyWith(
          _$_SocialMediaAppsResponseModel value,
          $Res Function(_$_SocialMediaAppsResponseModel) then) =
      __$$_SocialMediaAppsResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<SocialMediaAppsDataResponseModel>? data});
}

/// @nodoc
class __$$_SocialMediaAppsResponseModelCopyWithImpl<$Res>
    extends _$SocialMediaAppsResponseModelCopyWithImpl<$Res,
        _$_SocialMediaAppsResponseModel>
    implements _$$_SocialMediaAppsResponseModelCopyWith<$Res> {
  __$$_SocialMediaAppsResponseModelCopyWithImpl(
      _$_SocialMediaAppsResponseModel _value,
      $Res Function(_$_SocialMediaAppsResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_SocialMediaAppsResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<SocialMediaAppsDataResponseModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SocialMediaAppsResponseModel implements _SocialMediaAppsResponseModel {
  const _$_SocialMediaAppsResponseModel(
      {@JsonKey(name: 'data')
      final List<SocialMediaAppsDataResponseModel>? data})
      : _data = data;

  factory _$_SocialMediaAppsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_SocialMediaAppsResponseModelFromJson(json);

  final List<SocialMediaAppsDataResponseModel>? _data;
  @override
  @JsonKey(name: 'data')
  List<SocialMediaAppsDataResponseModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'SocialMediaAppsResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SocialMediaAppsResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SocialMediaAppsResponseModelCopyWith<_$_SocialMediaAppsResponseModel>
      get copyWith => __$$_SocialMediaAppsResponseModelCopyWithImpl<
          _$_SocialMediaAppsResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SocialMediaAppsResponseModelToJson(
      this,
    );
  }
}

abstract class _SocialMediaAppsResponseModel
    implements SocialMediaAppsResponseModel {
  const factory _SocialMediaAppsResponseModel(
          {@JsonKey(name: 'data')
          final List<SocialMediaAppsDataResponseModel>? data}) =
      _$_SocialMediaAppsResponseModel;

  factory _SocialMediaAppsResponseModel.fromJson(Map<String, dynamic> json) =
      _$_SocialMediaAppsResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<SocialMediaAppsDataResponseModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_SocialMediaAppsResponseModelCopyWith<_$_SocialMediaAppsResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

SocialMediaAppsDataResponseModel _$SocialMediaAppsDataResponseModelFromJson(
    Map<String, dynamic> json) {
  return _SocialMediaAppsDataResponseModel.fromJson(json);
}

/// @nodoc
mixin _$SocialMediaAppsDataResponseModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'url')
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  UserMidInfoResponseModel? get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'team')
  String? get team => throw _privateConstructorUsedError;
  @JsonKey(name: 'event')
  EventSummaryDataResponseModel? get event =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SocialMediaAppsDataResponseModelCopyWith<SocialMediaAppsDataResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialMediaAppsDataResponseModelCopyWith<$Res> {
  factory $SocialMediaAppsDataResponseModelCopyWith(
          SocialMediaAppsDataResponseModel value,
          $Res Function(SocialMediaAppsDataResponseModel) then) =
      _$SocialMediaAppsDataResponseModelCopyWithImpl<$Res,
          SocialMediaAppsDataResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'url') String? url,
      @JsonKey(name: 'user') UserMidInfoResponseModel? user,
      @JsonKey(name: 'team') String? team,
      @JsonKey(name: 'event') EventSummaryDataResponseModel? event});

  $UserMidInfoResponseModelCopyWith<$Res>? get user;
  $EventSummaryDataResponseModelCopyWith<$Res>? get event;
}

/// @nodoc
class _$SocialMediaAppsDataResponseModelCopyWithImpl<$Res,
        $Val extends SocialMediaAppsDataResponseModel>
    implements $SocialMediaAppsDataResponseModelCopyWith<$Res> {
  _$SocialMediaAppsDataResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? url = freezed,
    Object? user = freezed,
    Object? team = freezed,
    Object? event = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserMidInfoResponseModel?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as EventSummaryDataResponseModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UserMidInfoResponseModelCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $UserMidInfoResponseModelCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $EventSummaryDataResponseModelCopyWith<$Res>? get event {
    if (_value.event == null) {
      return null;
    }

    return $EventSummaryDataResponseModelCopyWith<$Res>(_value.event!, (value) {
      return _then(_value.copyWith(event: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SocialMediaAppsDataResponseModelCopyWith<$Res>
    implements $SocialMediaAppsDataResponseModelCopyWith<$Res> {
  factory _$$_SocialMediaAppsDataResponseModelCopyWith(
          _$_SocialMediaAppsDataResponseModel value,
          $Res Function(_$_SocialMediaAppsDataResponseModel) then) =
      __$$_SocialMediaAppsDataResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'type') String? type,
      @JsonKey(name: 'url') String? url,
      @JsonKey(name: 'user') UserMidInfoResponseModel? user,
      @JsonKey(name: 'team') String? team,
      @JsonKey(name: 'event') EventSummaryDataResponseModel? event});

  @override
  $UserMidInfoResponseModelCopyWith<$Res>? get user;
  @override
  $EventSummaryDataResponseModelCopyWith<$Res>? get event;
}

/// @nodoc
class __$$_SocialMediaAppsDataResponseModelCopyWithImpl<$Res>
    extends _$SocialMediaAppsDataResponseModelCopyWithImpl<$Res,
        _$_SocialMediaAppsDataResponseModel>
    implements _$$_SocialMediaAppsDataResponseModelCopyWith<$Res> {
  __$$_SocialMediaAppsDataResponseModelCopyWithImpl(
      _$_SocialMediaAppsDataResponseModel _value,
      $Res Function(_$_SocialMediaAppsDataResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? type = freezed,
    Object? url = freezed,
    Object? user = freezed,
    Object? team = freezed,
    Object? event = freezed,
  }) {
    return _then(_$_SocialMediaAppsDataResponseModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as UserMidInfoResponseModel?,
      team: freezed == team
          ? _value.team
          : team // ignore: cast_nullable_to_non_nullable
              as String?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as EventSummaryDataResponseModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SocialMediaAppsDataResponseModel
    implements _SocialMediaAppsDataResponseModel {
  const _$_SocialMediaAppsDataResponseModel(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'type') this.type,
      @JsonKey(name: 'url') this.url,
      @JsonKey(name: 'user') this.user,
      @JsonKey(name: 'team') this.team,
      @JsonKey(name: 'event') this.event});

  factory _$_SocialMediaAppsDataResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_SocialMediaAppsDataResponseModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'url')
  final String? url;
  @override
  @JsonKey(name: 'user')
  final UserMidInfoResponseModel? user;
  @override
  @JsonKey(name: 'team')
  final String? team;
  @override
  @JsonKey(name: 'event')
  final EventSummaryDataResponseModel? event;

  @override
  String toString() {
    return 'SocialMediaAppsDataResponseModel(id: $id, type: $type, url: $url, user: $user, team: $team, event: $event)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SocialMediaAppsDataResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.team, team) || other.team == team) &&
            (identical(other.event, event) || other.event == event));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, type, url, user, team, event);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SocialMediaAppsDataResponseModelCopyWith<
          _$_SocialMediaAppsDataResponseModel>
      get copyWith => __$$_SocialMediaAppsDataResponseModelCopyWithImpl<
          _$_SocialMediaAppsDataResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SocialMediaAppsDataResponseModelToJson(
      this,
    );
  }
}

abstract class _SocialMediaAppsDataResponseModel
    implements SocialMediaAppsDataResponseModel {
  const factory _SocialMediaAppsDataResponseModel(
          {@JsonKey(name: '_id') final String? id,
          @JsonKey(name: 'type') final String? type,
          @JsonKey(name: 'url') final String? url,
          @JsonKey(name: 'user') final UserMidInfoResponseModel? user,
          @JsonKey(name: 'team') final String? team,
          @JsonKey(name: 'event') final EventSummaryDataResponseModel? event}) =
      _$_SocialMediaAppsDataResponseModel;

  factory _SocialMediaAppsDataResponseModel.fromJson(
      Map<String, dynamic> json) = _$_SocialMediaAppsDataResponseModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'url')
  String? get url;
  @override
  @JsonKey(name: 'user')
  UserMidInfoResponseModel? get user;
  @override
  @JsonKey(name: 'team')
  String? get team;
  @override
  @JsonKey(name: 'event')
  EventSummaryDataResponseModel? get event;
  @override
  @JsonKey(ignore: true)
  _$$_SocialMediaAppsDataResponseModelCopyWith<
          _$_SocialMediaAppsDataResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
