import 'package:tvshow/config/constant_app.dart';
import 'package:tvshow/data/datasource/local/auth_pref_DS.dart';
import 'package:tvshow/data/models/detail_model.dart';
import 'package:tvshow/data/models/movie_models.dart';
import 'package:tvshow/shared/shared.dart';

abstract class HomeRemoteDS {
  Future<List<MovieModel>> getTrendingHome();
  Future<List<MovieModel>> searchCollection(String query);
  Future<List<MovieModel>> tvPopular(int page);
  Future<DetailModel> detailTv(dynamic id);
  Future<void> deleteSession();
  Future<void> addWatchList(MovieModel model, bool watchList);
}

class HomeRemoteDSImpl extends HomeRemoteDS {
  final ApiHelper _api;
  final AuthPreferencseDS _authPreferencseDS;
  HomeRemoteDSImpl(
    this._api,
    this._authPreferencseDS,
  );

  @override
  Future<List<MovieModel>> getTrendingHome() async {
    var queryParams = {
      'api_key': ConstantApp.key,
      'language': 'id',
    };
    var r = await _api.request(
      "GET",
      ApiPath.trendingHome,
      contentType: ContentType.json,
      queryParams: queryParams,
    );

    return List.from(r.data['results'])
        .map((e) => MovieModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<MovieModel>> searchCollection(String query) async {
    var queryParams = {
      'api_key': ConstantApp.key,
      'language': 'id',
      'query': query
    };
    var r = await _api.request(
      "GET",
      ApiPath.search,
      contentType: ContentType.json,
      queryParams: queryParams,
    );

    return List.from(r.data['results'])
        .map((e) => MovieModel.fromJson(e))
        .toList();
  }

  @override
  Future<List<MovieModel>> tvPopular(int page) async {
    var queryParams = {
      'api_key': ConstantApp.key,
      'language': 'id',
      'page': page
    };
    var r = await _api.request(
      "GET",
      ApiPath.tvPopular,
      contentType: ContentType.json,
      queryParams: queryParams,
    );

    return List.from(r.data['results'])
        .map((e) => MovieModel.fromJson(e))
        .toList();
  }

  @override
  Future<DetailModel> detailTv(dynamic id) async {
    var queryParams = {
      'api_key': ConstantApp.key,
      'language': 'id',
    };
    var r = await _api.request(
      "GET",
      ApiPath.detailTv + '$id',
      contentType: ContentType.json,
      queryParams: queryParams,
    );
    return DetailModel.fromJson(r.data);
  }

  @override
  Future<void> addWatchList(MovieModel model, bool watchList) async {
    var content = {
      'media_type': model.mediaType,
      'media_id': model.id,
      'watchlist': watchList,
    };
    var _sessionID = await _authPreferencseDS.getSessionID();
    var _accountModel = await _authPreferencseDS.getUserModel();
    var r = await _api.request(
      "POST",
      '/account/${_accountModel?.id}/watchlist?api_key=${ConstantApp.key}&session_id=$_sessionID',
      contentType: ContentType.json,
      content: content,
    );
  }

  @override
  Future<void> deleteSession() async {
    var sessionId = await _authPreferencseDS.getSessionID();

    var content = {
      'session_id': sessionId,
    };
    var _query = {'api_key': ConstantApp.key};

    await _api.request(
      "DELETE",
      ApiPath.authenticationSession,
      contentType: ContentType.json,
      content: content,
      queryParams: _query,
    );
    await _authPreferencseDS.deleteSession();
  }
}
