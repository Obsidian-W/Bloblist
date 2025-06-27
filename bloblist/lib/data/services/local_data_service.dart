import 'package:flutter/services.dart';
import '../../../domain/models/user.dart';

class LocalDataService {
  User getUser() {
    return User('Pouet', 'pouet@pou.et');
  }
}
