import 'package:flutter/material.dart';
import 'package:money_lover_clone/features/common/constants/app_sizes.dart';

class Gap {
  const Gap._();

  // verticall
  static Widget vSmall = const SizedBox(
    height: AppSizes.x1,
  );
  static Widget vMedium = const SizedBox(
    height: AppSizes.x3,
  );
  static Widget get = const SizedBox(
    height: AppSizes.x5,
  );

  static Widget v(double x) => SizedBox(
        height: x,
      );

  // horizontall
  static Widget hSmall = const SizedBox(
    width: AppSizes.x1,
  );
  static Widget hMedium = const SizedBox(
    width: AppSizes.x3,
  );
  static Widget hLarge = const SizedBox(
    width: AppSizes.x5,
  );

  static Widget h(double x) => SizedBox(
        width: x,
      );
}
