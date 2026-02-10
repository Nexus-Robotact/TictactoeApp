import '../services/winner_checker.dart';
import '../entities/board.dart';
import '../entities/game_status.dart';
import '../entities/player.dart';

class MoveResult {
  final Board board;
  final Player nextPlayer;
  final GameStatus status;

  const MoveResult({
    required this.board,
    required this.nextPlayer,
    required this.status,
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
    // 이미 게임이 끝났으면 무시
    if (status != GameStatus.playing) {
      return MoveResult(board: board, nextPlayer: nextPlayer, status: status);
    }

    // 범위 체크
    if (index < 0 || index > 8) {
      return MoveResult(board: board, nextPlayer: nextPlayer, status: status);
    }

    // 이미 둔 칸이면 무시
    if (board.at(index) != null) {
      return MoveResult(board: board, nextPlayer: nextPlayer, status: status);
    }

    // 수 두기
    final placed = board.place(index, nextPlayer);

    // 승리/무승부 판정
    final nextStatus = _checker.check(placed);

    // 진행중일 때만 턴 변경
    final next =
    nextStatus == GameStatus.playing ? nextPlayer.opposite : nextPlayer;

    return MoveResult(board: placed, nextPlayer: next, status: nextStatus);
  }
}
