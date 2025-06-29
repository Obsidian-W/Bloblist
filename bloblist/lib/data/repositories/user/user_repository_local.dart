// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../domain/models/user.dart';
import '../../../domain/models/blob.dart';
import '../../../utils/result.dart';
import 'user_repository.dart';

//Quick and dirty local repository for user data
class UserRepositoryLocal implements UserRepository {
  UserRepositoryLocal();

  @override
  Future<Result<User>> getUser() async {
    //Empty for now, as it's not used yet
    return Result.ok(User("", ""));
  }

  /// Get the user's blob or create a new one if it doesn't exist
  @override
  Future<Blob> getBlob() async {
    Blob? blob;

    final prefs = await SharedPreferences.getInstance();
    final blobFromPrefs = prefs.getString('blob');

    if (blobFromPrefs != null) {
      blob = Blob.fromJson(jsonDecode(blobFromPrefs));
    } else {
      blob = Blob();
    }
    return blob;
  }

  /// Save or update the user's blob
  @override
  Future<Result<void>> saveBlob({required Blob blob}) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString("blob", jsonEncode(blob.toJson()));
    return const Result.ok(null);
  }
}
