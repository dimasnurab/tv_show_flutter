import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvshow/domain/usecase/auth_usecase.dart';

part 'started_state.dart';

class StartedCubit extends Cubit<StartedState> {
  final GetSessionID _getSessionID;
  StartedCubit(this._getSessionID) : super(StartedUnknown());

  void changeSession(SessionUser event) async {
    switch (event) {
      case SessionUser.home:
        var r = await _getSessionID.execute();
        r.fold((l) {
          print("GAGAl");
          emit(StartedHome(sessionID: null));
        }, (r) {
          print("SUCCESS :$r");

          emit(StartedHome(sessionID: r));
        });
        break;
      default:
        emit(StartedUnknown());
    }
  }
}
