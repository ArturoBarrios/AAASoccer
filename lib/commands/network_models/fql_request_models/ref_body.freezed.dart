// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ref_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

RefBody _$RefBodyFromJson(Map<String, dynamic> json) {
  return _RefBody.fromJson(json);
}

/// @nodoc
mixin _$RefBody {
  @JsonKey(name: 'ref')
  CollectionBody? get ref => throw _privateConstructorUsedError;
  @JsonKey(name: 'id')
  String? get id => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RefBodyCopyWith<RefBody> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RefBodyCopyWith<$Res> {
  factory $RefBodyCopyWith(RefBody value, $Res Function(RefBody) then) =
      _$RefBodyCopyWithImpl<$Res, RefBody>;
  @useResult
  $Res call(
      {@JsonKey(name: 'ref') CollectionBody? ref,
      @JsonKey(name: 'id') String? id});

  $CollectionBodyCopyWith<$Res>? get ref;
}

/// @nodoc
class _$RefBodyCopyWithImpl<$Res, $Val extends RefBody>
    implements $RefBodyCopyWith<$Res> {
  _$RefBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = freezed,
    Object? id = freezed,
  }) {
    return _then(_value.copyWith(
      ref: freezed == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as CollectionBody?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CollectionBodyCopyWith<$Res>? get ref {
    if (_value.ref == null) {
      return null;
    }

    return $CollectionBodyCopyWith<$Res>(_value.ref!, (value) {
      return _then(_value.copyWith(ref: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_RefBodyCopyWith<$Res> implements $RefBodyCopyWith<$Res> {
  factory _$$_RefBodyCopyWith(
          _$_RefBody value, $Res Function(_$_RefBody) then) =
      __$$_RefBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'ref') CollectionBody? ref,
      @JsonKey(name: 'id') String? id});

  @override
  $CollectionBodyCopyWith<$Res>? get ref;
}

/// @nodoc
class __$$_RefBodyCopyWithImpl<$Res>
    extends _$RefBodyCopyWithImpl<$Res, _$_RefBody>
    implements _$$_RefBodyCopyWith<$Res> {
  __$$_RefBodyCopyWithImpl(_$_RefBody _value, $Res Function(_$_RefBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? ref = freezed,
    Object? id = freezed,
  }) {
    return _then(_$_RefBody(
      ref: freezed == ref
          ? _value.ref
          : ref // ignore: cast_nullable_to_non_nullable
              as CollectionBody?,
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_RefBody implements _RefBody {
  const _$_RefBody(
      {@JsonKey(name: 'ref') this.ref, @JsonKey(name: 'id') this.id});

  factory _$_RefBody.fromJson(Map<String, dynamic> json) =>
      _$$_RefBodyFromJson(json);

  @override
  @JsonKey(name: 'ref')
  final CollectionBody? ref;
  @override
  @JsonKey(name: 'id')
  final String? id;

  @override
  String toString() {
    return 'RefBody(ref: $ref, id: $id)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_RefBody &&
            (identical(other.ref, ref) || other.ref == ref) &&
            (identical(other.id, id) || other.id == id));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, ref, id);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_RefBodyCopyWith<_$_RefBody> get copyWith =>
      __$$_RefBodyCopyWithImpl<_$_RefBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_RefBodyToJson(
      this,
    );
  }
}

abstract class _RefBody implements RefBody {
  const factory _RefBody(
      {@JsonKey(name: 'ref') final CollectionBody? ref,
      @JsonKey(name: 'id') final String? id}) = _$_RefBody;

  factory _RefBody.fromJson(Map<String, dynamic> json) = _$_RefBody.fromJson;

  @override
  @JsonKey(name: 'ref')
  CollectionBody? get ref;
  @override
  @JsonKey(name: 'id')
  String? get id;
  @override
  @JsonKey(ignore: true)
  _$$_RefBodyCopyWith<_$_RefBody> get copyWith =>
      throw _privateConstructorUsedError;
}
