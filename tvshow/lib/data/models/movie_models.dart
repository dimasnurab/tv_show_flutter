class MovieModel {
  final dynamic adult;
  final dynamic backdropPath;
  final dynamic id;
  final dynamic title;
  final dynamic originalLang;
  final dynamic originalTitle;
  final dynamic overview;
  final dynamic pathPoster;
  final dynamic mediaType;
  final dynamic popularity;
  final dynamic releaseDate;
  final dynamic voteAverage;
  final dynamic voteCount;
  final dynamic firstAirDate;
  final List<String> originCountry;
  bool watchList;

  MovieModel({
    this.adult,
    this.backdropPath,
    this.id,
    this.mediaType,
    this.originalLang,
    this.originalTitle,
    this.overview,
    this.pathPoster,
    this.popularity,
    this.releaseDate,
    this.title,
    this.voteAverage,
    this.voteCount,
    this.firstAirDate,
    this.originCountry = const <String>[],
    this.watchList = false,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
        adult: json['adult'] ?? false,
        backdropPath: json['backdrop_path'] ?? null,
        id: json['id'] ?? null,
        title: json['title'] ?? json['name'] ?? null,
        originalLang: json['original_language'] ?? null,
        originalTitle: json['original_title'] ?? null,
        overview: json['overview'] ?? null,
        pathPoster: json['poster_path'],
        mediaType: json['media_type'] ?? null,
        popularity: json['popularity'] ?? null,
        releaseDate: json['release_date'] ?? null,
        voteAverage: json['vote_average'] ?? null,
        voteCount: json['vote_count'] ?? null,
        firstAirDate: json['first_air_date'] ?? null,
        originCountry: json['origin_country'] != null
            ? List.from(json['origin_country'])
                .map(
                  (e) => e as String,
                )
                .toList()
            : []);
  }
}
