import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvshow/data/models/movie_models.dart';
import 'package:tvshow/domain/usecase/home_usecase.dart';

part 'tvpopular_state.dart';

class TvpopularCubit extends Cubit<TvpopularState> {
  GetTvPopular _getTvPopular;
  TvpopularCubit(this._getTvPopular) : super(TvpopularState());

  getInitialData() async {
    emit(state.copyWith(statusState: TvPopularStatusState.loading));
    var r = await _getTvPopular.execute(1);

    r.fold((l) {
      emit(state.copyWith(statusState: TvPopularStatusState.fail));
    }, (r) {
      emit(state.copyWith(
        statusState: TvPopularStatusState.initial,
        models: r,
      ));
    });
  }

  infinitLoaded() async {
    emit(state.copyWith(statusState: TvPopularStatusState.loading));
    var r = await _getTvPopular.execute(state.models.length);

    r.fold((l) {
      emit(state.copyWith(statusState: TvPopularStatusState.fail));
    }, (r) {
      emit(state.copyWith(
        statusState: TvPopularStatusState.initial,
        models: state.models + r,
      ));
    });
  }
}
