import 'package:bloblist/ui/core/bottom_bar.dart';
import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';

//import '../../../../routing/routes.dart';
//import '../../core/local.dart';
import '../view_models/leaderboard_viewmodel.dart';

class LeaderboardScreen extends StatefulWidget {
  const LeaderboardScreen({super.key, required this.viewModel});

  final LeaderboardViewModel viewModel;

  @override
  State<LeaderboardScreen> createState() => _LeaderboardScreenState();
}

class _LeaderboardScreenState extends State<LeaderboardScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leaderboard')),
      body: Center(
        child: Text(
          'Leaderboard screen',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      bottomNavigationBar: BottomBar(currentIndex: 2),
    );
  }
}
