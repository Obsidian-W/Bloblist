import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
//import '../../core/local.dart';
import '../../../routing/routes.dart';
import '../../core/themes/dimens.dart';
import '../view_models/signup_viewmodel.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key, required this.viewModel});

  final SignupViewModel viewModel;

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final TextEditingController _email = TextEditingController(text: '');
  final TextEditingController _password = TextEditingController(text: '');
  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final Color accentColor = Theme.of(context).colorScheme.primary;

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.black,
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
                    TextField(
                      controller: _email,
                      obscureText: false,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w700,
                      ),
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        labelText: 'Email',
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
                        labelText: 'Password',
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
                      listenable: widget.viewModel.signup,
                      builder: (context, _) {
                        return FilledButton(
                          onPressed: () {
                            widget.viewModel.signup.execute((
                              _email.value.text,
                              _password.value.text,
                            ));
                          },
                          child: Text("Sign up"),
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: Dimens.doublePaddingVertical,
            child: Center(
              child: TextButton(
                onPressed: () {
                  context.pop();
                },
                child: const Text("Have an account? Log in"),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
