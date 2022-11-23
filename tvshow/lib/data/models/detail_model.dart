class DetailModel {
  final dynamic adult;
  final dynamic backDropPath;
  final List<dynamic> episodeRunTime;
  final dynamic firstAirDate;
  final dynamic homePage;
  final dynamic id;
  final dynamic onGoing;
  final List<dynamic> lang;
  final dynamic lastAirDate;
  final List<SeasonsDetail> seasons;
  final List<ProductionCompanies> productionCompanies;
  final dynamic posterPath;
  final dynamic type;
  final dynamic count;
  final dynamic average;
  final dynamic tagline;
  final List<Genres> genre;
  final dynamic name;
  final dynamic originalName;
  final dynamic overview;

  DetailModel({
    this.adult,
    this.average,
    this.backDropPath,
    this.count,
    this.episodeRunTime = const [],
    this.firstAirDate,
    this.homePage,
    this.id,
    this.lang = const [],
    this.lastAirDate,
    this.onGoing,
    this.posterPath,
    this.productionCompanies = const [],
    this.seasons = const [],
    this.tagline,
    this.genre = const [],
    this.type,
    this.name,
    this.originalName,
    this.overview,
  });

  factory DetailModel.fromJson(Map<String, dynamic> json) => DetailModel(
        originalName: json['originalName'] ?? null,
        firstAirDate: json['first_air_date'] ?? null,
        overview: json['overview'] ?? null,
        posterPath: json['poster_path'] ?? null,
        adult: json['adult'] ?? null,
        backDropPath: json['backdrop_path'] ?? null,
        episodeRunTime: json['episode_run_time'] != null
            ? List.from(json['episode_run_time'])
                .map(
                  (e) => e as dynamic,
                )
                .toList()
            : [],
        genre: json['genres'] != null
            ? List.from(json['genres'])
                .map(
                  (e) => Genres.fromJson(e),
                )
                .toList()
            : [],
        homePage: json['homepage'] ?? null,
        onGoing: json['in_production'] ?? null,
        id: json['id'] ?? null,
        lang: json['languages'] != null
            ? List.from(json['languages'])
                .map(
                  (e) => e as String,
                )
                .toList()
            : [],
        lastAirDate: json['last_air_date'] ?? null,
        tagline: json['tagline'] ?? null,
        type: json['type'] ?? null,
        name: json['name'] ?? null,
        average: json['vote_average'] ?? null,
        count: json['vote_count'] ?? null,
        productionCompanies: json['production_companies'] != null
            ? List.from(json['production_companies'])
                .map((e) => ProductionCompanies.fromJson(e))
                .toList()
            : [],
        seasons: json['seasons'] != null
            ? List.from(json['seasons'])
                .map((e) => SeasonsDetail.fromJson(e))
                .toList()
            : [],
      );
}

class Genres {
  final dynamic id;
  final dynamic name;
  Genres({this.id, this.name});

  factory Genres.fromJson(Map<String, dynamic> json) => Genres(
        id: json['id'] ?? null,
        name: json['name'] ?? null,
      );
}

class SeasonsDetail {
  final dynamic airDate;
  final dynamic episodeCount;
  final dynamic id;
  final dynamic name;
  final dynamic posterPath;
  final dynamic seasonNumber;
  final dynamic overview;

  SeasonsDetail({
    this.airDate,
    this.episodeCount,
    this.id,
    this.name,
    this.posterPath,
    this.seasonNumber,
    this.overview,
  });

  factory SeasonsDetail.fromJson(Map<String, dynamic> json) => SeasonsDetail(
        airDate: json['air_date'] ?? null,
        episodeCount: json['episode_count'] ?? null,
        id: json['id'] ?? null,
        name: json['name'] ?? null,
        overview: json['overview'] ?? null,
        posterPath: json['poster_path'],
        seasonNumber: json['season_number'],
      );
}

class ProductionCompanies {
  final dynamic id;
  final dynamic logoPath;
  final dynamic name;
  final dynamic originCountry;

  ProductionCompanies({this.id, this.logoPath, this.name, this.originCountry});

  factory ProductionCompanies.fromJson(Map<String, dynamic> json) =>
      ProductionCompanies(
        id: json['id'] ?? null,
        logoPath: json['logo_path'] ?? null,
        name: json['name'] ?? null,
        originCountry: json['origin_country'] ?? null,
      );
}
