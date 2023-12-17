// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'collection_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

CollectionBody _$CollectionBodyFromJson(Map<String, dynamic> json) {
  return _CollectionBody.fromJson(json);
}

/// @nodoc
mixin _$CollectionBody {
  @JsonKey(name: 'collection')
  String? get collection => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CollectionBodyCopyWith<CollectionBody> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CollectionBodyCopyWith<$Res> {
  factory $CollectionBodyCopyWith(
          CollectionBody value, $Res Function(CollectionBody) then) =
      _$CollectionBodyCopyWithImpl<$Res, CollectionBody>;
  @useResult
  $Res call({@JsonKey(name: 'collection') String? collection});
}

/// @nodoc
class _$CollectionBodyCopyWithImpl<$Res, $Val extends CollectionBody>
    implements $CollectionBodyCopyWith<$Res> {
  _$CollectionBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collection = freezed,
  }) {
    return _then(_value.copyWith(
      collection: freezed == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_CollectionBodyCopyWith<$Res>
    implements $CollectionBodyCopyWith<$Res> {
  factory _$$_CollectionBodyCopyWith(
          _$_CollectionBody value, $Res Function(_$_CollectionBody) then) =
      __$$_CollectionBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'collection') String? collection});
}

/// @nodoc
class __$$_CollectionBodyCopyWithImpl<$Res>
    extends _$CollectionBodyCopyWithImpl<$Res, _$_CollectionBody>
    implements _$$_CollectionBodyCopyWith<$Res> {
  __$$_CollectionBodyCopyWithImpl(
      _$_CollectionBody _value, $Res Function(_$_CollectionBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? collection = freezed,
  }) {
    return _then(_$_CollectionBody(
      collection: freezed == collection
          ? _value.collection
          : collection // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_CollectionBody implements _CollectionBody {
  const _$_CollectionBody({@JsonKey(name: 'collection') this.collection});

  factory _$_CollectionBody.fromJson(Map<String, dynamic> json) =>
      _$$_CollectionBodyFromJson(json);

  @override
  @JsonKey(name: 'collection')
  final String? collection;

  @override
  String toString() {
    return 'CollectionBody(collection: $collection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_CollectionBody &&
            (identical(other.collection, collection) ||
                other.collection == collection));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, collection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_CollectionBodyCopyWith<_$_CollectionBody> get copyWith =>
      __$$_CollectionBodyCopyWithImpl<_$_CollectionBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_CollectionBodyToJson(
      this,
    );
  }
}

abstract class _CollectionBody implements CollectionBody {
  const factory _CollectionBody(
          {@JsonKey(name: 'collection') final String? collection}) =
      _$_CollectionBody;

  factory _CollectionBody.fromJson(Map<String, dynamic> json) =
      _$_CollectionBody.fromJson;

  @override
  @JsonKey(name: 'collection')
  String? get collection;
  @override
  @JsonKey(ignore: true)
  _$$_CollectionBodyCopyWith<_$_CollectionBody> get copyWith =>
      throw _privateConstructorUsedError;
}
