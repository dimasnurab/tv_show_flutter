import 'package:tvshow/data/models/user_model.dart';
import 'package:tvshow/shared/shared.dart';

import '../../../config/config.dart';

abstract class AuthRemoteDS {
  Future<String> requestToken(String username, String password);
  Future<String> createSession(String requestToken);
}

class AuthRemoteDSImpl extends AuthRemoteDS {
  final ApiHelper _api;
  AuthRemoteDSImpl(this._api);

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

    return r.data['session_id'];
  }
}
