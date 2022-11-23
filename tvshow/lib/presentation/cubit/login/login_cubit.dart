import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tvshow/data/models/user_model.dart';
import 'package:tvshow/domain/usecase/auth_usecase.dart';

part 'login_state.dart';

class LoginCubit extends Cubit<LoginState> {
  RequestToken _requestToken;
  CreateSessionID _createSessionID;
  SetsessionID _setsessionID;
  LoginCubit(
    this._requestToken,
    this._createSessionID,
    this._setsessionID,
  ) : super(LoginState());

  doLogin(String username, String password) async {
    emit(state.copyWith(statusState: LoginStatusState.loaded));

    var r = await _requestToken.execute(username, password);
    r.fold((l) {
      emit(state.copyWith(statusState: LoginStatusState.fail));
    }, (r) async {
      emit(state.copyWith(
        statusState: LoginStatusState.done,
        requestToken: r,
      ));
    });
  }

  createSession(String token) async {
    emit(state.copyWith(statusState: LoginStatusState.loaded));
    var r = await _createSessionID.execute(token);
    r.fold((l) {
      emit(state.copyWith(
        statusState: LoginStatusState.fail,
      ));
    }, (r) async {
      var result = await _setsessionID.execute(r);

      result.fold((l) {
        emit(state.copyWith(statusState: LoginStatusState.fail));
      }, (r) {
        emit(state.copyWith(
          statusState: LoginStatusState.setSessionDone,
        ));
      });
    });
  }
}
