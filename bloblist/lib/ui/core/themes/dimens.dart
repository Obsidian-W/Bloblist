// Copyright 2024 The Flutter team. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'package:flutter/material.dart';

abstract final class Dimens {
  const Dimens();

  // Generic paddings used to separate UI items
  static const paddingHorizontal = 20.0;
  static const doublePaddingHorizontal = 40.0;

  static const paddingVertical = 24.0;
  static const doublePaddingVertical = 48.0;

  static const Dimens desktop = _DimensDesktop();
  static const Dimens mobile = _DimensMobile();

  factory Dimens.of(BuildContext context) =>
      switch (MediaQuery.sizeOf(context).width) {
        > 600 && < 840 => desktop,
        _ => mobile,
      };
}

/// Mobile dimensions
final class _DimensMobile extends Dimens {
  const _DimensMobile();
}

/// Desktop/Web dimensions
final class _DimensDesktop extends Dimens {
  const _DimensDesktop();
}
