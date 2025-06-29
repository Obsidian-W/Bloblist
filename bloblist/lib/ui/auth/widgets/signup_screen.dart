import 'dart:ui';

import 'package:bloblist/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
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
  final TextEditingController _phone = TextEditingController(text: '');
  final TextEditingController _password = TextEditingController(text: '');
  final _formKey = GlobalKey<FormState>();

  bool _isObscured = true;

  @override
  void initState() {
    super.initState();
    widget.viewModel.signup.addListener(_onResult);
  }

  @override
  void didUpdateWidget(covariant SignupScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    oldWidget.viewModel.signup.removeListener(_onResult);
    widget.viewModel.signup.addListener(_onResult);
  }

  @override
  void dispose() {
    widget.viewModel.signup.removeListener(_onResult);
    super.dispose();
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
                image: DecorationImage(image: AssetImage('images/bg_slime.png'), repeat: ImageRepeat.repeat),
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
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFormField(
                        controller: _email,
                        autofocus: true,
                        obscureText: false,
                        keyboardType: TextInputType.emailAddress,
                        style: const TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.textEmail,
                          labelStyle: TextStyle(color: accentColor, fontWeight: FontWeight.w500),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.errorEmailRequired;
                          }
                          // Simple email regex
                          final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
                          if (!emailRegex.hasMatch(value)) {
                            return AppLocalizations.of(context)!.errorEmailInvalid;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: Dimens.doublePaddingVertical),
                      TextFormField(
                        controller: _phone,
                        obscureText: false,
                        keyboardType: TextInputType.phone,
                        style: const TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w700),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.textPhone,
                          labelStyle: TextStyle(color: accentColor, fontWeight: FontWeight.w500),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return AppLocalizations.of(context)!.errorPhoneRequired;
                          }
                          // Simple phone validation: digits only and length between 7 and 15
                          final phoneRegex = RegExp(r'^\+?[0-9]{7,15}$');
                          if (!phoneRegex.hasMatch(value)) {
                            return AppLocalizations.of(context)!.errorPhoneInvalid;
                          }
                          return null;
                        },
                      ),
                      const SizedBox(height: Dimens.doublePaddingVertical),
                      TextFormField(
                        controller: _password,
                        obscureText: _isObscured,
                        obscuringCharacter: "☺",
                        style: const TextStyle(color: Colors.white, fontSize: 16.0, fontWeight: FontWeight.w500),
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          labelText: AppLocalizations.of(context)!.textPassword,
                          labelStyle: TextStyle(color: accentColor, fontWeight: FontWeight.w500),
                          suffixIcon: IconButton(
                            padding: const EdgeInsets.all(0),
                            iconSize: 20.0,
                            icon: _isObscured
                                ? const Icon(Icons.visibility_off, color: Colors.grey)
                                : const Icon(Icons.visibility, color: Colors.black),
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
                              if (_formKey.currentState?.validate() ?? false) {
                                widget.viewModel.signup.execute((_email.text, _password.text, _phone.text));
                              }
                            },
                            child: Text(AppLocalizations.of(context)!.actionSignup),
                          );
                        },
                      ),
                      const SizedBox(height: Dimens.paddingVertical),
                    ],
                  ),
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
                  context.pop();
                },
                child: Text(AppLocalizations.of(context)!.goLogin),
              ),
            ),
          ),
        ],
      ),
    );
  }

  //Quick and dirty
  void _onResult() {
    if (widget.viewModel.signup.completed) {
      widget.viewModel.signup.clearResult();
      // Go back to login after signup
      context.pop();
    }
  }
}
