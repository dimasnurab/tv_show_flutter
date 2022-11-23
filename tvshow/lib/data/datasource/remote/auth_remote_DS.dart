import 'package:tvshow/data/datasource/local/auth_pref_DS.dart';
import 'package:tvshow/data/models/user_model.dart';
import 'package:tvshow/shared/shared.dart';

import '../../../config/config.dart';

abstract class AuthRemoteDS {
  Future<String> requestToken(String username, String password);
  Future<String> createSession(String requestToken);
}

class AuthRemoteDSImpl extends AuthRemoteDS {
  final ApiHelper _api;
  final AuthPreferencseDS _authPreferencseDS;
  AuthRemoteDSImpl(
    this._api,
    this._authPreferencseDS,
  );

  @override
  Future<String> requestToken(String username, String password) async {
    var queryParams = {
      'api_key': ConstantApp.key,
    };

    // request token
    var r = await _api.request(
      "GET",
      ApiPath.requestToken,
      contentType: ContentType.json,
      queryParams: queryParams,
    );
    var _model = UserModel.fromJson(r.data);
    return _model.requestToken;
  }

  @override
  Future<String> createSession(String requestToken) async {
    var content = {
      'request_token': requestToken,
    };

    // request token
    var r = await _api.request(
      "POST",
      ApiPath.createSession + '?api_key=${ConstantApp.key}',
      contentType: ContentType.json,
      content: content,
    );

    var _query = {
      'api_key': ConstantApp.key,
      'session_id': r.data['session_id']
    };

    var account = await _api.request(
      'GET',
      ApiPath.account,
      contentType: ContentType.json,
      queryParams: _query,
    );

    var _accountModel = AccountModel.fromJson(account.data);
    await _authPreferencseDS.setAccountModel(_accountModel);

    return r.data['session_id'];
  }
}
