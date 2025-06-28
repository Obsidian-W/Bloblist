import 'package:bloblist/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
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
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        centerTitle: true,
        title: Text(AppLocalizations.of(context)!.titleLeaderboard),
      ),
      body: Center(
        child: Text(
          'Leaderboard screen',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
