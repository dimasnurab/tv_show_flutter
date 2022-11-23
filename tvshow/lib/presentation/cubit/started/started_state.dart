part of 'started_cubit.dart';

enum SessionUser { unknown, home }

abstract class StartedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartedHome extends StartedState {
  final String? sessionID;
  StartedHome({this.sessionID});
  @override
  List<Object?> get props => [sessionID];
}

class StartedUnknown extends StartedState {}
