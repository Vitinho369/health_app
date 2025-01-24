import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HabitsBarChart extends StatelessWidget {
  final List<Map<String, dynamic>> habits;

  const HabitsBarChart({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calcular o valor máximo de horas de exercício
    final maxTime = habits.fold<double>(
      0,
      (prev, habit) => (habit['timeExercise'] ?? 0.0) > prev
          ? habit['timeExercise'].toDouble()
          : prev,
    );

    // Mapeia os dados para o gráfico
    final barData = habits.asMap().entries.map((entry) {
      final index = entry.key;
      final habit = entry.value;
      final timeExercise = (habit['timeExercise'] ?? 0).toDouble();

      return BarChartGroupData(
        x: index, // Índice do exercício usado como posição no eixo X
        barRods: [
          BarChartRodData(
            toY:
                timeExercise.toDouble(), // Valor no eixo Y (horas de exercício)
            color: Colors.blue, // Cor das barras
            width: 20, // Largura da barra
            borderRadius: BorderRadius.circular(4), // Bordas arredondadas
          ),
        ],
      );
    }).toList();

    return Column(
      children: [
        Text("Horas de exercício por hábito"),
        SizedBox(
          height: 200,
          width: 300,
          child: BarChart(
            BarChartData(
              maxY: maxTime > 0
                  ? maxTime + 1
                  : 1, // Ajusta o valor máximo no eixo Y
              barGroups: barData,
              gridData: FlGridData(show: true), // Exibe as linhas de grade
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval: 10,
                    getTitlesWidget: (value, meta) {
                      print(value);
                      return Text(
                        "${value}h", // Exibe as horas no eixo Y
                        style: const TextStyle(fontSize: 12),
                      );
                    },
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    getTitlesWidget: (value, meta) {
                      if (value.toDouble() < habits.length) {
                        final exercise =
                            habits[value.toInt()]['exercise'] ?? '';
                        return Padding(
                          padding: const EdgeInsets.only(top: 8.0),
                          child: Text(
                            exercise,
                            style: const TextStyle(fontSize: 12),
                          ),
                        );
                      }
                      return const SizedBox.shrink();
                    },
                  ),
                ),
                topTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
                rightTitles: const AxisTitles(
                  sideTitles: SideTitles(showTitles: false),
                ),
              ),
              borderData: FlBorderData(show: true),
              alignment:
                  BarChartAlignment.spaceEvenly, // Espaçamento entre as barras
            ),
          ),
        ),
      ],
    );
  }
}
