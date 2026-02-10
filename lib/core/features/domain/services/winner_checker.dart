import '../entities/board.dart';
import '../entities/game_status.dart';
import '../entities/player.dart';

class WinnerChecker {
  static const _lines = <List<int>>[
    // rows
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    // cols
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    // diagonals
    [0, 4, 8],
    [2, 4, 6],
  ];

  GameStatus check(Board board) {
    for (final line in _lines) {
      final a = board.at(line[0]);
      final b = board.at(line[1]);
      final c = board.at(line[2]);

      if (a != null && a == b && b == c) {
        return a == Player.x ? GameStatus.xWon : GameStatus.oWon;
      }
    }

    if (board.isFull) return GameStatus.draw;
    return GameStatus.playing;
  }
}
