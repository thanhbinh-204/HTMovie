import 'movie_model.dart';

class WatchHistoryModel {
  final String id;
  final MovieModel movie;
  final int progress;

  WatchHistoryModel({
    required this.id,
    required this.movie,
    required this.progress,
  });

  factory WatchHistoryModel.fromJson(Map<String, dynamic> json) {
    return WatchHistoryModel(
      id: json['_id'], 
      movie: MovieModel.fromJson(json['movie']), 
      progress: json['progress'] ?? 0,
      );
  }

  int get remainingSeconds => movie.runtime - progress;

  String get remainingText {
    final seconds = remainingSeconds;
    if (seconds <= 0) return 'Đã xem xong';

    final h = seconds ~/ 3600;
    final m = (seconds % 3600) ~/ 60;

    if (h > 0) return '${h}h${m}m remaining';
    return '${m}m remaining';
  }

}