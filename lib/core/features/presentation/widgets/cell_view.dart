import 'package:flutter/material.dart';

import '../../../theme/app_colors.dart';
import '../../../theme/app_text_style.dart';
import '../../domain/entities/player.dart';

class CellView extends StatelessWidget {
  final Player? value;
  final VoidCallback onTap;

  const CellView({
    super.key,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final symbol = value?.symbol ?? '';
    final color = value == Player.o ? AppColors.oColor : AppColors.xColor;

    return Material(
      color: Colors.white,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
        borderRadius: BorderRadius.circular(14),
        onTap: onTap,
        child: Center(
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              symbol,
              style: AppTextStyle.cell.copyWith(color: color),
            ),
          ),
        ),
      ),
    );
  }
}
