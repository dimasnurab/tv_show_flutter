import 'package:dio/dio.dart';
import 'package:tvshow/data/datasource/local/auth_pref_DS.dart';
import 'package:tvshow/data/datasource/remote/auth_remote_DS.dart';
import 'package:dartz/dartz.dart';
import 'package:tvshow/domain/repositories/auth_repositories.dart';

import '../../shared/shared.dart';

class AuthRepositoriesImpl extends AuthRepositories {
  final AuthPreferencseDS _localAuth;
  final AuthRemoteDS _remoteDS;
  AuthRepositoriesImpl(
    this._localAuth,
    this._remoteDS,
  );

  @override
  Future<Either<Failure, String>> requestToken(
      String username, String password) async {
    try {
      var _r = await _remoteDS.requestToken(username, password);
      return Right(_r);
    } on DioError catch (e) {
      return Left(ConnectionFailure(message: errorDioState(e)));
    } catch (e) {
      return Left(ConnectionFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String>> createSessionID(String requestToken) async {
    try {
      var _r = await _remoteDS.createSession(requestToken);
      return Right(_r);
    } on DioError catch (e) {
      return Left(ConnectionFailure(message: errorDioState(e)));
    } catch (e) {
      return Left(ConnectionFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> setSessionID(String sessionID) async {
    try {
      var _r = await _localAuth.setSessionID(sessionID);
      return Right(_r);
    } catch (e) {
      return Left(ConnectionFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, String?>> getSessionID() async {
    try {
      var _r = await _localAuth.getSessionID();
      return Right(_r);
    } catch (e) {
      return Left(ConnectionFailure(message: e.toString()));
    }
  }
}
