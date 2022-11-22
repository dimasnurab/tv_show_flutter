part of 'home_cubit.dart';

enum HomeStatusState { done, fail, loading, initial }

class HomeState extends Equatable {
  HomeState({
    this.refreshObject = false,
    this.contentModeSearch = false,
    this.isModeSearch = false,
    this.statusState = HomeStatusState.initial,
    this.models = const [],
  });
  final bool refreshObject;
  final bool isModeSearch;
  final bool contentModeSearch;
  final HomeStatusState statusState;
  final List<MovieModel> models;

  HomeState copyWith(
          {bool? refreshObject,
          bool? isModeSearch,
          List<MovieModel>? models,
          bool? contentModeSearch,
          HomeStatusState? statusState}) =>
      HomeState(
        refreshObject: refreshObject ?? this.refreshObject,
        isModeSearch: isModeSearch ?? this.isModeSearch,
        contentModeSearch: contentModeSearch ?? this.contentModeSearch,
        statusState: statusState ?? this.statusState,
        models: models ?? this.models,
      );

  @override
  List<Object> get props => [
        refreshObject,
        isModeSearch,
        contentModeSearch,
        statusState,
        models,
      ];
}
