import 'package:flutter/material.dart';

class BottomBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTabSelected;
  const BottomBar({super.key, required this.currentIndex, required this.onTabSelected});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      backgroundColor: Colors.purple.shade50,
      currentIndex: currentIndex,
      onTap: (index) {
        onTabSelected(index);
      },
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
        BottomNavigationBarItem(icon: Icon(Icons.bar_chart), label: 'Stats'),
        BottomNavigationBarItem(icon: Icon(Icons.stars_sharp), label: 'Leaderboard'),
      ],
    );
  }
}
