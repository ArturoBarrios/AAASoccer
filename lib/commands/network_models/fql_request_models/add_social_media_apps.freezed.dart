// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'add_social_media_apps.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AddSocialMediaApps _$AddSocialMediaAppsFromJson(Map<String, dynamic> json) {
  return _AddSocialMediaApps.fromJson(json);
}

/// @nodoc
mixin _$AddSocialMediaApps {
  @JsonKey(name: 'let')
  List<AddSocialMediaAppsLet>? get let => throw _privateConstructorUsedError;
  @JsonKey(name: 'in')
  InBody? get inProperty => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AddSocialMediaAppsCopyWith<AddSocialMediaApps> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AddSocialMediaAppsCopyWith<$Res> {
  factory $AddSocialMediaAppsCopyWith(
          AddSocialMediaApps value, $Res Function(AddSocialMediaApps) then) =
      _$AddSocialMediaAppsCopyWithImpl<$Res, AddSocialMediaApps>;
  @useResult
  $Res call(
      {@JsonKey(name: 'let') List<AddSocialMediaAppsLet>? let,
      @JsonKey(name: 'in') InBody? inProperty});

  $InBodyCopyWith<$Res>? get inProperty;
}

/// @nodoc
class _$AddSocialMediaAppsCopyWithImpl<$Res, $Val extends AddSocialMediaApps>
    implements $AddSocialMediaAppsCopyWith<$Res> {
  _$AddSocialMediaAppsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? let = freezed,
    Object? inProperty = freezed,
  }) {
    return _then(_value.copyWith(
      let: freezed == let
          ? _value.let
          : let // ignore: cast_nullable_to_non_nullable
              as List<AddSocialMediaAppsLet>?,
      inProperty: freezed == inProperty
          ? _value.inProperty
          : inProperty // ignore: cast_nullable_to_non_nullable
              as InBody?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $InBodyCopyWith<$Res>? get inProperty {
    if (_value.inProperty == null) {
      return null;
    }

    return $InBodyCopyWith<$Res>(_value.inProperty!, (value) {
      return _then(_value.copyWith(inProperty: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_AddSocialMediaAppsCopyWith<$Res>
    implements $AddSocialMediaAppsCopyWith<$Res> {
  factory _$$_AddSocialMediaAppsCopyWith(_$_AddSocialMediaApps value,
          $Res Function(_$_AddSocialMediaApps) then) =
      __$$_AddSocialMediaAppsCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'let') List<AddSocialMediaAppsLet>? let,
      @JsonKey(name: 'in') InBody? inProperty});

  @override
  $InBodyCopyWith<$Res>? get inProperty;
}

/// @nodoc
class __$$_AddSocialMediaAppsCopyWithImpl<$Res>
    extends _$AddSocialMediaAppsCopyWithImpl<$Res, _$_AddSocialMediaApps>
    implements _$$_AddSocialMediaAppsCopyWith<$Res> {
  __$$_AddSocialMediaAppsCopyWithImpl(
      _$_AddSocialMediaApps _value, $Res Function(_$_AddSocialMediaApps) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? let = freezed,
    Object? inProperty = freezed,
  }) {
    return _then(_$_AddSocialMediaApps(
      let: freezed == let
          ? _value._let
          : let // ignore: cast_nullable_to_non_nullable
              as List<AddSocialMediaAppsLet>?,
      inProperty: freezed == inProperty
          ? _value.inProperty
          : inProperty // ignore: cast_nullable_to_non_nullable
              as InBody?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_AddSocialMediaApps implements _AddSocialMediaApps {
  const _$_AddSocialMediaApps(
      {@JsonKey(name: 'let') final List<AddSocialMediaAppsLet>? let,
      @JsonKey(name: 'in') this.inProperty})
      : _let = let;

  factory _$_AddSocialMediaApps.fromJson(Map<String, dynamic> json) =>
      _$$_AddSocialMediaAppsFromJson(json);

  final List<AddSocialMediaAppsLet>? _let;
  @override
  @JsonKey(name: 'let')
  List<AddSocialMediaAppsLet>? get let {
    final value = _let;
    if (value == null) return null;
    if (_let is EqualUnmodifiableListView) return _let;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  @JsonKey(name: 'in')
  final InBody? inProperty;

  @override
  String toString() {
    return 'AddSocialMediaApps(let: $let, inProperty: $inProperty)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_AddSocialMediaApps &&
            const DeepCollectionEquality().equals(other._let, _let) &&
            (identical(other.inProperty, inProperty) ||
                other.inProperty == inProperty));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_let), inProperty);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_AddSocialMediaAppsCopyWith<_$_AddSocialMediaApps> get copyWith =>
      __$$_AddSocialMediaAppsCopyWithImpl<_$_AddSocialMediaApps>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_AddSocialMediaAppsToJson(
      this,
    );
  }
}

abstract class _AddSocialMediaApps implements AddSocialMediaApps {
  const factory _AddSocialMediaApps(
      {@JsonKey(name: 'let') final List<AddSocialMediaAppsLet>? let,
      @JsonKey(name: 'in') final InBody? inProperty}) = _$_AddSocialMediaApps;

  factory _AddSocialMediaApps.fromJson(Map<String, dynamic> json) =
      _$_AddSocialMediaApps.fromJson;

  @override
  @JsonKey(name: 'let')
  List<AddSocialMediaAppsLet>? get let;
  @override
  @JsonKey(name: 'in')
  InBody? get inProperty;
  @override
  @JsonKey(ignore: true)
  _$$_AddSocialMediaAppsCopyWith<_$_AddSocialMediaApps> get copyWith =>
      throw _privateConstructorUsedError;
}
