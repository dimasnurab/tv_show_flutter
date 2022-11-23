import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvshow/data/models/detail_model.dart';
import 'package:tvshow/domain/usecase/home_usecase.dart';

part 'detail_tv_state.dart';

class DetailTvCubit extends Cubit<DetailTvState> {
  GetDetailTv _detailTv;
  DetailTvCubit(
    this._detailTv,
  ) : super(DetailTvState(detailModel: DetailModel()));

  initialData(dynamic id) async {
    emit(state.copyWith(statusState: DetailTvStatusState.loading));
    var r = await _detailTv.execute(id);
    r.fold(
      (l) {
        emit(state.copyWith(statusState: DetailTvStatusState.fail));
      },
      (r) {
        emit(state.copyWith(
          statusState: DetailTvStatusState.initial,
          detailModel: r,
        ));
      },
    );
  }
}
