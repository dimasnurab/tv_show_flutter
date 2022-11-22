import 'package:dartz/dartz.dart';
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
