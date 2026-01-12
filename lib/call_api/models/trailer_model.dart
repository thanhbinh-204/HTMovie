class TrailerModel {
  final String id;
  final String movieId;
  final String title;
  final String youtubeUrl;
  final DateTime createdAt;
  final DateTime updatedAt;

  TrailerModel({
    required this.id,
    required this.movieId,
    required this.title,
    required this.youtubeUrl,
    required this.createdAt,
    required this.updatedAt,
  });

  factory TrailerModel.fromJson(Map<String, dynamic> json) {
    return TrailerModel(
      id: json['id'],
      movieId: json['movieId'],
      title: json['title'] ?? '',
      youtubeUrl: json['youtubeUrl'] ?? '',
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
    );
  }

  String get videoId {
    final uri = Uri.parse(youtubeUrl);
    return uri.queryParameters['v'] ?? '';
  }

  String get thumbnail =>
      'https://img.youtube.com/vi/$videoId/hqdefault.jpg';
}
