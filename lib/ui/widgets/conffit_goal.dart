import 'package:confetti/confetti.dart';
import 'package:flutter/material.dart';

class ConffitGoal extends StatelessWidget {
  const ConffitGoal({
    super.key,
    required ConfettiController confettiController,
  }) : _confettiController = confettiController;

  final ConfettiController _confettiController;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: ConfettiWidget(
        confettiController: _confettiController,
        blastDirectionality: BlastDirectionality.explosive,
        shouldLoop: false,
        colors: const [
          Colors.blue,
          Colors.green,
          Colors.red,
          Colors.orange,
          Colors.purple
        ],
        emissionFrequency: 0.05,
        numberOfParticles: 30,
        gravity: 0.2,
      ),
    );
  }
}
