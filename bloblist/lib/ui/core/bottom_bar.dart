import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:bloblist/routing/routes.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  const BottomBar({super.key, required this.currentIndex});

  void _onTap(BuildContext context, int index) {
    switch (index) {
      case 0:
        context.go(Routes.home);
        break;
      case 1:
        context.go(Routes.stats);
        break;
      case 2:
        context.go(Routes.leaderboard);
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: (index) => _onTap(context, index),
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        BottomNavigationBarItem(
          icon: Icon(Icons.stars_sharp),
          label: 'Leaderboard',
        ),
      ],
    );
  }
}
