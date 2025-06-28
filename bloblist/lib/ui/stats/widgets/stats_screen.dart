import 'package:bloblist/ui/core/bottom_bar.dart';
import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';

//import '../../../../routing/routes.dart';
//import '../../core/local.dart';
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
      appBar: AppBar(title: Text('Stats')),
      body: Center(
        child: Text(
          'Stats Screen',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
      bottomNavigationBar: BottomBar(currentIndex: 1),
    );
  }
}
