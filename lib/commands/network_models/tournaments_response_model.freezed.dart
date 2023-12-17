// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tournaments_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TournamentsResponseModel _$TournamentsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _TournamentsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$TournamentsResponseModel {
  @JsonKey(name: 'data')
  List<String>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TournamentsResponseModelCopyWith<TournamentsResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TournamentsResponseModelCopyWith<$Res> {
  factory $TournamentsResponseModelCopyWith(TournamentsResponseModel value,
          $Res Function(TournamentsResponseModel) then) =
      _$TournamentsResponseModelCopyWithImpl<$Res, TournamentsResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class _$TournamentsResponseModelCopyWithImpl<$Res,
        $Val extends TournamentsResponseModel>
    implements $TournamentsResponseModelCopyWith<$Res> {
  _$TournamentsResponseModelCopyWithImpl(this._value, this._then);

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
              as List<String>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_TournamentsResponseModelCopyWith<$Res>
    implements $TournamentsResponseModelCopyWith<$Res> {
  factory _$$_TournamentsResponseModelCopyWith(
          _$_TournamentsResponseModel value,
          $Res Function(_$_TournamentsResponseModel) then) =
      __$$_TournamentsResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class __$$_TournamentsResponseModelCopyWithImpl<$Res>
    extends _$TournamentsResponseModelCopyWithImpl<$Res,
        _$_TournamentsResponseModel>
    implements _$$_TournamentsResponseModelCopyWith<$Res> {
  __$$_TournamentsResponseModelCopyWithImpl(_$_TournamentsResponseModel _value,
      $Res Function(_$_TournamentsResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_TournamentsResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_TournamentsResponseModel implements _TournamentsResponseModel {
  const _$_TournamentsResponseModel(
      {@JsonKey(name: 'data') final List<String>? data})
      : _data = data;

  factory _$_TournamentsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_TournamentsResponseModelFromJson(json);

  final List<String>? _data;
  @override
  @JsonKey(name: 'data')
  List<String>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TournamentsResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_TournamentsResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_TournamentsResponseModelCopyWith<_$_TournamentsResponseModel>
      get copyWith => __$$_TournamentsResponseModelCopyWithImpl<
          _$_TournamentsResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_TournamentsResponseModelToJson(
      this,
    );
  }
}

abstract class _TournamentsResponseModel implements TournamentsResponseModel {
  const factory _TournamentsResponseModel(
          {@JsonKey(name: 'data') final List<String>? data}) =
      _$_TournamentsResponseModel;

  factory _TournamentsResponseModel.fromJson(Map<String, dynamic> json) =
      _$_TournamentsResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<String>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_TournamentsResponseModelCopyWith<_$_TournamentsResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
