import 'package:ht_movie/call_api/models/genre_model.dart';
import 'cast_model.dart';

class MovieModel {
  final String id;
  final String title;
  final String overview;
  final String posterUrl;
  final String? backdropUrl;
  final String releaseDate;
  final int runtime;
  final bool isAdult;
  final double popularity;
  final String status;
  final List<CastModel> cast;
  final List<GenreModel> genres;
  final double voteAverage;
  final int voteCount;
  final double tmdbVoteAverage;
  final int tmdbVoteCount;

  MovieModel({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterUrl,
    this.backdropUrl,
    required this.releaseDate,
    required this.runtime,
    required this.isAdult,
    required this.popularity,
    required this.status,
    required this.cast,
    required this.genres,
    required this.voteAverage,
    required this.voteCount,
    required this.tmdbVoteAverage,
    required this.tmdbVoteCount,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id: json['id'],
      title: json['title'] ?? '',
      overview: json['overview'] ?? '',
      posterUrl: json['posterUrl'] ?? '',
      backdropUrl: json['backdropUrl'] ?? '',
      releaseDate: json['releaseDate'] ?? '',
      runtime: json['runtime'] ?? 0,
      isAdult: json['isAdult'] ?? false,
      popularity: (json['popularity'] as num?)?.toDouble() ?? 0.0,
      status: json['status'] ?? '',
      cast:
          (json['movieCasts'] as List<dynamic>? ?? [])
              .map((e) => CastModel.fromJson(e['cast'] as Map<String, dynamic>))
              .toList(),
      genres:
          (json['movieGenres'] as List<dynamic>? ?? [])
              .map(
                (e) => GenreModel.fromJson(e['genre'] as Map<String, dynamic>),
              )
              .toList(),
      voteAverage: (json['voteAverage'] as num?)?.toDouble() ?? 0.0,
      voteCount: json['voteCount'] ?? 0,
      tmdbVoteAverage: (json['tmdbvoteAverage'] as num?)?.toDouble() ?? 0.0,
      tmdbVoteCount: json['tmdbvoteCount'] ?? 0,
    );
  }
}
