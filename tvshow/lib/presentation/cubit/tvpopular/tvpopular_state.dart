part of 'tvpopular_cubit.dart';

enum TvPopularStatusState { done, fail, loading, initial }

class TvpopularState extends Equatable {
  TvpopularState({
    this.models = const [],
    this.statusState = TvPopularStatusState.initial,
  });
  final TvPopularStatusState statusState;
  final List<MovieModel> models;

  TvpopularState copyWith({
    TvPopularStatusState? statusState,
    List<MovieModel>? models,
  }) =>
      TvpopularState(
        statusState: statusState ?? this.statusState,
        models: models ?? this.models,
      );

  @override
  List<Object> get props => [
        models,
        statusState,
      ];
}
