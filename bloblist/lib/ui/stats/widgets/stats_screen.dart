import 'package:bloblist/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import '../view_models/stats_viewmodel.dart';

class StatsScreen extends StatefulWidget {
  const StatsScreen({super.key, required this.viewModel});

  final StatsViewModel viewModel;

  @override
  State<StatsScreen> createState() => _StatsScreenState();
}

class _StatsScreenState extends State<StatsScreen> {
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
        title: Text(AppLocalizations.of(context)!.titleStats),
      ),
      body: Center(
        child: Text(
          'Stats Screen',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
