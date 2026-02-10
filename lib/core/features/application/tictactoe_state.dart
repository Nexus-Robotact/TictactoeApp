import '../domain/entities/board.dart';
import '../domain/entities/game_status.dart';
import '../domain/entities/player.dart';

class TicTacToeState {
  final Board board;
  final Player nextPlayer;
  final GameStatus status;

  const TicTacToeState({
    required this.board,
    required this.nextPlayer,
    required this.status,
  });

  factory TicTacToeState.initial() => TicTacToeState(
    board: Board.empty(),
    nextPlayer: Player.x,
    status: GameStatus.playing,
  );

  TicTacToeState copyWith({
    Board? board,
    Player? nextPlayer,
    GameStatus? status,
  }) {
    return TicTacToeState(
      board: board ?? this.board,
      nextPlayer: nextPlayer ?? this.nextPlayer,
      status: status ?? this.status,
    );
  }
}
