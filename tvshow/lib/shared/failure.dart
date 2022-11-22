import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String message;

  Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class ServerFailure extends Failure {
  ServerFailure({String? message, int? httpStatus, final String? responseCode})
      : super(
          message: message ?? "Server Failure",
        );
}

class ConnectionFailure extends Failure {
  final int? httpStatus;
  final String? responseCode;

  ConnectionFailure({String? message, this.httpStatus, this.responseCode})
      : super(message: message ?? "Connection Failure");
}

class DatabaseFailure extends Failure {
  DatabaseFailure({String message = "Database Failure"})
      : super(message: message);
}
