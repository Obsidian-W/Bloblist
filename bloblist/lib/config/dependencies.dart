// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../data/repositories/auth/auth_repository_dev.dart';
import '../data/repositories/user/user_repository.dart';
import '../data/repositories/user/user_repository_local.dart';
import '../data/services/local_data_service.dart';

/// Shared providers for all configurations.
List<SingleChildWidget> _sharedProviders = [];

/// Configure dependencies for local data.
/// This dependency list uses repositories that provide local data.

List<SingleChildWidget> get providersLocal {
  return [
    ChangeNotifierProvider<AuthRepository>(
      create: (context) => AuthRepositoryDev(),
    ),
    Provider.value(value: LocalDataService()),
    Provider(
      create: (context) =>
          UserRepositoryLocal(localDataService: context.read())
              as UserRepository,
    ),
    ..._sharedProviders, // Spread operator -> Yields -> Unpacks -> Inserts in another collection
  ];
}
