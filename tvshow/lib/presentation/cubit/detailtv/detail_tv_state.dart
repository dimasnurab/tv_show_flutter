part of 'detail_tv_cubit.dart';

enum DetailTvStatusState {
  done,
  fail,
  loading,
  initial,
}

class DetailTvState extends Equatable {
  const DetailTvState({
    this.statusState = DetailTvStatusState.initial,
    required this.detailModel,
  });
  final DetailTvStatusState statusState;
  final DetailModel detailModel;

  DetailTvState copyWith({
    DetailTvStatusState? statusState,
    DetailModel? detailModel,
  }) =>
      DetailTvState(
        statusState: statusState ?? this.statusState,
        detailModel: detailModel ?? this.detailModel,
      );
  @override
  List<Object?> get props => [
        statusState,
        detailModel,
      ];
}
