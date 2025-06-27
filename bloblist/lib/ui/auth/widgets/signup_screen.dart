import 'package:flutter/material.dart';
//import 'package:go_router/go_router.dart';

//import '../../../../routing/routes.dart';
//import '../../core/local.dart';
import '../view_models/signup_viewmodel.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.viewModel});

  final SignupViewModel viewModel;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
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
