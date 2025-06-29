import 'package:logging/logging.dart';

import '../../../../data/repositories/auth/auth_repository.dart';
import '../../../../utils/command.dart';
import '../../../../utils/result.dart';

class SignupViewModel {
  SignupViewModel({required AuthRepository authRepository}) : _authRepository = authRepository {
    signup = Command1<void, (String email, String password, String phone)>(_signup);
  }

  final AuthRepository _authRepository;
  final _log = Logger('SignupViewModel');

  late Command1 signup;

  Future<Result<void>> _signup((String, String, String) credentials) async {
    final (email, password, phone) = credentials;
    final result = await _authRepository.signup(email: email, password: password, phone: phone);
    if (result is Error<void>) {
      _log.warning('Signup failed! ${result.error}');
    }
    return result;
  }
}
