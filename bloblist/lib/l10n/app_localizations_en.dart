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
  String get textEmail => 'Email';

  @override
  String get textPhone => 'Phone no.';

  @override
  String get textPassword => 'Password';

  @override
  String get goLogin => 'Have an account? Log in';

  @override
  String get goSignup => 'Don\'t have an account? Sign up';

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

  @override
  String get textEnterTodo => 'Enter todo item';

  @override
  String get actionAdd => 'Add';

  @override
  String get errorEmailRequired => 'Error: Missing email';

  @override
  String get errorEmailInvalid => 'Error: Invalid email';

  @override
  String get errorPhoneRequired => 'Error: missing phone';

  @override
  String get errorPhoneInvalid => 'Error: Invalid phone';

  @override
  String get alertTodoLimit => 'Error: To many todos (max=5)';
}
