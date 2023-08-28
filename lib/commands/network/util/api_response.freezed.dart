// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$ApiResponse<T, U> {
  Object? get content => throw _privateConstructorUsedError;
  int? get statusCode => throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(T? content, int? statusCode, Map<String, String> headers,
            bool isRedirect, bool persistentConnection)
        $default, {
    required TResult Function(
            String message, bool isSocketException, U? content, int? statusCode)
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(T? content, int? statusCode, Map<String, String> headers,
            bool isRedirect, bool persistentConnection)?
        $default, {
    TResult? Function(String message, bool isSocketException, U? content,
            int? statusCode)?
        error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(T? content, int? statusCode, Map<String, String> headers,
            bool isRedirect, bool persistentConnection)?
        $default, {
    TResult Function(String message, bool isSocketException, U? content,
            int? statusCode)?
        error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(ApiResponseData<T, U> value) $default, {
    required TResult Function(ApiResponseError<T, U> value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(ApiResponseData<T, U> value)? $default, {
    TResult? Function(ApiResponseError<T, U> value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ApiResponseData<T, U> value)? $default, {
    TResult Function(ApiResponseError<T, U> value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;

  @JsonKey(ignore: true)
  $ApiResponseCopyWith<T, U, ApiResponse<T, U>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ApiResponseCopyWith<T, U, $Res> {
  factory $ApiResponseCopyWith(
          ApiResponse<T, U> value, $Res Function(ApiResponse<T, U>) then) =
      _$ApiResponseCopyWithImpl<T, U, $Res, ApiResponse<T, U>>;
  @useResult
  $Res call({int? statusCode});
}

/// @nodoc
class _$ApiResponseCopyWithImpl<T, U, $Res, $Val extends ApiResponse<T, U>>
    implements $ApiResponseCopyWith<T, U, $Res> {
  _$ApiResponseCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? statusCode = freezed,
  }) {
    return _then(_value.copyWith(
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ApiResponseDataCopyWith<T, U, $Res>
    implements $ApiResponseCopyWith<T, U, $Res> {
  factory _$$ApiResponseDataCopyWith(_$ApiResponseData<T, U> value,
          $Res Function(_$ApiResponseData<T, U>) then) =
      __$$ApiResponseDataCopyWithImpl<T, U, $Res>;
  @override
  @useResult
  $Res call(
      {T? content,
      int? statusCode,
      Map<String, String> headers,
      bool isRedirect,
      bool persistentConnection});
}

/// @nodoc
class __$$ApiResponseDataCopyWithImpl<T, U, $Res>
    extends _$ApiResponseCopyWithImpl<T, U, $Res, _$ApiResponseData<T, U>>
    implements _$$ApiResponseDataCopyWith<T, U, $Res> {
  __$$ApiResponseDataCopyWithImpl(_$ApiResponseData<T, U> _value,
      $Res Function(_$ApiResponseData<T, U>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? content = freezed,
    Object? statusCode = freezed,
    Object? headers = null,
    Object? isRedirect = null,
    Object? persistentConnection = null,
  }) {
    return _then(_$ApiResponseData<T, U>(
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as T?,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
      headers: null == headers
          ? _value._headers
          : headers // ignore: cast_nullable_to_non_nullable
              as Map<String, String>,
      isRedirect: null == isRedirect
          ? _value.isRedirect
          : isRedirect // ignore: cast_nullable_to_non_nullable
              as bool,
      persistentConnection: null == persistentConnection
          ? _value.persistentConnection
          : persistentConnection // ignore: cast_nullable_to_non_nullable
              as bool,
    ));
  }
}

/// @nodoc

class _$ApiResponseData<T, U> implements ApiResponseData<T, U> {
  const _$ApiResponseData(
      {required this.content,
      required this.statusCode,
      required final Map<String, String> headers,
      required this.isRedirect,
      required this.persistentConnection})
      : _headers = headers;

  @override
  final T? content;
  @override
  final int? statusCode;
  final Map<String, String> _headers;
  @override
  Map<String, String> get headers {
    if (_headers is EqualUnmodifiableMapView) return _headers;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(_headers);
  }

  @override
  final bool isRedirect;
  @override
  final bool persistentConnection;

  @override
  String toString() {
    return 'ApiResponse<$T, $U>(content: $content, statusCode: $statusCode, headers: $headers, isRedirect: $isRedirect, persistentConnection: $persistentConnection)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseData<T, U> &&
            const DeepCollectionEquality().equals(other.content, content) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode) &&
            const DeepCollectionEquality().equals(other._headers, _headers) &&
            (identical(other.isRedirect, isRedirect) ||
                other.isRedirect == isRedirect) &&
            (identical(other.persistentConnection, persistentConnection) ||
                other.persistentConnection == persistentConnection));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(content),
      statusCode,
      const DeepCollectionEquality().hash(_headers),
      isRedirect,
      persistentConnection);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseDataCopyWith<T, U, _$ApiResponseData<T, U>> get copyWith =>
      __$$ApiResponseDataCopyWithImpl<T, U, _$ApiResponseData<T, U>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(T? content, int? statusCode, Map<String, String> headers,
            bool isRedirect, bool persistentConnection)
        $default, {
    required TResult Function(
            String message, bool isSocketException, U? content, int? statusCode)
        error,
  }) {
    return $default(
        content, statusCode, headers, isRedirect, persistentConnection);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(T? content, int? statusCode, Map<String, String> headers,
            bool isRedirect, bool persistentConnection)?
        $default, {
    TResult? Function(String message, bool isSocketException, U? content,
            int? statusCode)?
        error,
  }) {
    return $default?.call(
        content, statusCode, headers, isRedirect, persistentConnection);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(T? content, int? statusCode, Map<String, String> headers,
            bool isRedirect, bool persistentConnection)?
        $default, {
    TResult Function(String message, bool isSocketException, U? content,
            int? statusCode)?
        error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(
          content, statusCode, headers, isRedirect, persistentConnection);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(ApiResponseData<T, U> value) $default, {
    required TResult Function(ApiResponseError<T, U> value) error,
  }) {
    return $default(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(ApiResponseData<T, U> value)? $default, {
    TResult? Function(ApiResponseError<T, U> value)? error,
  }) {
    return $default?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ApiResponseData<T, U> value)? $default, {
    TResult Function(ApiResponseError<T, U> value)? error,
    required TResult orElse(),
  }) {
    if ($default != null) {
      return $default(this);
    }
    return orElse();
  }
}

abstract class ApiResponseData<T, U> implements ApiResponse<T, U> {
  const factory ApiResponseData(
      {required final T? content,
      required final int? statusCode,
      required final Map<String, String> headers,
      required final bool isRedirect,
      required final bool persistentConnection}) = _$ApiResponseData<T, U>;

  @override
  T? get content;
  @override
  int? get statusCode;
  Map<String, String> get headers;
  bool get isRedirect;
  bool get persistentConnection;
  @override
  @JsonKey(ignore: true)
  _$$ApiResponseDataCopyWith<T, U, _$ApiResponseData<T, U>> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$ApiResponseErrorCopyWith<T, U, $Res>
    implements $ApiResponseCopyWith<T, U, $Res> {
  factory _$$ApiResponseErrorCopyWith(_$ApiResponseError<T, U> value,
          $Res Function(_$ApiResponseError<T, U>) then) =
      __$$ApiResponseErrorCopyWithImpl<T, U, $Res>;
  @override
  @useResult
  $Res call(
      {String message, bool isSocketException, U? content, int? statusCode});
}

/// @nodoc
class __$$ApiResponseErrorCopyWithImpl<T, U, $Res>
    extends _$ApiResponseCopyWithImpl<T, U, $Res, _$ApiResponseError<T, U>>
    implements _$$ApiResponseErrorCopyWith<T, U, $Res> {
  __$$ApiResponseErrorCopyWithImpl(_$ApiResponseError<T, U> _value,
      $Res Function(_$ApiResponseError<T, U>) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
    Object? isSocketException = null,
    Object? content = freezed,
    Object? statusCode = freezed,
  }) {
    return _then(_$ApiResponseError<T, U>(
      message: null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
      isSocketException: null == isSocketException
          ? _value.isSocketException
          : isSocketException // ignore: cast_nullable_to_non_nullable
              as bool,
      content: freezed == content
          ? _value.content
          : content // ignore: cast_nullable_to_non_nullable
              as U?,
      statusCode: freezed == statusCode
          ? _value.statusCode
          : statusCode // ignore: cast_nullable_to_non_nullable
              as int?,
    ));
  }
}

/// @nodoc

class _$ApiResponseError<T, U> implements ApiResponseError<T, U> {
  const _$ApiResponseError(
      {required this.message,
      required this.isSocketException,
      this.content,
      this.statusCode});

  @override
  final String message;
  @override
  final bool isSocketException;
  @override
  final U? content;
  @override
  final int? statusCode;

  @override
  String toString() {
    return 'ApiResponse<$T, $U>.error(message: $message, isSocketException: $isSocketException, content: $content, statusCode: $statusCode)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ApiResponseError<T, U> &&
            (identical(other.message, message) || other.message == message) &&
            (identical(other.isSocketException, isSocketException) ||
                other.isSocketException == isSocketException) &&
            const DeepCollectionEquality().equals(other.content, content) &&
            (identical(other.statusCode, statusCode) ||
                other.statusCode == statusCode));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message, isSocketException,
      const DeepCollectionEquality().hash(content), statusCode);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$ApiResponseErrorCopyWith<T, U, _$ApiResponseError<T, U>> get copyWith =>
      __$$ApiResponseErrorCopyWithImpl<T, U, _$ApiResponseError<T, U>>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>(
    TResult Function(T? content, int? statusCode, Map<String, String> headers,
            bool isRedirect, bool persistentConnection)
        $default, {
    required TResult Function(
            String message, bool isSocketException, U? content, int? statusCode)
        error,
  }) {
    return error(message, isSocketException, content, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>(
    TResult? Function(T? content, int? statusCode, Map<String, String> headers,
            bool isRedirect, bool persistentConnection)?
        $default, {
    TResult? Function(String message, bool isSocketException, U? content,
            int? statusCode)?
        error,
  }) {
    return error?.call(message, isSocketException, content, statusCode);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>(
    TResult Function(T? content, int? statusCode, Map<String, String> headers,
            bool isRedirect, bool persistentConnection)?
        $default, {
    TResult Function(String message, bool isSocketException, U? content,
            int? statusCode)?
        error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message, isSocketException, content, statusCode);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>(
    TResult Function(ApiResponseData<T, U> value) $default, {
    required TResult Function(ApiResponseError<T, U> value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>(
    TResult? Function(ApiResponseData<T, U> value)? $default, {
    TResult? Function(ApiResponseError<T, U> value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>(
    TResult Function(ApiResponseData<T, U> value)? $default, {
    TResult Function(ApiResponseError<T, U> value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class ApiResponseError<T, U> implements ApiResponse<T, U> {
  const factory ApiResponseError(
      {required final String message,
      required final bool isSocketException,
      final U? content,
      final int? statusCode}) = _$ApiResponseError<T, U>;

  String get message;
  bool get isSocketException;
  @override
  U? get content;
  @override
  int? get statusCode;
  @override
  @JsonKey(ignore: true)
  _$$ApiResponseErrorCopyWith<T, U, _$ApiResponseError<T, U>> get copyWith =>
      throw _privateConstructorUsedError;
}
