import '../entities/board.dart';
import '../entities/game_status.dart';
import '../entities/player.dart';
import '../services/winner_checker.dart';

class MoveResult {
  final Board board;
  final Player nextPlayer;
  final GameStatus status;
  final List<int> winningLine;

  const MoveResult({
    required this.board,
    required this.nextPlayer,
    required this.status,
    required this.winningLine,
  });
}

class MakeMove {
  final WinnerChecker _checker;

  MakeMove(this._checker);

  MoveResult call({
    required Board board,
    required Player nextPlayer,
    required GameStatus status,
    required int index,
  }) {
    // 게임 끝났으면 무시
    if (status != GameStatus.playing) {
      return MoveResult(
        board: board,
        nextPlayer: nextPlayer,
        status: status,
        winningLine: const [],
      );
    }

    if (index < 0 || index > 8) {
      return MoveResult(
        board: board,
        nextPlayer: nextPlayer,
        status: status,
        winningLine: const [],
      );
    }

    // 이미 둔 칸이면 무시
    if (board.at(index) != null) {
      return MoveResult(
        board: board,
        nextPlayer: nextPlayer,
        status: status,
        winningLine: const [],
      );
    }

    // 수 두기
    final placed = board.place(index, nextPlayer);

    // 판정 (승리/무승부 + winningLine)
    final check = _checker.check(placed);

    // 진행중일 때만 턴 변경
    final next =
    check.status == GameStatus.playing ? nextPlayer.opposite : nextPlayer;

    return MoveResult(
      board: placed,
      nextPlayer: next,
      status: check.status,
      winningLine: check.winningLine,
    );
  }
}
