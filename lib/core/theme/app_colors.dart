import 'package:flutter/material.dart';

class AppColors {
  // 앱 배경(남색)
  static const background = Color(0xFF0B1B3A);

  // 카드/기본 표면
  static const surface = Colors.white;

  // 카드 테두리(연하게)
  static const border = Color(0xFFE5E7EB);

  // 틱택토 판(전체) 배경
  static const boardBg = Colors.white;

  // 네모 칸(타일) 배경(진한 그레이)
  static const cellBg = Color(0xFF4B5563);

  // 격자선(검정)
  static const gridLine = Colors.black;

  // 승리 하이라이트(연하게)
  // X 승리 시: 연한 빨강
  static const xWinHighlight = Color(0xFFFFCC80);
  // O 승리 시: 연한 파랑
  static const oWinHighlight = Color(0xFFBBDEFB);

  static const textPrimary = Color(0xFF111827);
  static const textSecondary = Color(0xFF6B7280);

  // X/O 색 (요구대로 그대로 유지)
  static const xColor = Color(0xFFF97316);
  static const oColor = Color(0xFF3B82F6);
}
