import 'package:go_router/go_router.dart'; // Best router for flutter
import 'package:provider/provider.dart'; // For ease of component reuse
import 'package:flutter/cupertino.dart'; // To get the build context

import 'routes.dart';
import '../data/repositories/auth/auth_repository.dart';
import '../data/repositories/auth/auth_repository_dev.dart';
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
        return LoginScreen(
          viewModel: LoginViewModel(authRepository: context.read()),
        );
      },
    ),
    GoRoute(
      path: Routes.signup,
      builder: (context, state) {
        return LoginScreen(
          viewModel: LoginViewModel(authRepository: context.read()),
        );
      },
    ),
    GoRoute(
      path: Routes.home,
      builder: (context, state) {
        final viewModel = HomeViewModel(userRepository: context.read());
        return HomeScreen(viewModel: viewModel);
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
  final loggedIn = await context.read<AuthRepository>().isAuthenticated;
  final loggingIn = state.matchedLocation == Routes.login;
  if (!loggedIn) {
    return Routes.login;
  }
  if (loggingIn) {
    return Routes.home;
  }
  return null;
}
