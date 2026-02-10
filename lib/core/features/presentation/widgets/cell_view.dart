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
      child: ColoredBox(
        color: AppColors.cellBg, //  네모 칸 배경(그레이)
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: enabled ? onTap : null,
            splashColor: Colors.black.withOpacity(0.04),
            highlightColor: Colors.black.withOpacity(0.03),
            child: Center(
              child: AnimatedSwitcher(
                duration: const Duration(milliseconds: 140),
                switchInCurve: Curves.easeOutBack,
                switchOutCurve: Curves.easeIn,
                transitionBuilder: (child, anim) {
                  return ScaleTransition(
                    scale: Tween(begin: 0.75, end: 1.0).animate(anim),
                    child: FadeTransition(opacity: anim, child: child),
                  );
                },
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
    );
  }
}
