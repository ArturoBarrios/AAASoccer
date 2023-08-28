// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'join_conditions_response_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

JoinConditionsResponseModel _$JoinConditionsResponseModelFromJson(
    Map<String, dynamic> json) {
  return _JoinConditionsResponseModel.fromJson(json);
}

/// @nodoc
mixin _$JoinConditionsResponseModel {
  @JsonKey(name: 'data')
  List<JoinConditionsDataResponseModel>? get data =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JoinConditionsResponseModelCopyWith<JoinConditionsResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinConditionsResponseModelCopyWith<$Res> {
  factory $JoinConditionsResponseModelCopyWith(
          JoinConditionsResponseModel value,
          $Res Function(JoinConditionsResponseModel) then) =
      _$JoinConditionsResponseModelCopyWithImpl<$Res,
          JoinConditionsResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<JoinConditionsDataResponseModel>? data});
}

/// @nodoc
class _$JoinConditionsResponseModelCopyWithImpl<$Res,
        $Val extends JoinConditionsResponseModel>
    implements $JoinConditionsResponseModelCopyWith<$Res> {
  _$JoinConditionsResponseModelCopyWithImpl(this._value, this._then);

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
              as List<JoinConditionsDataResponseModel>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JoinConditionsResponseModelCopyWith<$Res>
    implements $JoinConditionsResponseModelCopyWith<$Res> {
  factory _$$_JoinConditionsResponseModelCopyWith(
          _$_JoinConditionsResponseModel value,
          $Res Function(_$_JoinConditionsResponseModel) then) =
      __$$_JoinConditionsResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: 'data') List<JoinConditionsDataResponseModel>? data});
}

/// @nodoc
class __$$_JoinConditionsResponseModelCopyWithImpl<$Res>
    extends _$JoinConditionsResponseModelCopyWithImpl<$Res,
        _$_JoinConditionsResponseModel>
    implements _$$_JoinConditionsResponseModelCopyWith<$Res> {
  __$$_JoinConditionsResponseModelCopyWithImpl(
      _$_JoinConditionsResponseModel _value,
      $Res Function(_$_JoinConditionsResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? data = freezed,
  }) {
    return _then(_$_JoinConditionsResponseModel(
      data: freezed == data
          ? _value._data
          : data // ignore: cast_nullable_to_non_nullable
              as List<JoinConditionsDataResponseModel>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JoinConditionsResponseModel implements _JoinConditionsResponseModel {
  const _$_JoinConditionsResponseModel(
      {@JsonKey(name: 'data')
      final List<JoinConditionsDataResponseModel>? data})
      : _data = data;

  factory _$_JoinConditionsResponseModel.fromJson(Map<String, dynamic> json) =>
      _$$_JoinConditionsResponseModelFromJson(json);

  final List<JoinConditionsDataResponseModel>? _data;
  @override
  @JsonKey(name: 'data')
  List<JoinConditionsDataResponseModel>? get data {
    final value = _data;
    if (value == null) return null;
    if (_data is EqualUnmodifiableListView) return _data;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'JoinConditionsResponseModel(data: $data)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JoinConditionsResponseModel &&
            const DeepCollectionEquality().equals(other._data, _data));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, const DeepCollectionEquality().hash(_data));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JoinConditionsResponseModelCopyWith<_$_JoinConditionsResponseModel>
      get copyWith => __$$_JoinConditionsResponseModelCopyWithImpl<
          _$_JoinConditionsResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JoinConditionsResponseModelToJson(
      this,
    );
  }
}

abstract class _JoinConditionsResponseModel
    implements JoinConditionsResponseModel {
  const factory _JoinConditionsResponseModel(
          {@JsonKey(name: 'data')
          final List<JoinConditionsDataResponseModel>? data}) =
      _$_JoinConditionsResponseModel;

  factory _JoinConditionsResponseModel.fromJson(Map<String, dynamic> json) =
      _$_JoinConditionsResponseModel.fromJson;

  @override
  @JsonKey(name: 'data')
  List<JoinConditionsDataResponseModel>? get data;
  @override
  @JsonKey(ignore: true)
  _$$_JoinConditionsResponseModelCopyWith<_$_JoinConditionsResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

JoinConditionsDataResponseModel _$JoinConditionsDataResponseModelFromJson(
    Map<String, dynamic> json) {
  return _JoinConditionsDataResponseModel.fromJson(json);
}

/// @nodoc
mixin _$JoinConditionsDataResponseModel {
  @JsonKey(name: '_id')
  String? get id => throw _privateConstructorUsedError;
  @JsonKey(name: 'withRequest')
  bool? get withRequest => throw _privateConstructorUsedError;
  @JsonKey(name: 'withPayment')
  bool? get withPayment => throw _privateConstructorUsedError;
  @JsonKey(name: 'forTeam')
  bool? get forTeam => throw _privateConstructorUsedError;
  @JsonKey(name: 'forEvent')
  bool? get forEvent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $JoinConditionsDataResponseModelCopyWith<JoinConditionsDataResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $JoinConditionsDataResponseModelCopyWith<$Res> {
  factory $JoinConditionsDataResponseModelCopyWith(
          JoinConditionsDataResponseModel value,
          $Res Function(JoinConditionsDataResponseModel) then) =
      _$JoinConditionsDataResponseModelCopyWithImpl<$Res,
          JoinConditionsDataResponseModel>;
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'withRequest') bool? withRequest,
      @JsonKey(name: 'withPayment') bool? withPayment,
      @JsonKey(name: 'forTeam') bool? forTeam,
      @JsonKey(name: 'forEvent') bool? forEvent});
}

/// @nodoc
class _$JoinConditionsDataResponseModelCopyWithImpl<$Res,
        $Val extends JoinConditionsDataResponseModel>
    implements $JoinConditionsDataResponseModelCopyWith<$Res> {
  _$JoinConditionsDataResponseModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? withRequest = freezed,
    Object? withPayment = freezed,
    Object? forTeam = freezed,
    Object? forEvent = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      withRequest: freezed == withRequest
          ? _value.withRequest
          : withRequest // ignore: cast_nullable_to_non_nullable
              as bool?,
      withPayment: freezed == withPayment
          ? _value.withPayment
          : withPayment // ignore: cast_nullable_to_non_nullable
              as bool?,
      forTeam: freezed == forTeam
          ? _value.forTeam
          : forTeam // ignore: cast_nullable_to_non_nullable
              as bool?,
      forEvent: freezed == forEvent
          ? _value.forEvent
          : forEvent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$_JoinConditionsDataResponseModelCopyWith<$Res>
    implements $JoinConditionsDataResponseModelCopyWith<$Res> {
  factory _$$_JoinConditionsDataResponseModelCopyWith(
          _$_JoinConditionsDataResponseModel value,
          $Res Function(_$_JoinConditionsDataResponseModel) then) =
      __$$_JoinConditionsDataResponseModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {@JsonKey(name: '_id') String? id,
      @JsonKey(name: 'withRequest') bool? withRequest,
      @JsonKey(name: 'withPayment') bool? withPayment,
      @JsonKey(name: 'forTeam') bool? forTeam,
      @JsonKey(name: 'forEvent') bool? forEvent});
}

/// @nodoc
class __$$_JoinConditionsDataResponseModelCopyWithImpl<$Res>
    extends _$JoinConditionsDataResponseModelCopyWithImpl<$Res,
        _$_JoinConditionsDataResponseModel>
    implements _$$_JoinConditionsDataResponseModelCopyWith<$Res> {
  __$$_JoinConditionsDataResponseModelCopyWithImpl(
      _$_JoinConditionsDataResponseModel _value,
      $Res Function(_$_JoinConditionsDataResponseModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? withRequest = freezed,
    Object? withPayment = freezed,
    Object? forTeam = freezed,
    Object? forEvent = freezed,
  }) {
    return _then(_$_JoinConditionsDataResponseModel(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      withRequest: freezed == withRequest
          ? _value.withRequest
          : withRequest // ignore: cast_nullable_to_non_nullable
              as bool?,
      withPayment: freezed == withPayment
          ? _value.withPayment
          : withPayment // ignore: cast_nullable_to_non_nullable
              as bool?,
      forTeam: freezed == forTeam
          ? _value.forTeam
          : forTeam // ignore: cast_nullable_to_non_nullable
              as bool?,
      forEvent: freezed == forEvent
          ? _value.forEvent
          : forEvent // ignore: cast_nullable_to_non_nullable
              as bool?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_JoinConditionsDataResponseModel
    implements _JoinConditionsDataResponseModel {
  const _$_JoinConditionsDataResponseModel(
      {@JsonKey(name: '_id') this.id,
      @JsonKey(name: 'withRequest') this.withRequest,
      @JsonKey(name: 'withPayment') this.withPayment,
      @JsonKey(name: 'forTeam') this.forTeam,
      @JsonKey(name: 'forEvent') this.forEvent});

  factory _$_JoinConditionsDataResponseModel.fromJson(
          Map<String, dynamic> json) =>
      _$$_JoinConditionsDataResponseModelFromJson(json);

  @override
  @JsonKey(name: '_id')
  final String? id;
  @override
  @JsonKey(name: 'withRequest')
  final bool? withRequest;
  @override
  @JsonKey(name: 'withPayment')
  final bool? withPayment;
  @override
  @JsonKey(name: 'forTeam')
  final bool? forTeam;
  @override
  @JsonKey(name: 'forEvent')
  final bool? forEvent;

  @override
  String toString() {
    return 'JoinConditionsDataResponseModel(id: $id, withRequest: $withRequest, withPayment: $withPayment, forTeam: $forTeam, forEvent: $forEvent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_JoinConditionsDataResponseModel &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.withRequest, withRequest) ||
                other.withRequest == withRequest) &&
            (identical(other.withPayment, withPayment) ||
                other.withPayment == withPayment) &&
            (identical(other.forTeam, forTeam) || other.forTeam == forTeam) &&
            (identical(other.forEvent, forEvent) ||
                other.forEvent == forEvent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, withRequest, withPayment, forTeam, forEvent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_JoinConditionsDataResponseModelCopyWith<
          _$_JoinConditionsDataResponseModel>
      get copyWith => __$$_JoinConditionsDataResponseModelCopyWithImpl<
          _$_JoinConditionsDataResponseModel>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_JoinConditionsDataResponseModelToJson(
      this,
    );
  }
}

abstract class _JoinConditionsDataResponseModel
    implements JoinConditionsDataResponseModel {
  const factory _JoinConditionsDataResponseModel(
          {@JsonKey(name: '_id') final String? id,
          @JsonKey(name: 'withRequest') final bool? withRequest,
          @JsonKey(name: 'withPayment') final bool? withPayment,
          @JsonKey(name: 'forTeam') final bool? forTeam,
          @JsonKey(name: 'forEvent') final bool? forEvent}) =
      _$_JoinConditionsDataResponseModel;

  factory _JoinConditionsDataResponseModel.fromJson(Map<String, dynamic> json) =
      _$_JoinConditionsDataResponseModel.fromJson;

  @override
  @JsonKey(name: '_id')
  String? get id;
  @override
  @JsonKey(name: 'withRequest')
  bool? get withRequest;
  @override
  @JsonKey(name: 'withPayment')
  bool? get withPayment;
  @override
  @JsonKey(name: 'forTeam')
  bool? get forTeam;
  @override
  @JsonKey(name: 'forEvent')
  bool? get forEvent;
  @override
  @JsonKey(ignore: true)
  _$$_JoinConditionsDataResponseModelCopyWith<
          _$_JoinConditionsDataResponseModel>
      get copyWith => throw _privateConstructorUsedError;
}
