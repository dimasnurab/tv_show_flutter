import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'started_state.dart';

class StartedCubit extends Cubit<StartedState> {
  StartedCubit() : super(StartedUnknown());

  void changeSession(SessionUser event) async {
    switch (event) {
      case SessionUser.home:
        emit(StartedHome());
        break;
      default:
        emit(StartedUnknown());
    }
  }
}
