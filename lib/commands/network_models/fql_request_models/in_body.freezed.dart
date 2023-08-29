// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'in_body.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

InBody _$InBodyFromJson(Map<String, dynamic> json) {
  return _InBody.fromJson(json);
}

/// @nodoc
mixin _$InBody {
  @JsonKey(name: 'create')
  CollectionBody? get create => throw _privateConstructorUsedError;
  @JsonKey(name: 'params')
  ObjectParamsBody? get params => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $InBodyCopyWith<InBody> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $InBodyCopyWith<$Res> {
  factory $InBodyCopyWith(InBody value, $Res Function(InBody) then) =
      _$InBodyCopyWithImpl<$Res, InBody>;
  @useResult
  $Res call(
      {@JsonKey(name: 'create') CollectionBody? create,
      @JsonKey(name: 'params') ObjectParamsBody? params});

  $CollectionBodyCopyWith<$Res>? get create;
  $ObjectParamsBodyCopyWith<$Res>? get params;
}

/// @nodoc
class _$InBodyCopyWithImpl<$Res, $Val extends InBody>
    implements $InBodyCopyWith<$Res> {
  _$InBodyCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? create = freezed,
    Object? params = freezed,
  }) {
    return _then(_value.copyWith(
      create: freezed == create
          ? _value.create
          : create // ignore: cast_nullable_to_non_nullable
              as CollectionBody?,
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as ObjectParamsBody?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CollectionBodyCopyWith<$Res>? get create {
    if (_value.create == null) {
      return null;
    }

    return $CollectionBodyCopyWith<$Res>(_value.create!, (value) {
      return _then(_value.copyWith(create: value) as $Val);
    });
  }

  @override
  @pragma('vm:prefer-inline')
  $ObjectParamsBodyCopyWith<$Res>? get params {
    if (_value.params == null) {
      return null;
    }

    return $ObjectParamsBodyCopyWith<$Res>(_value.params!, (value) {
      return _then(_value.copyWith(params: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_InBodyCopyWith<$Res> implements $InBodyCopyWith<$Res> {
  factory _$$_InBodyCopyWith(_$_InBody value, $Res Function(_$_InBody) then) =
      __$$_InBodyCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'create') CollectionBody? create,
      @JsonKey(name: 'params') ObjectParamsBody? params});

  @override
  $CollectionBodyCopyWith<$Res>? get create;
  @override
  $ObjectParamsBodyCopyWith<$Res>? get params;
}

/// @nodoc
class __$$_InBodyCopyWithImpl<$Res>
    extends _$InBodyCopyWithImpl<$Res, _$_InBody>
    implements _$$_InBodyCopyWith<$Res> {
  __$$_InBodyCopyWithImpl(_$_InBody _value, $Res Function(_$_InBody) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? create = freezed,
    Object? params = freezed,
  }) {
    return _then(_$_InBody(
      create: freezed == create
          ? _value.create
          : create // ignore: cast_nullable_to_non_nullable
              as CollectionBody?,
      params: freezed == params
          ? _value.params
          : params // ignore: cast_nullable_to_non_nullable
              as ObjectParamsBody?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_InBody implements _InBody {
  const _$_InBody(
      {@JsonKey(name: 'create') this.create,
      @JsonKey(name: 'params') this.params});

  factory _$_InBody.fromJson(Map<String, dynamic> json) =>
      _$$_InBodyFromJson(json);

  @override
  @JsonKey(name: 'create')
  final CollectionBody? create;
  @override
  @JsonKey(name: 'params')
  final ObjectParamsBody? params;

  @override
  String toString() {
    return 'InBody(create: $create, params: $params)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_InBody &&
            (identical(other.create, create) || other.create == create) &&
            (identical(other.params, params) || other.params == params));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, create, params);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_InBodyCopyWith<_$_InBody> get copyWith =>
      __$$_InBodyCopyWithImpl<_$_InBody>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_InBodyToJson(
      this,
    );
  }
}

abstract class _InBody implements InBody {
  const factory _InBody(
      {@JsonKey(name: 'create') final CollectionBody? create,
      @JsonKey(name: 'params') final ObjectParamsBody? params}) = _$_InBody;

  factory _InBody.fromJson(Map<String, dynamic> json) = _$_InBody.fromJson;

  @override
  @JsonKey(name: 'create')
  CollectionBody? get create;
  @override
  @JsonKey(name: 'params')
  ObjectParamsBody? get params;
  @override
  @JsonKey(ignore: true)
  _$$_InBodyCopyWith<_$_InBody> get copyWith =>
      throw _privateConstructorUsedError;
}
