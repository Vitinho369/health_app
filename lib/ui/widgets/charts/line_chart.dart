import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HabitsLineChart extends StatelessWidget {
  final String chartTitle;
  final String xLabelKey;
  final String yLabelKey;
  final List<Map<String, dynamic>> habits;
  final double intervalValues;

  const HabitsLineChart(
      {Key? key,
      required this.chartTitle,
      required this.xLabelKey,
      required this.yLabelKey,
      required this.habits,
      required this.intervalValues})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ordena os dados com base no timestamp
    habits.sort((a, b) => (a[xLabelKey] as Timestamp)
        .millisecondsSinceEpoch
        .compareTo((b[xLabelKey] as Timestamp).millisecondsSinceEpoch));

    // Pega os timestamps e converte para valores de double para o gráfico
    final timestamps = habits
        .map((habit) =>
            (habit[xLabelKey] as Timestamp).millisecondsSinceEpoch.toDouble())
        .toList();

    final minX = timestamps.reduce((a, b) => a < b ? a : b); // Menor timestamp
    final maxX = timestamps.reduce((a, b) => a > b ? a : b); // Maior timestamp

    final minY = habits
        .map((habit) =>
            habit[yLabelKey] != null ? habit[yLabelKey].toDouble() : 0.0)
        .reduce((a, b) => a < b ? a : b); // Menor valor de Y
    final maxY = habits
        .map((habit) =>
            habit[yLabelKey] != null ? habit[yLabelKey].toDouble() : 0.0)
        .reduce((a, b) => a > b ? a : b); // Maior valor de Y

    final lineData = habits.map((habit) {
      final timestamp = habit[xLabelKey] as Timestamp;
      final date = timestamp.millisecondsSinceEpoch.toDouble();
      final yValue =
          habit[yLabelKey] != null ? habit[yLabelKey].toDouble() : 0.0;

      return FlSpot(date, yValue); // Certificando-se que ambos são doubles
    }).toList();

    final step = (maxX - minX) /
        (habits.length - 1); // Calcular o passo com base no número de pontos

    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(chartTitle),
        SizedBox(
          height: 200,
          width: 300,
          child: LineChart(
            LineChartData(
              gridData: const FlGridData(show: true),
              titlesData: FlTitlesData(
                topTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                rightTitles:
                    const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    reservedSize: 40,
                    interval:
                        intervalValues, // Manter o intervalo de valores no eixo Y
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval:
                        step, // Definir intervalo de acordo com o número de pontos
                    getTitlesWidget: (value, meta) {
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
                  spots: lineData,
                  isCurved: false,
                  color: Colors.blue,
                  dotData: const FlDotData(show: true),
                ),
              ],
              minX: minX,
              maxX: maxX,
              minY: minY,
              maxY: maxY,
            ),
          ),
        ),
      ],
    );
  }
}
