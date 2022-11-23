import 'package:dartz/dartz.dart';

import '../../shared/shared.dart';

abstract class AuthRepositories {
  Future<Either<Failure, String>> requestToken(
      String username, String password);
  Future<Either<Failure, String>> createSessionID(String requestToken);
  Future<Either<Failure, void>> setSessionID(String sessionID);
  Future<Either<Failure, String?>> getSessionID();
}
