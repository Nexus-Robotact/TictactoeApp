import '../entities/board.dart';
import '../entities/game_status.dart';
import '../entities/player.dart';

class ResetResult {
  final Board board;
  final Player nextPlayer;
  final GameStatus status;
  final List<int> winningLine;

  const ResetResult({
    required this.board,
    required this.nextPlayer,
    required this.status,
    required this.winningLine,
  });
}

class ResetGame {
  ResetResult call() {
    return ResetResult(
      board: Board.empty(),
      nextPlayer: Player.x,
      status: GameStatus.playing,
      winningLine: const [],
    );
  }
}
