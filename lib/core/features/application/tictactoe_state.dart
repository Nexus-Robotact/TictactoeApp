import '../domain/entities/board.dart';
import '../domain/entities/game_status.dart';
import '../domain/entities/player.dart';

class TicTacToeState {
  final Board board;
  final Player nextPlayer;
  final GameStatus status;
  final List<int> winningLine;

  const TicTacToeState({
    required this.board,
    required this.nextPlayer,
    required this.status,
    required this.winningLine,
  });

  factory TicTacToeState.initial() => TicTacToeState(
    board: Board.empty(),
    nextPlayer: Player.x,
    status: GameStatus.playing,
    winningLine: const [],
  );

  TicTacToeState copyWith({
    Board? board,
    Player? nextPlayer,
    GameStatus? status,
    List<int>? winningLine,
  }) {
    return TicTacToeState(
      board: board ?? this.board,
      nextPlayer: nextPlayer ?? this.nextPlayer,
      status: status ?? this.status,
      winningLine: winningLine ?? this.winningLine,
    );
  }
}
