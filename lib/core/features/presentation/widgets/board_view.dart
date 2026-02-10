import 'package:flutter/material.dart';

import '../../domain/entities/board.dart';
import 'cell_view.dart';

class BoardView extends StatelessWidget {
  final Board board;
  final void Function(int index) onTap;

  const BoardView({
    super.key,
    required this.board,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: GridView.builder(
          physics: const NeverScrollableScrollPhysics(),
          itemCount: 9,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 3,
            mainAxisSpacing: 10,
            crossAxisSpacing: 10,
          ),
          itemBuilder: (context, index) {
            return CellView(
              value: board.at(index),
              onTap: () => onTap(index),
            );
          },
        ),
      ),
    );
  }
}
