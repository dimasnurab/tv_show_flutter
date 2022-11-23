import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvshow/data/models/movie_models.dart';
import 'package:tvshow/domain/usecase/home_usecase.dart';

part 'trendinghome_state.dart';

class TrendinghomeCubit extends Cubit<TrendinghomeState> {
  final GetTrendingHomeCase _trendingHomeCase;
  final AddWatchList _addWatchList;

  TrendinghomeCubit(
    this._trendingHomeCase,
    this._addWatchList,
  ) : super(TrendinghomeState());

  void initialTrending() async {
    emit(state.copyWith(statusState: TrendingHomeStatusState.loading));
    var r = await _trendingHomeCase.execute();

    r.fold((l) {
      emit(state.copyWith(statusState: TrendingHomeStatusState.fail));
    }, (r) {
      emit(state.copyWith(
          statusState: TrendingHomeStatusState.initial, models: r));
    });
  }

  void changeIndex(int index) => emit(state.copyWith(
        currentIndex: index,
        refreshObject: !state.refreshObject,
      ));

  void addWathcList(MovieModel model, bool watchList) async {
    emit(state.copyWith(statusState: TrendingHomeStatusState.loadingWatchList));

    var _models = <MovieModel>[];
    for (var i in state.models) {
      _models.add(i);
    }
    var r = await _addWatchList.execute(model, watchList);
    r.fold(
      (l) {
        emit(state.copyWith(statusState: TrendingHomeStatusState.fail));
      },
      (r) {
        _models[_models.indexOf(model)].watchList = watchList;
        emit(state.copyWith(
            models: _models,
            refreshObject: !state.refreshObject,
            statusState: TrendingHomeStatusState.initial));
      },
    );
  }
}
