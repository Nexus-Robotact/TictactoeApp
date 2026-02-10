import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTextStyle {
  static const title = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.w800,
    color: AppColors.textPrimary,
  );

  static const status = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w700,
    color: AppColors.textPrimary,
  );

  static const subtle = TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w600,
    color: AppColors.textSecondary,
  );

  static const cell = TextStyle(
    fontSize: 150,
    fontWeight: FontWeight.w900,
    height: 1.0,
    letterSpacing: 1.0,
  );
}
