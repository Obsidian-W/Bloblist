// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get textWelcome => 'Bienvenue sur BlobList !';

  @override
  String get textEmail => '@Email';

  @override
  String get textPhone => 'N° Tel.';

  @override
  String get textPassword => 'Mot de passe';

  @override
  String get goLogin => 'Pas de compte ? Inscrivez-vous';

  @override
  String get goSignup => 'Vous avez un compte ? Connectez-vous';

  @override
  String get errorLogin => 'Connexion impossible';

  @override
  String get errorRetry => 'Réessayer';

  @override
  String get actionLogin => 'Connexion';

  @override
  String get actionSignup => 'Inscription';

  @override
  String get actionLogout => 'Déconnexion';

  @override
  String get alertDoubleBack => 'Appuyez à nouveau pour quitter';

  @override
  String get titleLeaderboard => 'Leaderboard';

  @override
  String get titleStats => 'Stats';

  @override
  String get textEnterTodo => 'Entrer une tâche';

  @override
  String get actionAdd => 'Ajouter';

  @override
  String get errorEmailRequired => 'Erreur: Email manquant';

  @override
  String get errorEmailInvalid => 'Erreur: Email invalide';

  @override
  String get errorPhoneRequired => 'Erreur: Tel manquant';

  @override
  String get errorPhoneInvalid => 'Erreur: Tel invalide';
}
