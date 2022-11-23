import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:tvshow/data/models/user_model.dart';

abstract class AuthPreferencseDS {
  Future<void> setSessionID(String sessionID);
  Future<String?> getSessionID();
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
}
