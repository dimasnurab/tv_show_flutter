import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvshow/data/models/user_model.dart';

abstract class AuthPreferencseDS {
  Future<void> setSessionID(String sessionID);
  Future<AccountModel?> getUserModel();
  Future<String?> getSessionID();
  Future<void> deleteSession();
  Future<void> setAccountModel(AccountModel model);
}

class AuthPreferencesDSImpl extends AuthPreferencseDS {
  final SharedPreferences _preferences;
  AuthPreferencesDSImpl(this._preferences);

  @override
  Future<void> setSessionID(String sessionID) async =>
      await _preferences.setString('sessionID', sessionID);

  @override
  Future<String?> getSessionID() async {
    var r = await _preferences.getString('sessionID');
    return r;
  }

  @override
  Future<void> setAccountModel(AccountModel model) async =>
      await _preferences.setString(
        'account',
        jsonEncode(model.toJson()),
      );

  @override
  Future<AccountModel?> getUserModel() async {
    AccountModel? _model;

    var r = await _preferences.getString('account');
    if (r != null) {
      _model = AccountModel.fromDB(jsonDecode(r));
    }
    return _model;
  }

  @override
  Future<void> deleteSession() async => await _preferences.remove('sessionID');
}
