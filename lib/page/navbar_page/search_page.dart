import 'package:flutter/material.dart';
import 'package:ht_movie/call_api/services/movie_service.dart';
import 'package:ht_movie/call_api/models/movie_model.dart';
import 'dart:async';
import 'package:ht_movie/widget/items/moviecard.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final _searchPage = TextEditingController();
  List<MovieModel> _results = [];
  bool _isLoading = false;
  Timer? _debounce;

  @override
  void dispose() {
    _debounce?.cancel();
    _searchPage.dispose();
    super.dispose();
  }

  // debounce không lag
  void _onSearchChanged(String value) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    _debounce = Timer(const Duration(milliseconds: 500), () async {
      if (value.trim().isEmpty) {
        setState(() {
          _results.clear();
          _isLoading = false;
        });
        return;
      }

      setState(() => _isLoading = true);

      try {
        final results = await MovieService.searchMovieByTitle(value.trim());

        setState(() {
          _results = results;
        });
      } catch (e) {
        debugPrint('Search error: $e');
      } finally {
        setState(() => _isLoading = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    final int crossAxisCount = isTablet ? 3 : 2;
    final double childAspectRatio = isSmallPhone ? 0.58 : 0.62;

    return Scaffold(
      backgroundColor: Color(0xFF191022),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(
              left: 10,
              right: 10,
              top: MediaQuery.of(context).padding.top + 12,
            ),
            child: TextFormField(
              controller: _searchPage,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel_outlined, color: Colors.white),
                  onPressed: () {
                    _searchPage.clear();
                    _onSearchChanged('');
                  },
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(isTablet ? 28 : 20),
                  borderSide: BorderSide(color: Colors.white10, width: 1.2),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
          const SizedBox(height: 12),

          if (_results.isNotEmpty && !_isLoading)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                'Found ${_results.length} results',
                style: const TextStyle(color: Colors.white70, fontSize: 14),
              ),
              )
            ),

          const SizedBox(height: 8),

          // hiển thị kết quả
          if (_isLoading)
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: CircularProgressIndicator(
                valueColor: AlwaysStoppedAnimation<Color>(
                  Colors.deepPurpleAccent,
                ),
              ),
            )
          else if (_results.isEmpty && _searchPage.text.isNotEmpty)
            const Padding(
              padding: EdgeInsets.only(top: 40),
              child: Text(
                "No result found",
                style: TextStyle(color: Colors.white54),
              ),
            )
          else
            Expanded(
              child: GridView.builder(
                padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
                itemCount: _results.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: isSmallPhone ? 12 : 16,
                  crossAxisSpacing: isSmallPhone ? 10 : 12,
                  childAspectRatio: childAspectRatio,
                ),
                itemBuilder: (context, index) {
                  return MovieCard(
                    movie: _results[index],
                    isTablet: isTablet,
                    isSmallPhone: isSmallPhone,
                  );
                },
              ),
            ),
        ],
      ),
    );
  }
}
