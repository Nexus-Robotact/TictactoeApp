import 'package:flutter/material.dart';
import 'package:flutter/animation.dart';

import '../../../theme/app_colors.dart';
import '../../domain/entities/board.dart';
import '../../domain/entities/game_status.dart';
import '../../domain/entities/player.dart';
import 'cell_view.dart';

class BoardView extends StatefulWidget {
  final Board board;
  final void Function(int index) onTap;
  final bool enabled;

  // ✅ 승리한 3칸
  final List<int> winningLine;

  // ✅ 현재 상태(누가 이겼는지)
  final GameStatus status;

  const BoardView({
    super.key,
    required this.board,
    required this.onTap,
    required this.enabled,
    required this.winningLine,
    required this.status,
  });

  @override
  State<BoardView> createState() => _BoardViewState();
}

class _BoardViewState extends State<BoardView> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _t;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    _t = CurvedAnimation(
        parent: _controller,
        curve: Curves.easeInOutCubic);
  }

  //easeOutCubic-> 더 부드럽게 InOut 으로 변경

  @override
  void didUpdateWidget(covariant BoardView oldWidget) {
    super.didUpdateWidget(oldWidget);

    final hadWin = oldWidget.winningLine.isNotEmpty &&
        (oldWidget.status == GameStatus.xWon || oldWidget.status == GameStatus.oWon);

    final hasWin = widget.winningLine.isNotEmpty &&
        (widget.status == GameStatus.xWon || widget.status == GameStatus.oWon);

    //  새로 승리 발생하면 애니메이션 실행
    if (!hadWin && hasWin) {
      _controller.forward(from: 0);
    }

    //  리셋되면 애니메이션 초기화
    if (oldWidget.status != GameStatus.playing && widget.status == GameStatus.playing) {
      _controller.reset();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color? _targetHighlight() {
    if (widget.status == GameStatus.xWon) return AppColors.xWinHighlight;
    if (widget.status == GameStatus.oWon) return AppColors.oWinHighlight;
    return null;
  }

  @override
  Widget build(BuildContext context) {
    const radius = 22.0;
    const gridStroke = 8.0;

    final target = _targetHighlight();

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
          color: AppColors.boardBg,
          child: Stack(
            children: [
              //  1) 타일
              Positioned.fill(
                child: AnimatedBuilder(
                  animation: _controller,
                  builder: (context, _) {
                    return GridView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.zero,
                      itemCount: 9,
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 3,
                      ),
                      itemBuilder: (context, index) {
                        final isWinCell = widget.winningLine.contains(index);
                        final base = AppColors.cellBg;

                        //  승리한 3칸만 lerp로 색 변화
                        final bg = (isWinCell && target != null)
                            ? Color.lerp(base, target, _t.value) ?? base
                            : base;

                        final value = widget.board.at(index);
                        final symbolColor = value == Player.o ? AppColors.oColor : AppColors.xColor;

                        return CellView(
                          value: value,
                          enabled: widget.enabled,
                          onTap: () => widget.onTap(index),
                          backgroundColor: bg,
                          symbolColor: symbolColor,
                        );
                      },
                    );
                  },
                ),
              ),

              // 2) 격자선(위에 덮기 + 터치 방해 X)
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

    canvas.drawLine(Offset(thirdW, 0), Offset(thirdW, size.height), paint);
    canvas.drawLine(Offset(thirdW * 2, 0), Offset(thirdW * 2, size.height), paint);

    canvas.drawLine(Offset(0, thirdH), Offset(size.width, thirdH), paint);
    canvas.drawLine(Offset(0, thirdH * 2), Offset(size.width, thirdH * 2), paint);
  }

  @override
  bool shouldRepaint(covariant _GridPainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.strokeWidth != strokeWidth;
  }
}
