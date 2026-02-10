import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';
import '../../domain/entities/player.dart';

class CellView extends StatelessWidget {
  final Player? value;
  final VoidCallback onTap;
  final bool enabled;

  const CellView({
    super.key,
    required this.value,
    required this.onTap,
    required this.enabled,
  });

  @override
  Widget build(BuildContext context) {
    final symbol = value?.symbol ?? '';
    final color = value == Player.o ? AppColors.oColor : AppColors.xColor;

    return SizedBox.expand(
      child: Listener(
        behavior: HitTestBehavior.opaque,
        // ✅ 누르는 순간 바로 실행 (손 떼기 기다리지 않음)
        onPointerDown: enabled ? (_) => onTap() : null,
        child: ColoredBox(
          color: AppColors.cellBg, // 네모 칸 배경(진회색 등)
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
                    style: AppTextStyle.cell.copyWith(color: color),
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
