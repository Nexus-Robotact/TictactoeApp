// lib/core/theme/app_colors.dart
import 'package:flutter/material.dart';

class AppColors {
  // 앱 배경(남색)
  static const background = Color(0xFF0B1B3A);

  // 카드/기본 표면
  static const surface = Colors.white;

  // 카드 테두리(연하게)
  static const border = Color(0xFFE5E7EB);

  // 틱택토 판(전체) 배경 (원하면 유지)
  static const boardBg = Colors.white;

  // 네모 칸(타일) 배경(그레이)
  static const cellBg = Color(0xFF4B5563); // 더 진한 회색(흰색처럼 안 보임)

  // 격자선(검정)
  static const gridLine = Colors.black;

  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);

  // X/O 색
  static const xColor = Color(0xFF3B82F6);
  static const oColor = Color(0xFFF97316);
}
