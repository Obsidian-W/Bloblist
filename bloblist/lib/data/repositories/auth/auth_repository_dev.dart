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

  /// Login should always successful in dev scenarios -> Here it's ok if we use empty credentials
  /// Quickly built by Gemini
  @override
  Future<Result<void>> login({required String email, required String password}) async {
    final prefs = await SharedPreferences.getInstance();
    final userKey = 'user_$email';
    final storedPassword = prefs.getString(userKey);

    if (email.isEmpty && password.isEmpty) {
      _isAuthenticated = true;
    } else if (storedPassword != null && storedPassword == password) {
      _isAuthenticated = true;
    } else {
      _isAuthenticated = false;
      return Result.error(Exception('Invalid credentials'));
    }

    await _saveAuthState();
    notifyListeners();
    return _isAuthenticated ? const Result.ok(null) : Result.error(Exception('Login failed'));
  }

  /// Quickly built by Gemini
  @override
  Future<Result<void>> signup({required String email, required String password, required String phone}) async {
    final prefs = await SharedPreferences.getInstance();
    final userKey = 'user_$email';
    await prefs.setString(userKey, password);
    return const Result.ok(null);
  }

  /// Logout is always successful in dev scenarios
  @override
  Future<Result<void>> logout() async {
    _isAuthenticated = false;
    await _saveAuthState();

    // Clear all preferences to simulate a full logout
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear();

    notifyListeners();
    return const Result.ok(null);
  }
}
