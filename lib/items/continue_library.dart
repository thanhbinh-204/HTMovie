import 'package:flutter/material.dart';

class ContinueLibrary extends StatelessWidget {
  const ContinueLibrary({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final isTablet = size.width >= 600;
    final isSmallPhone = size.height < 700;
    final List<Map<String, dynamic>> historyLibrary = [
      {
        'title': 'The Batman',
        'image':
            'https://i.pinimg.com/736x/65/df/9f/65df9ff03792802a3fc5f1c416bd63cf.jpg',
        'time': '1h45 remaining',
        'progress': 0.6,
        'watched': false,
      },
      {
        'title': 'Everything Everywhere',
        'image':
            'https://i.pinimg.com/736x/9b/7b/e2/9b7be2979f2e5cbf5777d5ed927d663a.jpg',
        'time': 'Watched 2 days ago',
        'progress': null,
        'watched': true,
      },
      {
        'title': 'SEKIRO',
        'image':
            'https://i.pinimg.com/474x/e2/29/76/e229763a0b41d53a9fb355953f4040f8.jpg',
        'time': 'Watched 2 days ago',
        'progress': 0.3,
        'watched': false,
      },
       {
        'title': 'HALO',
        'image':
            'https://i.pinimg.com/474x/e4/e0/44/e4e0445ce28e747d25f77d661e84d338.jpg',
        'time': 'Watched 2 days ago',
        'progress': null,
        'watched': true,
      },
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: historyLibrary.length,
          itemBuilder: (context, index) {
            final item = historyLibrary[index];
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
                      item['image'],
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
                          item['title'],
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 5),
                        Text(
                          item['time'],
                          style: TextStyle(
                            color:
                                item['watched']
                                    ? Colors.grey
                                    : Color(0xFFA06AF9),
                            fontSize: 12,
                            overflow: TextOverflow.ellipsis
                          ),
                        ),
                        const SizedBox(height: 12),
                        if (item['progress'] != null)
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: item['progress'],
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
                        item['watched']
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
