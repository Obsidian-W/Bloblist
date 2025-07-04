// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../data/repositories/auth/auth_repository.dart';
import '../data/repositories/auth/auth_repository_local.dart';
import '../data/repositories/user/user_repository.dart';
import '../data/repositories/user/user_repository_local.dart';
import '../data/repositories/tasks/task_repository.dart';
import '../data/repositories/tasks/task_repository_local.dart';

/// Shared providers for all configurations.
List<SingleChildWidget> _sharedProviders = [];

/// Configure dependencies for local data.
/// This dependency list uses repositories that provide local data.

List<SingleChildWidget> get providersLocal {
  return [
    ChangeNotifierProvider<AuthRepository>(create: (_) => AuthRepositoryDev()),
    Provider(create: (context) => UserRepositoryLocal() as UserRepository),
    Provider(create: (context) => TaskRepositoryLocal() as TaskRepository),
    ..._sharedProviders, // Spread operator -> Yields -> Unpacks -> Inserts in another collection
  ];
}
