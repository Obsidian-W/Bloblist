import 'package:go_router/go_router.dart'; // Best router for flutter
import 'package:provider/provider.dart'; // For ease of component reuse
import 'package:flutter/cupertino.dart'; // To get the build context

import 'routes.dart';
import '../data/repositories/auth/auth_repository.dart';
import '../ui/all.dart';

GoRouter router(AuthRepository authRepository) => GoRouter(
  initialLocation: Routes.home,
  debugLogDiagnostics: true,
  redirect: _redirect,
  refreshListenable: authRepository,
  routes: [
    GoRoute(
      path: Routes.login,
      builder: (context, state) {
        return LoginScreen(viewModel: LoginViewModel(authRepository: context.read()));
      },
    ),
    GoRoute(
      path: Routes.signup,
      builder: (context, state) {
        return SignupScreen(viewModel: SignupViewModel(authRepository: context.read()));
      },
    ),
    GoRoute(
      path: Routes.signup,
      pageBuilder: (context, state) {
        return CustomTransitionPage<void>(
          key: state.pageKey,
          child: SignupScreen(viewModel: SignupViewModel(authRepository: context.read())),
          transitionsBuilder: (context, animation, secondaryAnimation, child) {
            return FadeTransition(opacity: animation, child: child);
          },
          transitionDuration: const Duration(milliseconds: 300),
          reverseTransitionDuration: const Duration(milliseconds: 200),
        );
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        return ChangeNotifierProvider(
          create: (_) => HomeViewModel(userRepository: context.read(), taskRepository: context.read()),
          child: const HomeTabsPage(),
        );
      },
      routes: [
        GoRoute(
          path: Routes.stats,
          builder: (context, state) {
            final viewModel = StatsViewModel(
              //Add repo for data here
            );
            return StatsScreen(viewModel: viewModel);
          },
        ),
        GoRoute(
          path: Routes.leaderboard,
          builder: (context, state) {
            final viewModel = LeaderboardViewModel(
              //Add repo for data here
            );
            return LeaderboardScreen(viewModel: viewModel);
          },
        ),
      ],
    ),
  ],
);

// From https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart
Future<String?> _redirect(BuildContext context, GoRouterState state) async {
  final authRepository = context.read<AuthRepository>();
  final loggedIn = authRepository.isAuthenticatedSync;

  final loggingIn = state.matchedLocation == Routes.login;
  final signingUp = state.matchedLocation == Routes.signup;

  // If not logged in, allow access to login and signup or redirect to login
  if (!loggedIn && !(loggingIn || signingUp)) {
    return Routes.login;
  }
  // If logged in and trying to access auth -> redirect to home
  if (loggedIn && (loggingIn || signingUp)) {
    return Routes.home;
  }
  // No redirect
  return null;
}
