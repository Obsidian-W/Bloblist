import 'package:shared_preferences/shared_preferences.dart';

import '../../../utils/result.dart';
import 'auth_repository.dart';

class AuthRepositoryDev extends AuthRepository {
  bool _isAuthenticated = false;
  static const _authKey = 'is_authenticated';

  AuthRepositoryDev() {
    _loadAuthState();
  }

  Future<void> _loadAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    _isAuthenticated = prefs.getBool(_authKey) ?? false;
    notifyListeners();
  }

  Future<void> _saveAuthState() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_authKey, _isAuthenticated);
  }

  @override
  Future<bool> get isAuthenticated => Future.value(_isAuthenticated);

  @override
  bool get isAuthenticatedSync => _isAuthenticated;

  /// Login is always successful in dev scenarios
  @override
  Future<Result<void>> login({
    required String email,
    required String password,
  }) async {
    _isAuthenticated = true;
    await _saveAuthState();
    notifyListeners();
    return const Result.ok(null);
  }

  @override
  Future<Result<void>> signup({
    required String email,
    required String password,
  }) async {
    _isAuthenticated = true;
    await _saveAuthState();
    notifyListeners();
    return const Result.ok(null);
  }

  /// Logout is always successful in dev scenarios
  @override
  Future<Result<void>> logout() async {
    _isAuthenticated = false;
    await _saveAuthState();
    notifyListeners();
    return const Result.ok(null);
  }
}
