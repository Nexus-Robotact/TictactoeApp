import 'package:flutter/foundation.dart';

import '../domain/services/winner_checker.dart';
import '../domain/usecases/make_move.dart';
import '../domain/usecases/reset_game.dart';
import 'tictactoe_state.dart';

class TicTacToeController extends ChangeNotifier {
  final ResetGame _resetGame = ResetGame();
  late final MakeMove _makeMove = MakeMove(WinnerChecker());

  TicTacToeState _state = TicTacToeState.initial();
  TicTacToeState get state => _state;

  void onCellTap(int index) {
    final result = _makeMove(
      board: _state.board,
      nextPlayer: _state.nextPlayer,
      status: _state.status,
      index: index,
    );

    _state = _state.copyWith(
      board: result.board,
      nextPlayer: result.nextPlayer,
      status: result.status,
      winningLine: result.winningLine,
    );

    notifyListeners();
  }

  void reset() {
    final result = _resetGame();
    _state = _state.copyWith(
      board: result.board,
      nextPlayer: result.nextPlayer,
      status: result.status,
      winningLine: result.winningLine,
    );
    notifyListeners();
  }
}
