import 'package:dartz/dartz.dart';
import 'package:tvshow/data/models/detail_model.dart';
import 'package:tvshow/domain/repositories/home_repositories.dart';

import '../../data/models/movie_models.dart';
import '../../shared/shared.dart';

class GetTrendingHomeCase {
  final HomeRepositories _repo;
  GetTrendingHomeCase(this._repo);

  Future<Either<Failure, List<MovieModel>>> execute() async {
    return _repo.getTrending();
  }
}

class SearchMovie {
  final HomeRepositories _repo;
  SearchMovie(this._repo);

  Future<Either<Failure, List<MovieModel>>> execute(String query) async {
    return _repo.searchQuery(query);
  }
}

class GetTvPopular {
  final HomeRepositories _repo;
  GetTvPopular(this._repo);

  Future<Either<Failure, List<MovieModel>>> execute(int page) async {
    return _repo.tvPopular(page);
  }
}

class GetDetailTv {
  final HomeRepositories _repo;
  GetDetailTv(this._repo);

  Future<Either<Failure, DetailModel>> execute(dynamic id) async {
    return _repo.detailTv(id);
  }
}
