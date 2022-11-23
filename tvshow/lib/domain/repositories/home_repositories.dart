import 'package:tvshow/data/models/detail_model.dart';

import '../../data/models/movie_models.dart';
import '../../shared/shared.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepositories {
  Future<Either<Failure, List<MovieModel>>> getTrending();
  Future<Either<Failure, List<MovieModel>>> searchQuery(String query);
  Future<Either<Failure, List<MovieModel>>> tvPopular(int page);
  Future<Either<Failure, DetailModel>> detailTv(dynamic id);
}
