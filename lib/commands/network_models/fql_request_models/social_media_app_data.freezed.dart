// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'social_media_app_data.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SocialMediaAppData _$SocialMediaAppDataFromJson(Map<String, dynamic> json) {
  return _SocialMediaAppData.fromJson(json);
}

/// @nodoc
mixin _$SocialMediaAppData {
  @JsonKey(name: 'object')
  SocialMediaAppObjectData? get object => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SocialMediaAppDataCopyWith<SocialMediaAppData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialMediaAppDataCopyWith<$Res> {
  factory $SocialMediaAppDataCopyWith(
          SocialMediaAppData value, $Res Function(SocialMediaAppData) then) =
      _$SocialMediaAppDataCopyWithImpl<$Res, SocialMediaAppData>;
  @useResult
  $Res call({@JsonKey(name: 'object') SocialMediaAppObjectData? object});

  $SocialMediaAppObjectDataCopyWith<$Res>? get object;
}

/// @nodoc
class _$SocialMediaAppDataCopyWithImpl<$Res, $Val extends SocialMediaAppData>
    implements $SocialMediaAppDataCopyWith<$Res> {
  _$SocialMediaAppDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? object = freezed,
  }) {
    return _then(_value.copyWith(
      object: freezed == object
          ? _value.object
          : object // ignore: cast_nullable_to_non_nullable
              as SocialMediaAppObjectData?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $SocialMediaAppObjectDataCopyWith<$Res>? get object {
    if (_value.object == null) {
      return null;
    }

    return $SocialMediaAppObjectDataCopyWith<$Res>(_value.object!, (value) {
      return _then(_value.copyWith(object: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SocialMediaAppDataCopyWith<$Res>
    implements $SocialMediaAppDataCopyWith<$Res> {
  factory _$$_SocialMediaAppDataCopyWith(_$_SocialMediaAppData value,
          $Res Function(_$_SocialMediaAppData) then) =
      __$$_SocialMediaAppDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'object') SocialMediaAppObjectData? object});

  @override
  $SocialMediaAppObjectDataCopyWith<$Res>? get object;
}

/// @nodoc
class __$$_SocialMediaAppDataCopyWithImpl<$Res>
    extends _$SocialMediaAppDataCopyWithImpl<$Res, _$_SocialMediaAppData>
    implements _$$_SocialMediaAppDataCopyWith<$Res> {
  __$$_SocialMediaAppDataCopyWithImpl(
      _$_SocialMediaAppData _value, $Res Function(_$_SocialMediaAppData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? object = freezed,
  }) {
    return _then(_$_SocialMediaAppData(
      object: freezed == object
          ? _value.object
          : object // ignore: cast_nullable_to_non_nullable
              as SocialMediaAppObjectData?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SocialMediaAppData implements _SocialMediaAppData {
  const _$_SocialMediaAppData({@JsonKey(name: 'object') this.object});

  factory _$_SocialMediaAppData.fromJson(Map<String, dynamic> json) =>
      _$$_SocialMediaAppDataFromJson(json);

  @override
  @JsonKey(name: 'object')
  final SocialMediaAppObjectData? object;

  @override
  String toString() {
    return 'SocialMediaAppData(object: $object)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SocialMediaAppData &&
            (identical(other.object, object) || other.object == object));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, object);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SocialMediaAppDataCopyWith<_$_SocialMediaAppData> get copyWith =>
      __$$_SocialMediaAppDataCopyWithImpl<_$_SocialMediaAppData>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SocialMediaAppDataToJson(
      this,
    );
  }
}

abstract class _SocialMediaAppData implements SocialMediaAppData {
  const factory _SocialMediaAppData(
          {@JsonKey(name: 'object') final SocialMediaAppObjectData? object}) =
      _$_SocialMediaAppData;

  factory _SocialMediaAppData.fromJson(Map<String, dynamic> json) =
      _$_SocialMediaAppData.fromJson;

  @override
  @JsonKey(name: 'object')
  SocialMediaAppObjectData? get object;
  @override
  @JsonKey(ignore: true)
  _$$_SocialMediaAppDataCopyWith<_$_SocialMediaAppData> get copyWith =>
      throw _privateConstructorUsedError;
}

SocialMediaAppObjectData _$SocialMediaAppObjectDataFromJson(
    Map<String, dynamic> json) {
  return _SocialMediaAppObjectData.fromJson(json);
}

/// @nodoc
mixin _$SocialMediaAppObjectData {
  @JsonKey(name: 'type')
  String? get type => throw _privateConstructorUsedError;
  @JsonKey(name: 'url')
  String? get url => throw _privateConstructorUsedError;
  @JsonKey(name: 'user')
  VarBody? get user => throw _privateConstructorUsedError;
  @JsonKey(name: 'event')
  VarBody? get event => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SocialMediaAppObjectDataCopyWith<SocialMediaAppObjectData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SocialMediaAppObjectDataCopyWith<$Res> {
  factory $SocialMediaAppObjectDataCopyWith(SocialMediaAppObjectData value,
          $Res Function(SocialMediaAppObjectData) then) =
      _$SocialMediaAppObjectDataCopyWithImpl<$Res, SocialMediaAppObjectData>;
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'url') String? url,
      @JsonKey(name: 'user') VarBody? user,
      @JsonKey(name: 'event') VarBody? event});

  $VarBodyCopyWith<$Res>? get user;
  $VarBodyCopyWith<$Res>? get event;
}

/// @nodoc
class _$SocialMediaAppObjectDataCopyWithImpl<$Res,
        $Val extends SocialMediaAppObjectData>
    implements $SocialMediaAppObjectDataCopyWith<$Res> {
  _$SocialMediaAppObjectDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? url = freezed,
    Object? user = freezed,
    Object? event = freezed,
  }) {
    return _then(_value.copyWith(
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
              as VarBody?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as VarBody?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $VarBodyCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $VarBodyCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $VarBodyCopyWith<$Res>? get event {
    if (_value.event == null) {
      return null;
    }

    return $VarBodyCopyWith<$Res>(_value.event!, (value) {
      return _then(_value.copyWith(event: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_SocialMediaAppObjectDataCopyWith<$Res>
    implements $SocialMediaAppObjectDataCopyWith<$Res> {
  factory _$$_SocialMediaAppObjectDataCopyWith(
          _$_SocialMediaAppObjectData value,
          $Res Function(_$_SocialMediaAppObjectData) then) =
      __$$_SocialMediaAppObjectDataCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'type') String? type,
      @JsonKey(name: 'url') String? url,
      @JsonKey(name: 'user') VarBody? user,
      @JsonKey(name: 'event') VarBody? event});

  @override
  $VarBodyCopyWith<$Res>? get user;
  @override
  $VarBodyCopyWith<$Res>? get event;
}

/// @nodoc
class __$$_SocialMediaAppObjectDataCopyWithImpl<$Res>
    extends _$SocialMediaAppObjectDataCopyWithImpl<$Res,
        _$_SocialMediaAppObjectData>
    implements _$$_SocialMediaAppObjectDataCopyWith<$Res> {
  __$$_SocialMediaAppObjectDataCopyWithImpl(_$_SocialMediaAppObjectData _value,
      $Res Function(_$_SocialMediaAppObjectData) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? type = freezed,
    Object? url = freezed,
    Object? user = freezed,
    Object? event = freezed,
  }) {
    return _then(_$_SocialMediaAppObjectData(
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
              as VarBody?,
      event: freezed == event
          ? _value.event
          : event // ignore: cast_nullable_to_non_nullable
              as VarBody?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_SocialMediaAppObjectData implements _SocialMediaAppObjectData {
  const _$_SocialMediaAppObjectData(
      {@JsonKey(name: 'type') this.type,
      @JsonKey(name: 'url') this.url,
      @JsonKey(name: 'user') this.user,
      @JsonKey(name: 'event') this.event});

  factory _$_SocialMediaAppObjectData.fromJson(Map<String, dynamic> json) =>
      _$$_SocialMediaAppObjectDataFromJson(json);

  @override
  @JsonKey(name: 'type')
  final String? type;
  @override
  @JsonKey(name: 'url')
  final String? url;
  @override
  @JsonKey(name: 'user')
  final VarBody? user;
  @override
  @JsonKey(name: 'event')
  final VarBody? event;

  @override
  String toString() {
    return 'SocialMediaAppObjectData(type: $type, url: $url, user: $user, event: $event)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_SocialMediaAppObjectData &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.user, user) || other.user == user) &&
            (identical(other.event, event) || other.event == event));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, type, url, user, event);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_SocialMediaAppObjectDataCopyWith<_$_SocialMediaAppObjectData>
      get copyWith => __$$_SocialMediaAppObjectDataCopyWithImpl<
          _$_SocialMediaAppObjectData>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_SocialMediaAppObjectDataToJson(
      this,
    );
  }
}

abstract class _SocialMediaAppObjectData implements SocialMediaAppObjectData {
  const factory _SocialMediaAppObjectData(
          {@JsonKey(name: 'type') final String? type,
          @JsonKey(name: 'url') final String? url,
          @JsonKey(name: 'user') final VarBody? user,
          @JsonKey(name: 'event') final VarBody? event}) =
      _$_SocialMediaAppObjectData;

  factory _SocialMediaAppObjectData.fromJson(Map<String, dynamic> json) =
      _$_SocialMediaAppObjectData.fromJson;

  @override
  @JsonKey(name: 'type')
  String? get type;
  @override
  @JsonKey(name: 'url')
  String? get url;
  @override
  @JsonKey(name: 'user')
  VarBody? get user;
  @override
  @JsonKey(name: 'event')
  VarBody? get event;
  @override
  @JsonKey(ignore: true)
  _$$_SocialMediaAppObjectDataCopyWith<_$_SocialMediaAppObjectData>
      get copyWith => throw _privateConstructorUsedError;
}
