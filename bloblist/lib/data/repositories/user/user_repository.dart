// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import '../../../domain/models/user.dart';
import '../../../domain/models/blob.dart';
import '../../../utils/result.dart';

/// Data source for user related data
abstract class UserRepository {
  /// Get current user
  Future<Result<User>> getUser();

  //Get user's blob
  Future<Result<Blob>> getBlob();
}
