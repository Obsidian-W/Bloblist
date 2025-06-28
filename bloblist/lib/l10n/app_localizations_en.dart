// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get textWelcome => 'Welcome to BlobList!';

  @override
  String get textEmail => 'email';

  @override
  String get textPassword => 'password';

  @override
  String get goLogin => 'Don\'t have an account? Sign up';

  @override
  String get goSignup => 'Have an account? Log in';

  @override
  String get errorLogin => 'Couldn\'t log in';

  @override
  String get errorRetry => 'Try again';

  @override
  String get actionLogin => 'Login';

  @override
  String get actionSignup => 'Signup';

  @override
  String get actionLogout => 'Logout';

  @override
  String get alertDoubleBack => 'Press back again to exit';

  @override
  String get titleLeaderboard => 'Leaderboard';

  @override
  String get titleStats => 'Stats';
}
