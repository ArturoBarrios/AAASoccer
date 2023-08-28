// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_social_media_apps_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AddSocialMediaAppsRequest {
  String? get eventId => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String? get socialMediaType => throw _privateConstructorUsedError;
  String? get socialMediaUrl => throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $AddSocialMediaAppsRequestCopyWith<AddSocialMediaAppsRequest> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddSocialMediaAppsRequestCopyWith<$Res> {
  factory $AddSocialMediaAppsRequestCopyWith(AddSocialMediaAppsRequest value,
          $Res Function(AddSocialMediaAppsRequest) then) =
      _$AddSocialMediaAppsRequestCopyWithImpl<$Res, AddSocialMediaAppsRequest>;
  @useResult
  $Res call(
      {String? eventId,
      String? userId,
      String? socialMediaType,
      String? socialMediaUrl});
}

/// @nodoc
class _$AddSocialMediaAppsRequestCopyWithImpl<$Res,
        $Val extends AddSocialMediaAppsRequest>
    implements $AddSocialMediaAppsRequestCopyWith<$Res> {
  _$AddSocialMediaAppsRequestCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = freezed,
    Object? userId = freezed,
    Object? socialMediaType = freezed,
    Object? socialMediaUrl = freezed,
  }) {
    return _then(_value.copyWith(
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      socialMediaType: freezed == socialMediaType
          ? _value.socialMediaType
          : socialMediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      socialMediaUrl: freezed == socialMediaUrl
          ? _value.socialMediaUrl
          : socialMediaUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_AddSocialMediaAppsRequestCopyWith<$Res>
    implements $AddSocialMediaAppsRequestCopyWith<$Res> {
  factory _$$_AddSocialMediaAppsRequestCopyWith(
          _$_AddSocialMediaAppsRequest value,
          $Res Function(_$_AddSocialMediaAppsRequest) then) =
      __$$_AddSocialMediaAppsRequestCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String? eventId,
      String? userId,
      String? socialMediaType,
      String? socialMediaUrl});
}

/// @nodoc
class __$$_AddSocialMediaAppsRequestCopyWithImpl<$Res>
    extends _$AddSocialMediaAppsRequestCopyWithImpl<$Res,
        _$_AddSocialMediaAppsRequest>
    implements _$$_AddSocialMediaAppsRequestCopyWith<$Res> {
  __$$_AddSocialMediaAppsRequestCopyWithImpl(
      _$_AddSocialMediaAppsRequest _value,
      $Res Function(_$_AddSocialMediaAppsRequest) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? eventId = freezed,
    Object? userId = freezed,
    Object? socialMediaType = freezed,
    Object? socialMediaUrl = freezed,
  }) {
    return _then(_$_AddSocialMediaAppsRequest(
      eventId: freezed == eventId
          ? _value.eventId
          : eventId // ignore: cast_nullable_to_non_nullable
              as String?,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      socialMediaType: freezed == socialMediaType
          ? _value.socialMediaType
          : socialMediaType // ignore: cast_nullable_to_non_nullable
              as String?,
      socialMediaUrl: freezed == socialMediaUrl
          ? _value.socialMediaUrl
          : socialMediaUrl // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc

class _$_AddSocialMediaAppsRequest implements _AddSocialMediaAppsRequest {
  const _$_AddSocialMediaAppsRequest(
      {this.eventId, this.userId, this.socialMediaType, this.socialMediaUrl});

  @override
  final String? eventId;
  @override
  final String? userId;
  @override
  final String? socialMediaType;
  @override
  final String? socialMediaUrl;

  @override
  String toString() {
    return 'AddSocialMediaAppsRequest(eventId: $eventId, userId: $userId, socialMediaType: $socialMediaType, socialMediaUrl: $socialMediaUrl)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddSocialMediaAppsRequest &&
            (identical(other.eventId, eventId) || other.eventId == eventId) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.socialMediaType, socialMediaType) ||
                other.socialMediaType == socialMediaType) &&
            (identical(other.socialMediaUrl, socialMediaUrl) ||
                other.socialMediaUrl == socialMediaUrl));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType, eventId, userId, socialMediaType, socialMediaUrl);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddSocialMediaAppsRequestCopyWith<_$_AddSocialMediaAppsRequest>
      get copyWith => __$$_AddSocialMediaAppsRequestCopyWithImpl<
          _$_AddSocialMediaAppsRequest>(this, _$identity);
}

abstract class _AddSocialMediaAppsRequest implements AddSocialMediaAppsRequest {
  const factory _AddSocialMediaAppsRequest(
      {final String? eventId,
      final String? userId,
      final String? socialMediaType,
      final String? socialMediaUrl}) = _$_AddSocialMediaAppsRequest;

  @override
  String? get eventId;
  @override
  String? get userId;
  @override
  String? get socialMediaType;
  @override
  String? get socialMediaUrl;
  @override
  @JsonKey(ignore: true)
  _$$_AddSocialMediaAppsRequestCopyWith<_$_AddSocialMediaAppsRequest>
      get copyWith => throw _privateConstructorUsedError;
}
