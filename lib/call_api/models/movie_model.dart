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
    );
  }
}