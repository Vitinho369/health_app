import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HabitsLineChart extends StatelessWidget {
  final List<Map<String, dynamic>> habits;

  const HabitsLineChart({Key? key, required this.habits}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ordenar os dados pelo timestamp
    habits.sort((a, b) => (a['timestamp'] as Timestamp)
        .millisecondsSinceEpoch
        .compareTo((b['timestamp'] as Timestamp).millisecondsSinceEpoch));

    // Mapeia os dados para pontos no gráfico
    final timestamps = habits
        .map((habit) =>
            (habit['timestamp'] as Timestamp).millisecondsSinceEpoch.toDouble())
        .toList();

    final minX = timestamps.reduce((a, b) => a < b ? a : b); // Menor timestamp
    final maxX = timestamps.reduce((a, b) => a > b ? a : b); // Maior timestamp

    final lineData = habits.map((habit) {
      final timestamp = habit['timestamp'] as Timestamp;
      final date = timestamp.millisecondsSinceEpoch.toDouble();

      final waterQtd = habit['water'] ?? 0;

      return FlSpot(date, waterQtd.toDouble());
    }).toList();

    // Determinar os pontos do eixo X (5 rótulos no total)
    final step = (maxX - minX) /
        (habits.length - 1); // Divisão exata em 5 partes (4 intervalos)
    final xAxisValues = List.generate(
      habits.length,
      (index) => minX + (index * step),
    );

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text("Quantidade de água por hábito"),
        SizedBox(
          height: 200,
          width: 300,
          child: LineChart(
            LineChartData(
              gridData: FlGridData(show: true),
              titlesData: FlTitlesData(
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: const AxisTitles(
                    sideTitles: SideTitles(
                        showTitles: true, reservedSize: 40, interval: 100)),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: step, // Mostra apenas os valores correspondentes
                    getTitlesWidget: (value, meta) {
                      if (!xAxisValues.contains(value))
                        return const SizedBox.shrink();
                      final timestamp =
                          Timestamp.fromMillisecondsSinceEpoch(value.toInt());
                      final date = timestamp.toDate();
                      return Text(
                        "${date.day}/${date.month}",
                        style: const TextStyle(fontSize: 10),
                      );
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: true),
              lineBarsData: [
                LineChartBarData(
                  spots: lineData, // Define os pontos do gráfico de linha
                  isCurved: false, // Faz a linha ser curva
                  color: Colors.blue, // Cor da linha
                  dotData:
                      FlDotData(show: true), // Não exibe pontos nas interseções
                ),
              ],
              minX: minX,
              maxX: maxX,
            ),
          ),
        ),
      ],
    );
  }
}
