import 'package:dartz/dartz.dart';
import 'package:tvshow/domain/repositories/auth_repositories.dart';

import '../../shared/shared.dart';

class SetsessionID {
  final AuthRepositories _repositories;
  SetsessionID(this._repositories);

  Future<Either<Failure, void>> execute(String sessionID) async {
    return _repositories.setSessionID(sessionID);
  }
}

class CreateSessionID {
  final AuthRepositories _repositories;
  CreateSessionID(this._repositories);

  Future<Either<Failure, String>> execute(String requestToken) async {
    return _repositories.createSessionID(requestToken);
  }
}

class GetSessionID {
  final AuthRepositories _repositories;
  GetSessionID(this._repositories);

  Future<Either<Failure, String?>> execute() async {
    return _repositories.getSessionID();
  }
}

class RequestToken {
  final AuthRepositories _repositories;
  RequestToken(this._repositories);

  Future<Either<Failure, String>> execute(
      String username, String password) async {
    return _repositories.requestToken(username, password);
  }
}
