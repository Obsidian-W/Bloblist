import 'package:flutter/material.dart';
import 'package:bloblist/ui/core/bottom_bar.dart';
import 'package:bloblist/ui/home/widgets/home_screen.dart';
import 'package:bloblist/ui/stats/widgets/stats_screen.dart';
import 'package:bloblist/ui/stats/widgets/leaderboard_screen.dart';
import 'package:bloblist/ui/home/view_models/home_viewmodel.dart';
import 'package:bloblist/ui/stats/view_models/stats_viewmodel.dart';
import 'package:bloblist/ui/stats/view_models/leaderboard_viewmodel.dart';

class HomeTabsPage extends StatefulWidget {
  const HomeTabsPage({super.key, required this.viewModel});

  final HomeViewModel viewModel;

  @override
  State<HomeTabsPage> createState() => _HomeTabsPageState();
}

class _HomeTabsPageState extends State<HomeTabsPage> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: [
          HomeScreen(viewModel: widget.viewModel),
          StatsScreen(viewModel: StatsViewModel()),
          LeaderboardScreen(viewModel: LeaderboardViewModel()),
        ],
      ),
      bottomNavigationBar: BottomBar(
        currentIndex: _currentIndex,
        onTabSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
      ),
    );
  }
}
