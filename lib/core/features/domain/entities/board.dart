import 'player.dart';

class Board {
  final List<Player?> cells; // length 9

  const Board._(this.cells);

  factory Board.empty() => Board._(List<Player?>.filled(9, null));

  Player? at(int index) => cells[index];

  bool get isFull => cells.every((c) => c != null);

  Board place(int index, Player player) {
    final next = List<Player?>.from(cells);
    next[index] = player;
    return Board._(next);
  }
}
