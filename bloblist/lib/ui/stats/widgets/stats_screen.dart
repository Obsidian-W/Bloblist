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
    // TODO: implement build
    throw UnimplementedError();
  }
}
