import 'dart:async';

import '../types/either.dart';
import '../types/failure.dart';
import '../types/server_failure.dart';
import 'api_response.dart';

/// Map API Responses.
Future<Either<Failure, V>> mapApiResponse<T, U, V>({
  required final Future<ApiResponse<T, U>> request,
  required final FutureOr<Either<Failure, V>> Function(T?) mapData,
  final FutureOr<Either<Failure, V>> Function(U?)? mapFailure,
}) async =>
    (await request).when(
      (
        final content,
        final statusCode,
        final headers,
        final isRedirect,
        final persistentConnection,
      ) async =>
          await mapData(content),
      error: (
        final message,
        final isSocketException,
        final content,
        final statusCode,
      ) async =>
          mapFailure != null
              ? await mapFailure(content)
              : Left(ServerFailure(message: message, statusCode: statusCode)),
    );
