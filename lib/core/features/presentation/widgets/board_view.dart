import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../domain/entities/board.dart';
import 'cell_view.dart';

class BoardView extends StatelessWidget {
  final Board board;
  final void Function(int index) onTap;

  /// 게임 진행 중이면 true
  final bool enabled;

  const BoardView({
    super.key,
    required this.board,
    required this.onTap,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    const radius = 22.0;
    const gridStroke = 8.0;

    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(radius),
        boxShadow: const [
          BoxShadow(
            blurRadius: 18,
            offset: Offset(0, 10),
            color: Color(0x14000000),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(radius),
        child: Material(
          color: AppColors.boardBg, // 판 바닥색
          child: Stack(
            children: [
              // 1) 먼저 9칸 타일을 깐다 (타일 배경=회색은 CellView가 담당)
              Positioned.fill(
                child: GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  padding: EdgeInsets.zero,
                  itemCount: 9,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                  ),
                  itemBuilder: (context, index) {
                    return CellView(
                      value: board.at(index),
                      enabled: enabled,
                      onTap: () => onTap(index),
                    );
                  },
                ),
              ),

              // 2) 그 위에 격자선(검정)을 그린다 (터치 안 막게 IgnorePointer)
              Positioned.fill(
                child: IgnorePointer(
                  child: CustomPaint(
                    painter: _GridPainter(
                      color: AppColors.gridLine,
                      strokeWidth: gridStroke,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  final Color color;
  final double strokeWidth;

  const _GridPainter({
    required this.color,
    required this.strokeWidth,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = strokeWidth
      ..strokeCap = StrokeCap.round;

    final thirdW = size.width / 3;
    final thirdH = size.height / 3;

    // 세로 2줄
    canvas.drawLine(Offset(thirdW, 0), Offset(thirdW, size.height), paint);
    canvas.drawLine(Offset(thirdW * 2, 0), Offset(thirdW * 2, size.height), paint);

    // 가로 2줄
    canvas.drawLine(Offset(0, thirdH), Offset(size.width, thirdH), paint);
    canvas.drawLine(Offset(0, thirdH * 2), Offset(size.width, thirdH * 2), paint);
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
