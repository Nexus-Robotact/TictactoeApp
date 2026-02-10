import 'package:flutter/material.dart';

class ControlBar extends StatelessWidget {
  final VoidCallback onReset;

  const ControlBar({super.key, required this.onReset});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: FilledButton.icon(
            onPressed: onReset,
            icon: const Icon(Icons.refresh),
            label: const Text('Reset'),
          ),
        ),
      ],
    );
  }
}
