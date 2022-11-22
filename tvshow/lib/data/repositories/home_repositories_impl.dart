import 'package:dio/dio.dart';
import 'package:tvshow/data/datasource/remote/home_remote_DS.dart';
import 'package:tvshow/shared/error_diostate.dart';
import 'package:tvshow/shared/failure.dart';

import 'package:dartz/dartz.dart';

import '../../domain/repositories/home_repositories.dart';
import '../models/movie_models.dart';

class HomeRepositoriesImpl extends HomeRepositories {
  final HomeRemoteDS _remoteDS;

  HomeRepositoriesImpl(this._remoteDS);

  @override
  Future<Either<Failure, List<MovieModel>>> getTrending() async {
    try {
      var _r = await _remoteDS.getTrendingHome();
      return Right(_r);
    } on DioError catch (e) {
      return Left(ConnectionFailure(message: errorDioState(e)));
    } catch (e) {
      return Left(ConnectionFailure(message: e.toString()));
    }
  }

  @override
  Future<Either<Failure, List<MovieModel>>> searchQuery(String query) async {
    try {
      var _r = await _remoteDS.searchCollection(query);
      return Right(_r);
    } on DioError catch (e) {
      return Left(ConnectionFailure(message: errorDioState(e)));
    } catch (e) {
      return Left(ConnectionFailure(message: e.toString()));
    }
  }
}
