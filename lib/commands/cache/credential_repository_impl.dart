// ignore_for_file: depend_on_referenced_packages

import 'dart:async';

import '../network/types/either.dart';
import '../network/types/failure.dart';
import '../network/types/storage_failure.dart';
import 'credential_data_source.dart';
import 'credential_repository.dart';
import 'package:rxdart/rxdart.dart';

class CredentialsRepositoryImpl implements CredentialsRepository {
  CredentialsRepositoryImpl({
    required final CredentialsDataSourceRepository remoteDataSource,
  }) : _remoteDataSource = remoteDataSource {
    unawaited(_initialize());
  }

  final CredentialsDataSourceRepository _remoteDataSource;

  final _accessTokenController = BehaviorSubject<String?>.seeded(null);
  final _accessTokenExpiresInStream = BehaviorSubject<int?>.seeded(null);

  Future<void> _initialize() async {
    final accessToken = await _remoteDataSource.paypalAccessToken;
    final accessTokenExpiresIn =
        await _remoteDataSource.paypalAccessTokenExpiresIn;

    _accessTokenController.add(accessToken);
    _accessTokenExpiresInStream.add(int.tryParse(accessTokenExpiresIn ?? ''));
  }

  @override
  Stream<String?> get paypalAccessToken => _accessTokenController.stream;

  @override
  Stream<int?> get paypalAccessTokenExpiresIn =>
      _accessTokenExpiresInStream.stream;

  @override
  String? get paypalAccessTokenValue => _accessTokenController.valueOrNull;

  @override
  int? get paypalAccessTokenExpiresInValue =>
      _accessTokenExpiresInStream.valueOrNull;

  @override
  Future<Either<Failure, void>> updatePaypalAccessToken(
      final String value) async {
    try {
      await _remoteDataSource.updatePaypalAccessToken(value);
    } on Exception catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }

    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> updatePaypalAccessTokenExpiresIn(
      final int value) async {
    try {
      await _remoteDataSource.updatePaypalAccessTokenExpiresIn(value);
    } on Exception catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }

    return const Right(null);
  }

  @override
  Future<Either<Failure, void>> get deleteAll async {
    try {
      await _remoteDataSource.deletePaypalAccessToken;
      await _remoteDataSource.deletePaypalAccessTokenExpiresIn;
    } on Exception catch (e) {
      return Left(StorageFailure(message: e.toString()));
    }

    return const Right(null);
  }

  void dispose() {
    _accessTokenController.close();
    _accessTokenExpiresInStream.close();
  }
}
