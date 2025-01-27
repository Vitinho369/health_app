import 'package:flutter/material.dart';

class TextAnimation extends StatelessWidget {
  bool textComplete;
  TextAnimation({super.key, required this.textComplete});

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(seconds: 2), // Duração da animação
      child: textComplete
          ? const Text(
              "Parabéns, você completou a meta diária!",
              key: ValueKey<int>(
                  1), // Usar uma chave única para que o Flutter entenda que é um novo widget
              textAlign: TextAlign.center,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
