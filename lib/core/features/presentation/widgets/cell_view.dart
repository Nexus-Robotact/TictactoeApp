import 'package:flutter/material.dart';

import '../../../theme/app_text_style.dart';
import '../../domain/entities/player.dart';

class CellView extends StatelessWidget {
  final Player? value;
  final VoidCallback onTap;
  final bool enabled;

  // 칸 배경(일반=그레이, 승리 시=애니메이션 컬러)
  final Color backgroundColor;

  // X/O 텍스트 색
  final Color symbolColor;

  const CellView({
    super.key,
    required this.value,
    required this.onTap,
    required this.enabled,
    required this.backgroundColor,
    required this.symbolColor,
  });

  @override
  Widget build(BuildContext context) {
    final symbol = value?.symbol ?? '';

    return SizedBox.expand(
      child: ColoredBox(
        color: backgroundColor,
        child: Listener(
          behavior: HitTestBehavior.opaque,
          onPointerDown: enabled ? (_) => onTap() : null,
          child: Center(
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 120),
              switchInCurve: Curves.easeOutBack,
              switchOutCurve: Curves.easeIn,
              transitionBuilder: (child, anim) {
                return ScaleTransition(
                  scale: Tween(begin: 0.78, end: 1.0).animate(anim),
                  child: FadeTransition(opacity: anim, child: child),
                );
              },
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: Text(
                    symbol,
                    key: ValueKey(symbol),
                    style: AppTextStyle.cell.copyWith(color: symbolColor),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
