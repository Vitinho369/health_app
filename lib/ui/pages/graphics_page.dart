import 'package:flutter/material.dart';
import 'package:health_app/services/firebase/auth_service.dart';
import 'package:health_app/services/firebase/firestore_service.dart';
import 'package:health_app/ui/widgets/charts/bar_chart.dart';
import 'package:health_app/ui/widgets/charts/line_chart.dart';

class GraphicsPage extends StatelessWidget {
  const GraphicsPage(
      {super.key, required this.authService, required this.firestoreService});

  final CloudFiretoreService firestoreService;
  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<Map<String, dynamic>>>(
      stream: firestoreService.getHabitData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text("Erro ao carregar dados."));
        }

        if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return const Center(child: Text("Nenhum hábito encontrado."));
        }

        final habits = snapshot.data!;

        return SingleChildScrollView(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (habits.length > 1)
                  HabitsLineChart(
                    chartTitle: "Quantidade de água por dia",
                    xLabelKey: 'timestamp',
                    yLabelKey: 'water',
                    habits: habits,
                    intervalValues: 100,
                  ),
                HabitsBarChart(
                  chartTitle: "Horas de exercício",
                  yLabelKey: "timeExercise",
                  xLabelKey: "exercise",
                  habits: habits,
                  interval: 20,
                ),
                if (habits.length > 1)
                  HabitsLineChart(
                    chartTitle: "Duração do Sono",
                    xLabelKey: 'timestamp',
                    yLabelKey: 'sleep',
                    habits: habits,
                    intervalValues: 5,
                  ),
                if (habits.length > 1)
                  HabitsLineChart(
                    chartTitle: "Peso",
                    xLabelKey: 'timestamp',
                    yLabelKey: 'weigth',
                    habits: habits,
                    intervalValues: 5,
                  ),
              ],
            ),
          ),
        );
      },
    );
  }
}
