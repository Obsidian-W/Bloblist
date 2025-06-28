// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:ui';

import 'package:bloblist/l10n/app_localizations.dart';
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
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _password = TextEditingController(text: '');
  bool _isObscured = true;

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
    final Color accentColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      extendBody: true,
      body: Stack(
        children: [
          // 1. The Background Image
          Positioned.fill(
            // Makes the image fill the entire Stack area
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage('images/bg_slime.png'),
                  repeat: ImageRepeat.repeat,
                ),
              ),
            ),
          ),
          Positioned.fill(
            // Makes the blur filter cover the entire Stack area
            child: BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
              child: Container(color: Colors.black.withOpacity(0.8)),
            ),
          ),
          Column(
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
                    Text(
                      AppLocalizations.of(context)!.textWelcome,
                      textAlign: TextAlign.center,
                      maxLines: 2,
                      style: TextStyle(
                        shadows: [
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.white,
                            offset: Offset(3.0, 0.0),
                          ),
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.white,
                            offset: Offset(-3.0, 0.0),
                          ),
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.white,
                            offset: Offset(0.0, 3.0),
                          ),
                          Shadow(
                            blurRadius: 4.0,
                            color: Colors.white,
                            offset: Offset(0.0, -3.0),
                          ),
                          Shadow(
                            blurRadius: 6.0,
                            color: Colors.white.withOpacity(0.6),
                            offset: Offset.zero,
                          ),
                        ],
                        color: accentColor,
                        fontSize: 42.0,
                        fontWeight: FontWeight.w700,
                        fontFamily: 'GuavaCandy',
                        letterSpacing: 6.0,
                      ),
                    ),
                    const SizedBox(height: Dimens.doublePaddingVertical),
                    TextField(
                      controller: _email,
                      obscureText: false,
                      autofocus: true,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.textEmail,
                        labelStyle: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(height: Dimens.doublePaddingVertical),
                    TextField(
                      controller: _password,
                      obscureText: _isObscured,
                      obscuringCharacter: "☺",
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: AppLocalizations.of(context)!.textPassword,
                        labelStyle: TextStyle(
                          color: accentColor,
                          fontWeight: FontWeight.w500,
                        ),
                        suffixIcon: IconButton(
                          padding: const EdgeInsets.all(0),
                          iconSize: 20.0,
                          icon: _isObscured
                              ? const Icon(
                                  Icons.visibility_off,
                                  color: Colors.grey,
                                )
                              : const Icon(
                                  Icons.visibility,
                                  color: Colors.black,
                                ),
                          onPressed: () {
                            setState(() {
                              _isObscured = !_isObscured;
                            });
                          },
                        ),
                      ),
                    ),
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
                          child: Text(
                            AppLocalizations.of(context)!.actionLogin,
                          ),
                        );
                      },
                    ),
                    const SizedBox(height: Dimens.paddingVertical),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: Dimens.paddingVertical,
            child: Center(
              child: TextButton(
                onPressed: () {
                  context.push(Routes.signup);
                },
                child: Text(
                  AppLocalizations.of(context)!.goSignup,
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
              ),
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
          content: Text(AppLocalizations.of(context)!.errorLogin),
          action: SnackBarAction(
            label: AppLocalizations.of(context)!.errorRetry,
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
