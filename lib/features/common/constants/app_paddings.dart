import 'package:flutter/material.dart';
import 'package:money_lover_clone/features/common/constants/app_sizes.dart';

class AppPaddings {
  const AppPaddings._();

  static const vSmall = EdgeInsets.symmetric(vertical: AppSizes.x1);
  static const vMedium = EdgeInsets.symmetric(vertical: AppSizes.x3);
  static const vLarge = EdgeInsets.symmetric(vertical: AppSizes.x5);

  static const hSmall = EdgeInsets.symmetric(horizontal: AppSizes.x1);
  static const hMedium = EdgeInsets.symmetric(horizontal: AppSizes.x3);
  static const hLarge = EdgeInsets.symmetric(horizontal: AppSizes.x5);

  static const small = EdgeInsets.all(AppSizes.x1);
  static const medium = EdgeInsets.all(AppSizes.x3);
  static const large = EdgeInsets.all(AppSizes.x5);
}
