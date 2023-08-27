// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'messages_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

MessagesResponseModel _$MessagesResponseModelFromJson(
    Map<String, dynamic> json) {
  return _MessagesResponseModel.fromJson(json);
}

/// @nodoc
mixin _$MessagesResponseModel {
  @JsonKey(name: 'data')
  List<String>? get data => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MessagesResponseModelCopyWith<MessagesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MessagesResponseModelCopyWith<$Res> {
  factory $MessagesResponseModelCopyWith(MessagesResponseModel value,
          $Res Function(MessagesResponseModel) then) =
      _$MessagesResponseModelCopyWithImpl<$Res, MessagesResponseModel>;
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class _$MessagesResponseModelCopyWithImpl<$Res,
        $Val extends MessagesResponseModel>
    implements $MessagesResponseModelCopyWith<$Res> {
  _$MessagesResponseModelCopyWithImpl(this._value, this._then);

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
abstract class _$$_MessagesResponseModelCopyWith<$Res>
    implements $MessagesResponseModelCopyWith<$Res> {
  factory _$$_MessagesResponseModelCopyWith(_$_MessagesResponseModel value,
          $Res Function(_$_MessagesResponseModel) then) =
      __$$_MessagesResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'data') List<String>? data});
}

/// @nodoc
class __$$_MessagesResponseModelCopyWithImpl<$Res>
    extends _$MessagesResponseModelCopyWithImpl<$Res, _$_MessagesResponseModel>
    implements _$$_MessagesResponseModelCopyWith<$Res> {
  __$$_MessagesResponseModelCopyWithImpl(_$_MessagesResponseModel _value,
      $Res Function(_$_MessagesResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_MessagesResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_MessagesResponseModel implements _MessagesResponseModel {
  const _$_MessagesResponseModel(
      {@JsonKey(name: 'data') final List<String>? data})
      : _data = data;

  factory _$_MessagesResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_MessagesResponseModelFromJson(json);

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
    return 'MessagesResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_MessagesResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_MessagesResponseModelCopyWith<_$_MessagesResponseModel> get copyWith =>
      __$$_MessagesResponseModelCopyWithImpl<_$_MessagesResponseModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MessagesResponseModelToJson(
      this,
    );
  }
}

abstract class _MessagesResponseModel implements MessagesResponseModel {
  const factory _MessagesResponseModel(
          {@JsonKey(name: 'data') final List<String>? data}) =
      _$_MessagesResponseModel;

  factory _MessagesResponseModel.fromJson(Map<String, dynamic> json) =
      _$_MessagesResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<String>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_MessagesResponseModelCopyWith<_$_MessagesResponseModel> get copyWith =>
      throw _privateConstructorUsedError;
}
