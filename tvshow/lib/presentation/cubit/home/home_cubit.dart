import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvshow/data/models/movie_models.dart';
import 'package:tvshow/domain/usecase/home_usecase.dart';

part 'home_state.dart';

class HomeCubit extends Cubit<HomeState> {
  SearchMovie _searchMovie;
  HomeCubit(
    this._searchMovie,
  ) : super(HomeState());

  changeIsModeSearch(bool val) => emit(state.copyWith(
      refreshObject: !state.refreshObject,
      isModeSearch: val,
      models: !val ? [] : state.models));

  changeContentModeSearch(bool val) => emit(state.copyWith(
        refreshObject: !state.refreshObject,
        contentModeSearch: val,
        models: !val ? [] : state.models,
      ));

  searchMovie(String query) async {
    emit(state.copyWith(statusState: HomeStatusState.loading));
    var r = await _searchMovie.execute(query);
    r.fold((l) {
      emit(state.copyWith(statusState: HomeStatusState.fail));
    }, (r) {
      emit(state.copyWith(
        statusState: HomeStatusState.done,
        models: r,
      ));
    });
  }
}
