import 'package:flutter/material.dart';
import 'package:health_app/ui/widgets/goal_card.dart';
import 'package:health_app/ui/widgets/progress_indicator.dart';

class GoalsPage extends StatelessWidget {
  const GoalsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            GoalCard(title: "Meta de atividade física", progress: 0.9),
            // // Meta de Atividade Física
            // Card(
            //   margin: const EdgeInsets.only(bottom: 16.0),
            //   elevation: 5,
            //   child: ListTile(
            //     title: const Text("Meta de Atividade Física"),
            //     subtitle: const Text("7 dias consecutivos de exercício"),
            //     trailing:
            //         ProgressIndicatorGoal(progress: 0.6), // Progresso da meta
            //   ),
            // ),
            // // Meta de Ingestão de Água
            // Card(
            //   margin: const EdgeInsets.only(bottom: 16.0),
            //   elevation: 5,
            //   child: ListTile(
            //     title: const Text("Meta de Ingestão de Água"),
            //     subtitle: const Text("2 litros por dia"),
            //     trailing:
            //         ProgressIndicatorGoal(progress: 0.8), // Progresso da meta
            //   ),
            // ),
            // // Meta de Sono
            // Card(
            //   margin: const EdgeInsets.only(bottom: 16.0),
            //   elevation: 5,
            //   child: ListTile(
            //     title: const Text("Meta de Sono"),
            //     subtitle: const Text("8 horas de sono por noite"),
            //     trailing:
            //         ProgressIndicatorGoal(progress: 0.4), // Progresso da meta
            //   ),
            // ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Adicionar nova meta
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
