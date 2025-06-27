import 'package:provider/provider.dart';
import '../../../data/repositories/user/user_repository.dart';
import '../../../data/repositories/auth/auth_repository.dart';
import 'package:flutter/material.dart';

class HomeViewModel {
  HomeViewModel({required UserRepository userRepository})
    : _userRepository = userRepository {
    //
  }

  final UserRepository _userRepository;

  Future<void> logout(BuildContext context) async {
    await context.read<AuthRepository>().logout();
  }
}
