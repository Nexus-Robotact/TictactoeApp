enum Player { x, o }

extension PlayerX on Player {
  Player get opposite => this == Player.x ? Player.o : Player.x;
  String get symbol => this == Player.x ? 'X' : 'O';
}
