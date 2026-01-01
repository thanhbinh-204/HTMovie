import 'package:flutter/material.dart';
import '../../widget/components/library_segmented_button.dart';
import '../../widget/items/savemovie_library.dart';
import '../../widget/items/continue_library.dart';

class LibraryPage extends StatelessWidget {
  const LibraryPage({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;

    return Scaffold(
      backgroundColor: const Color(0xFF191022),
      body: SafeArea(
        bottom: false,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.only(bottom: 80),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  child: Row(
                    children: [
                      const Text(
                        "My Library",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 25,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Spacer(),
                      IconButton.outlined(
                        onPressed: () {},
                        icon: Image.asset(
                          'assets/images/iconlibrary.png',
                          width: 24,
                          height: 24,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const LibrarySegmentedButton(),
                const SizedBox(height: 20),

                Row(
                  children: [
                    Padding(padding: EdgeInsets.only(left: isTablet ? 20 : 16)),
                    const Text(
                      "Saved Movies",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    Padding(
                      padding: EdgeInsets.only(right: isTablet ? 20 : 16),
                      child: const Text(
                        "See All",
                        style: TextStyle(
                          color: Color.fromARGB(255, 169, 79, 187),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                const SavemovieLibrary(),
                const SizedBox(height: 10),
                const SavemovieLibrary(),
                const SizedBox(height: 20),
                Row(
                  children: [
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: isTablet ? 16 : 12,
                      ),
                      child: Text(
                        "Continue Watching",
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16,),
                const ContinueLibrary(),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
