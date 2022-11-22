import 'package:tvshow/config/constant_app.dart';
import 'package:tvshow/data/models/movie_models.dart';
import 'package:tvshow/shared/shared.dart';

abstract class HomeRemoteDS {
  Future<List<MovieModel>> getTrendingHome();
  Future<List<MovieModel>> searchCollection(String query);
}

class HomeRemoteDSImpl extends HomeRemoteDS {
  final ApiHelper _api;
  HomeRemoteDSImpl(this._api);

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
}
