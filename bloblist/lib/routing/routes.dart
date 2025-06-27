abstract final class Routes {
  static const login = '/login';
  static const signup = '/signup';

  //Post login
  //Universal -> Can redirect to login if needed
  static const home = '/';
  static const leaderboard = '/leaderboard';
  static const stats = '/stats';
  static String statsForId(int id) => '$stats/$id'; //Just as an example
}
