import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvshow/data/models/movie_models.dart';
import 'package:tvshow/domain/usecase/home_usecase.dart';

part 'trendinghome_state.dart';

class TrendinghomeCubit extends Cubit<TrendinghomeState> {
  final GetTrendingHomeCase _trendingHomeCase;
  TrendinghomeCubit(
    this._trendingHomeCase,
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
}
