import '../entities/board.dart';
import '../entities/game_status.dart';
import '../entities/player.dart';

class WinCheckResult {
  final GameStatus status;
  final List<int> winningLine;

  const WinCheckResult({
    required this.status,
    required this.winningLine,
  });
}

class WinnerChecker {
  static const _lines = <List<int>>[
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  WinCheckResult check(Board board) {
    for (final line in _lines) {
      final a = board.at(line[0]);
      final b = board.at(line[1]);
      final c = board.at(line[2]);

      if (a != null && a == b && b == c) {
        return WinCheckResult(
          status: a == Player.x ? GameStatus.xWon : GameStatus.oWon,
          winningLine: line,
        );
      }
    }

    if (board.isFull) {
      return const WinCheckResult(status: GameStatus.draw, winningLine: []);
    }

    return const WinCheckResult(status: GameStatus.playing, winningLine: []);
  }
}
