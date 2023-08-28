// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'base_update_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

BaseUpdateResponseModel _$BaseUpdateResponseModelFromJson(
    Map<String, dynamic> json) {
  return _BaseUpdateResponseModel.fromJson(json);
}

/// @nodoc
mixin _$BaseUpdateResponseModel {
  @JsonKey(name: 'data')
  UpdateEventDataModel? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BaseUpdateResponseModelCopyWith<BaseUpdateResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BaseUpdateResponseModelCopyWith<$Res> {
  factory $BaseUpdateResponseModelCopyWith(BaseUpdateResponseModel value,
          $Res Function(BaseUpdateResponseModel) then) =
      _$BaseUpdateResponseModelCopyWithImpl<$Res, BaseUpdateResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') UpdateEventDataModel? data});

  $UpdateEventDataModelCopyWith<$Res>? get data;
}

/// @nodoc
class _$BaseUpdateResponseModelCopyWithImpl<$Res,
        $Val extends BaseUpdateResponseModel>
    implements $BaseUpdateResponseModelCopyWith<$Res> {
  _$BaseUpdateResponseModelCopyWithImpl(this._value, this._then);

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
              as UpdateEventDataModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $UpdateEventDataModelCopyWith<$Res>? get data {
    if (_value.data == null) {
      return null;
    }

    return $UpdateEventDataModelCopyWith<$Res>(_value.data!, (value) {
      return _then(_value.copyWith(data: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_BaseUpdateResponseModelCopyWith<$Res>
    implements $BaseUpdateResponseModelCopyWith<$Res> {
  factory _$$_BaseUpdateResponseModelCopyWith(_$_BaseUpdateResponseModel value,
          $Res Function(_$_BaseUpdateResponseModel) then) =
      __$$_BaseUpdateResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') UpdateEventDataModel? data});

  @override
  $UpdateEventDataModelCopyWith<$Res>? get data;
}

/// @nodoc
class __$$_BaseUpdateResponseModelCopyWithImpl<$Res>
    extends _$BaseUpdateResponseModelCopyWithImpl<$Res,
        _$_BaseUpdateResponseModel>
    implements _$$_BaseUpdateResponseModelCopyWith<$Res> {
  __$$_BaseUpdateResponseModelCopyWithImpl(_$_BaseUpdateResponseModel _value,
      $Res Function(_$_BaseUpdateResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_BaseUpdateResponseModel(
      data: freezed == data
          ? _value.data
          : data // ignore: cast_nullable_to_non_nullable
              as UpdateEventDataModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_BaseUpdateResponseModel implements _BaseUpdateResponseModel {
  const _$_BaseUpdateResponseModel({@JsonKey(name: 'data') this.data});

  factory _$_BaseUpdateResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_BaseUpdateResponseModelFromJson(json);

  @override
  @JsonKey(name: 'data')
  final UpdateEventDataModel? data;

  @override
  String toString() {
    return 'BaseUpdateResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_BaseUpdateResponseModel &&
            (identical(other.data, data) || other.data == data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, data);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_BaseUpdateResponseModelCopyWith<_$_BaseUpdateResponseModel>
      get copyWith =>
          __$$_BaseUpdateResponseModelCopyWithImpl<_$_BaseUpdateResponseModel>(
              this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BaseUpdateResponseModelToJson(
      this,
    );
  }
}

abstract class _BaseUpdateResponseModel implements BaseUpdateResponseModel {
  const factory _BaseUpdateResponseModel(
          {@JsonKey(name: 'data') final UpdateEventDataModel? data}) =
      _$_BaseUpdateResponseModel;

  factory _BaseUpdateResponseModel.fromJson(Map<String, dynamic> json) =
      _$_BaseUpdateResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  UpdateEventDataModel? get data;
  @override
  @JsonKey(ignore: true)
  _$$_BaseUpdateResponseModelCopyWith<_$_BaseUpdateResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
