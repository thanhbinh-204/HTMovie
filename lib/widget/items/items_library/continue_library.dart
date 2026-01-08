import 'package:flutter/material.dart';
import 'package:ht_movie/call_api/models/watch_history_model.dart';
import 'package:ht_movie/call_api/services/auth_service.dart';
import 'package:ht_movie/call_api/services/watch_history_service.dart';

class ContinueLibrary extends StatefulWidget {
  const ContinueLibrary({super.key});

  @override
  State<StatefulWidget> createState() => _ContinueLibraryState();
}

class _ContinueLibraryState extends State<ContinueLibrary> {
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
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    if (isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (watchHistory.isEmpty) {
      return Center(
        child: Text(
          'Chưa xem bộ phim nào',
          style: TextStyle(color: Colors.white54, fontSize: 14),
        ),
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: watchHistory.length,
          itemBuilder: (context, index) {
            final item = watchHistory[index];
            final watched = item.remainingSeconds <= 0;
            final progressValue =
                watched ? null : item.progress / item.movie.runtime;
            return Container(
              margin: EdgeInsets.symmetric(
                horizontal: isTablet ? size.width * 0.1 : 20,
                vertical: 8,
              ),
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Color(0xFF1A1D2E),
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.white10),
              ),
              child: Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.network(
                      item.movie.posterUrl,
                      width: 80,
                      height: 100,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(width: 15),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          item.movie.title,
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          watched ? 'Đã xem' : item.remainingText,
                          style: TextStyle(
                            color: watched ? Colors.grey : Color(0xFFA06AF9),
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (progressValue != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: progressValue,
                              backgroundColor: Colors.white12,
                              color: const Color(0xFFA06AF9),
                              minHeight: 4,
                            ),
                          ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child:
                        watched
                            ? const Icon(
                              Icons.check_circle,
                              color: Colors.greenAccent,
                              size: 28,
                            )
                            : const Icon(Icons.more_vert, color: Colors.grey),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }
}
