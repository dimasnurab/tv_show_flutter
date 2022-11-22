part of 'trendinghome_cubit.dart';

enum TrendingHomeStatusState { done, loading, fail, initial }

class TrendinghomeState extends Equatable {
  const TrendinghomeState({
    this.models = const [],
    this.statusState = TrendingHomeStatusState.initial,
    this.currentIndex = 0,
    this.refreshObject = false,
  });

  final TrendingHomeStatusState statusState;
  final List<MovieModel> models;
  final int currentIndex;
  final bool refreshObject;
  TrendinghomeState copyWith({
    TrendingHomeStatusState? statusState,
    List<MovieModel>? models,
    int? currentIndex,
    bool? refreshObject,
  }) =>
      TrendinghomeState(
        statusState: statusState ?? this.statusState,
        models: models ?? this.models,
        currentIndex: currentIndex ?? this.currentIndex,
        refreshObject: refreshObject ?? this.refreshObject,
      );

  @override
  List<Object> get props => [
        refreshObject,
        statusState,
        models,
        refreshObject,
      ];
}
