import 'package:flutter/material.dart';
import 'package:ht_movie/call_api/models/watch_history_model.dart';
import 'package:ht_movie/call_api/services/watch_history_service.dart';
import '../../../call_api/services/auth_service.dart';

class Continuewatching extends StatefulWidget {
  const Continuewatching({super.key});

  @override
  State<Continuewatching> createState() => _ContinuewatchingState();
}

class _ContinuewatchingState extends State<Continuewatching> {
  List<WatchHistoryModel> watchHistory = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchWatchHistory();
  }

  Future<void> fetchWatchHistory() async {
    try {
      final token = await AuthService.getAccessToken();
      if (token == null) {
        setState(() => isLoading = false);
        return;
      }
      final result = await WatchHistoryService.getWatchHistory(token: token);
      setState(() {
        watchHistory = result;
        isLoading = false;
      });
    } catch (e) {
      setState(() => isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final bool isTablet = size.width >= 600;
    final bool isSmallPhone = size.height < 700;
    final double height = isSmallPhone ? 180 : (isTablet ? 250 : 220);

    if (isLoading) {
      return SizedBox(
        height: height,
        child: Center(child: CircularProgressIndicator()),
      );
    }

    if (watchHistory.isEmpty) {
      return SizedBox(
        height: height,
        child: Center(
          child: Text(
            'Chưa xem bộ phim nào',
            style: TextStyle(color: Colors.white54, fontSize: 14),
          ),
        ),
      );
    }

    return SizedBox(
      height: isSmallPhone ? 180 : (isTablet ? 250 : 220),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: watchHistory.length,
        itemBuilder: (context, index) {
          final item = watchHistory[index];

          return Container(
            width: isTablet ? 260 : 225,
            margin: const EdgeInsets.only(right: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(16),
                    child: Image.network(
                      item.movie.posterUrl,
                      fit: BoxFit.cover,
                      width: double.infinity,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.movie.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  item.remainingText,
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
