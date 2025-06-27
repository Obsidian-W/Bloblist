// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../routing/routes.dart';
//import '../../core/local.dart';
import '../../core/themes/dimens.dart';
import '../view_models/login_viewmodel.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key, required this.viewModel});

  final LoginViewModel viewModel;

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _email = TextEditingController(
    text: 'monemail@example.com',
  );
  final TextEditingController _password = TextEditingController(
    text: 'mySecretPassword',
  );

  @override
  void initState() {
    super.initState();
    widget.viewModel.login.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant LoginScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.login.removeListener(_onResult);
    widget.viewModel.login.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.login.removeListener(_onResult);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          const Card(),
          Padding(
            padding: EdgeInsetsGeometry.symmetric(
              horizontal: Dimens.paddingHorizontal,
              vertical: Dimens.paddingVertical,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextField(controller: _email),
                const SizedBox(height: Dimens.paddingVertical),
                TextField(controller: _password, obscureText: true),
                const SizedBox(height: Dimens.paddingVertical),
                ListenableBuilder(
                  listenable: widget.viewModel.login,
                  builder: (context, _) {
                    return FilledButton(
                      onPressed: () {
                        widget.viewModel.login.execute((
                          _email.value.text,
                          _password.value.text,
                        ));
                      },
                      child: Text("Login"),
                    );
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _onResult() {
    if (widget.viewModel.login.completed) {
      widget.viewModel.login.clearResult();
      context.go(Routes.home);
    }

    if (widget.viewModel.login.error) {
      widget.viewModel.login.clearResult();
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Couldn't log in"),
          action: SnackBarAction(
            label: "Try again",
            onPressed: () => widget.viewModel.login.execute((
              _email.value.text,
              _password.value.text,
            )),
          ),
        ),
      );
    }
  }
}
