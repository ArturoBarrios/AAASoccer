import 'failure.dart';

/// ServerFailure.
class ServerFailure extends Failure {
  /// ServerFailure.

  const ServerFailure({
    required String message,
    this.statusCode,
  }) : super(message: message);

  /// Status code.
  final int? statusCode;
}
