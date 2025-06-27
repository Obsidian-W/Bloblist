import '../../../data/repositories/user/user_repository.dart';

class HomeViewModel {
  HomeViewModel({required UserRepository userRepository})
    : _userRepository = userRepository {
    //
  }

  final UserRepository _userRepository;
}
