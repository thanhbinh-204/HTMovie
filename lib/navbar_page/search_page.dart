import 'package:flutter/material.dart';

class SearchPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _SearchPage();
}

class _SearchPage extends State<SearchPage> {
  final _searchPage = TextEditingController();

  @override
  void dispose() {
    _searchPage.dispose();
    super.dispose();
  }

  void _onSearchChanged(String value) {
    print('Search keyword: $value');
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    return Scaffold(
      backgroundColor: Color(0xFF191022),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(top: 50, left: 10, right: 10),
            child: TextFormField(
              controller: _searchPage,
              onChanged: _onSearchChanged,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search, color: Colors.white),
                suffixIcon: IconButton(
                  icon: Icon(Icons.cancel_outlined,color: Colors.white,),
                  onPressed: () {
                    _searchPage.clear();
                    _onSearchChanged('');
                  },
                ),
                filled: true,
                fillColor: Colors.transparent,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide(color: Colors.white10, width: 1.2),
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }
}
