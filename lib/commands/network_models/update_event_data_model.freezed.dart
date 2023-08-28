// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'update_event_data_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

UpdateEventDataModel _$UpdateEventDataModelFromJson(Map<String, dynamic> json) {
  return _UpdateEventDataModel.fromJson(json);
}

/// @nodoc
mixin _$UpdateEventDataModel {
  @JsonKey(name: 'updateEvent')
  EventResponseModel? get updateEvent => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UpdateEventDataModelCopyWith<UpdateEventDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UpdateEventDataModelCopyWith<$Res> {
  factory $UpdateEventDataModelCopyWith(UpdateEventDataModel value,
          $Res Function(UpdateEventDataModel) then) =
      _$UpdateEventDataModelCopyWithImpl<$Res, UpdateEventDataModel>;
  @useResult
  $Res call({@JsonKey(name: 'updateEvent') EventResponseModel? updateEvent});

  $EventResponseModelCopyWith<$Res>? get updateEvent;
}

/// @nodoc
class _$UpdateEventDataModelCopyWithImpl<$Res,
        $Val extends UpdateEventDataModel>
    implements $UpdateEventDataModelCopyWith<$Res> {
  _$UpdateEventDataModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updateEvent = freezed,
  }) {
    return _then(_value.copyWith(
      updateEvent: freezed == updateEvent
          ? _value.updateEvent
          : updateEvent // ignore: cast_nullable_to_non_nullable
              as EventResponseModel?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $EventResponseModelCopyWith<$Res>? get updateEvent {
    if (_value.updateEvent == null) {
      return null;
    }

    return $EventResponseModelCopyWith<$Res>(_value.updateEvent!, (value) {
      return _then(_value.copyWith(updateEvent: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$_UpdateEventDataModelCopyWith<$Res>
    implements $UpdateEventDataModelCopyWith<$Res> {
  factory _$$_UpdateEventDataModelCopyWith(_$_UpdateEventDataModel value,
          $Res Function(_$_UpdateEventDataModel) then) =
      __$$_UpdateEventDataModelCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({@JsonKey(name: 'updateEvent') EventResponseModel? updateEvent});

  @override
  $EventResponseModelCopyWith<$Res>? get updateEvent;
}

/// @nodoc
class __$$_UpdateEventDataModelCopyWithImpl<$Res>
    extends _$UpdateEventDataModelCopyWithImpl<$Res, _$_UpdateEventDataModel>
    implements _$$_UpdateEventDataModelCopyWith<$Res> {
  __$$_UpdateEventDataModelCopyWithImpl(_$_UpdateEventDataModel _value,
      $Res Function(_$_UpdateEventDataModel) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? updateEvent = freezed,
  }) {
    return _then(_$_UpdateEventDataModel(
      updateEvent: freezed == updateEvent
          ? _value.updateEvent
          : updateEvent // ignore: cast_nullable_to_non_nullable
              as EventResponseModel?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_UpdateEventDataModel implements _UpdateEventDataModel {
  const _$_UpdateEventDataModel(
      {@JsonKey(name: 'updateEvent') this.updateEvent});

  factory _$_UpdateEventDataModel.fromJson(Map<String, dynamic> json) =>
      _$$_UpdateEventDataModelFromJson(json);

  @override
  @JsonKey(name: 'updateEvent')
  final EventResponseModel? updateEvent;

  @override
  String toString() {
    return 'UpdateEventDataModel(updateEvent: $updateEvent)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$_UpdateEventDataModel &&
            (identical(other.updateEvent, updateEvent) ||
                other.updateEvent == updateEvent));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, updateEvent);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$_UpdateEventDataModelCopyWith<_$_UpdateEventDataModel> get copyWith =>
      __$$_UpdateEventDataModelCopyWithImpl<_$_UpdateEventDataModel>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UpdateEventDataModelToJson(
      this,
    );
  }
}

abstract class _UpdateEventDataModel implements UpdateEventDataModel {
  const factory _UpdateEventDataModel(
      {@JsonKey(name: 'updateEvent')
      final EventResponseModel? updateEvent}) = _$_UpdateEventDataModel;

  factory _UpdateEventDataModel.fromJson(Map<String, dynamic> json) =
      _$_UpdateEventDataModel.fromJson;

  @override
  @JsonKey(name: 'updateEvent')
  EventResponseModel? get updateEvent;
  @override
  @JsonKey(ignore: true)
  _$$_UpdateEventDataModelCopyWith<_$_UpdateEventDataModel> get copyWith =>
      throw _privateConstructorUsedError;
}
