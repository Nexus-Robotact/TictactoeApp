import 'package:flutter/material.dart';

import '../../../theme/app_text_style.dart';
import '../../application/tictactoe_state.dart';
import '../../domain/entities/game_status.dart';
import '../../domain/entities/player.dart';

class StatusBar extends StatelessWidget {
  final TicTacToeState state;

  const StatusBar({super.key, required this.state});

  String _statusText() {
    switch (state.status) {
      case GameStatus.playing:
        return '${state.nextPlayer == Player.x ? "X" : "O"} 차례입니다';
      case GameStatus.xWon:
        return 'X 승리!';
      case GameStatus.oWon:
        return 'O 승리!';
      case GameStatus.draw:
        return '무승부!';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        child: Row(
          children: [
            const Icon(Icons.sports_esports_outlined),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _statusText(),
                style: AppTextStyle.status,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
