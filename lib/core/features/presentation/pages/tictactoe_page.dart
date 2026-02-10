import 'package:flutter/material.dart';

import '../../application/tictactoe_controller.dart';
import '../../application/tictactoe_state.dart';
import '../../domain/entities/game_status.dart';
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

  bool _endDialogShown = false;

  static const Duration _popupDelay = Duration(milliseconds: 1200);

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

  void _maybeShowEndDialog(TicTacToeState state) {
    if (state.status == GameStatus.playing) {
      _endDialogShown = false;
      return;
    }
    if (_endDialogShown) return;

    _endDialogShown = true;

    Future.delayed(_popupDelay, () async {
      if (!mounted) return;

      final title = switch (state.status) {
        GameStatus.xWon => 'X 승리!',
        GameStatus.oWon => 'O 승리!',
        GameStatus.draw => '무승부!',
        _ => '',
      };

      await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) {
          return AlertDialog(
            title: Text(title),
            content: const Text('리플레이 하기'),
            actions: [
              Padding(
                padding: const EdgeInsets.only(left: 8, right: 8, bottom: 8),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          minimumSize: const Size.fromHeight(56), // ✅ 더 크게
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                        onPressed: () => Navigator.pop(context),
                        child: const Text('닫기'),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: FilledButton(
                        style: FilledButton.styleFrom(
                          minimumSize: const Size.fromHeight(56), // ✅ 더 크게
                          textStyle: const TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w900,
                          ),
                        ),
                        onPressed: () {
                          controller.reset();
                          Navigator.pop(context);
                        },
                        child: const Text('다시하기'),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    const maxContentWidth = 720.0;

    return Scaffold(
      appBar: AppBar(title: const Text('TicTacToe')),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: maxContentWidth),
            child: AnimatedBuilder(
              animation: controller,
              builder: (context, _) {
                final state = controller.state;

                _maybeShowEndDialog(state);

                return Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      StatusBar(state: state),
                      const SizedBox(height: 16),
                      Expanded(
                        child: LayoutBuilder(
                          builder: (context, constraints) {
                            final boardSize =
                            constraints.maxWidth < constraints.maxHeight
                                ? constraints.maxWidth
                                : constraints.maxHeight;

                            return Center(
                              child: SizedBox(
                                width: boardSize,
                                height: boardSize,
                                child: BoardView(
                                  board: state.board,
                                  enabled: state.status == GameStatus.playing,
                                  status: state.status,
                                  winningLine: state.winningLine,
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
