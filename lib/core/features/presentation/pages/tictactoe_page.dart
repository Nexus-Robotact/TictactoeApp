import 'package:flutter/material.dart';

import '../../application/tictactoe_controller.dart';
import '../widgets/board_view.dart';
import '../widgets/control_bar.dart';
import '../widgets/status_bar.dart';

class TicTacToePage extends StatefulWidget {
  const TicTacToePage({super.key});

  @override
  State<TicTacToePage> createState() => _TicTacToePageState();
}

class _TicTacToePageState extends State<TicTacToePage> {
  late final TicTacToeController controller;

  @override
  void initState() {
    super.initState();
    controller = TicTacToeController();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    const maxContentWidth = 720.0;

    return Scaffold(
      appBar: AppBar(
        title: const Text('TicTacToe'),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                final state = controller.state;

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      StatusBar(state: state),
                      const SizedBox(height: 16),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final w = constraints.maxWidth;
                            final h = constraints.maxHeight;
                            final boardSize = w < h ? w : h;

                            return Center(
                              child: SizedBox(
                                width: boardSize,
                                height: boardSize,
                                child: BoardView(
                                  board: state.board,
                                  onTap: controller.onCellTap,
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(height: 16),
                      ControlBar(onReset: controller.reset),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
