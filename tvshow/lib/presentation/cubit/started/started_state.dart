part of 'started_cubit.dart';

enum SessionUser { unknown, home }

abstract class StartedState extends Equatable {
  @override
  List<Object?> get props => [];
}

class StartedHome extends StartedState {}

class StartedUnknown extends StartedState {}
