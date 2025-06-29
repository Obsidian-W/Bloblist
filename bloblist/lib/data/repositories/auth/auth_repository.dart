import 'package:flutter/foundation.dart';

import '../../../utils/result.dart';

abstract class AuthRepository extends ChangeNotifier {
  /// Returns true when the user is logged in
  /// Returns [Future] because it will load a stored auth state the first time.
  Future<bool> get isAuthenticated;

  /// Returns true if the user is currently authenticated (in-memory, synchronous)
  bool get isAuthenticatedSync;

  // Perform login
  Future<Result<void>> login({required String email, required String password});

  // Perform signup - similar to login for now
  Future<Result<void>> signup({required String email, required String password, required String phone});

  // Perform logout
  Future<Result<void>> logout();
}
