import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class HabitsBarChart extends StatelessWidget {
  final String chartTitle;
  final String xLabelKey;
  final String yLabelKey;
  final List<Map<String, dynamic>> habits;
  final double interval;

  const HabitsBarChart(
      {Key? key,
      required this.chartTitle,
      required this.xLabelKey,
      required this.yLabelKey,
      required this.habits,
      required this.interval})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Calcular o valor máximo do eixo Y
    final maxY = habits.fold<double>(
      0,
      (prev, item) =>
          (item[yLabelKey] ?? 0.0) > prev ? item[yLabelKey].toDouble() : prev,
    );

    // Mapeia os dados para o gráfico
    final barData = habits.asMap().entries.map((entry) {
      final index = entry.key;
      final item = entry.value;
      final yValue = (item[yLabelKey] ?? 0).toDouble();

      return BarChartGroupData(
        x: index, // Índice do item usado como posição no eixo X
        barRods: [
          BarChartRodData(
            toY: yValue, // Valor no eixo Y
            color: Colors.blue, // Cor das barras
            width: 20, // Largura da barra
            borderRadius: BorderRadius.circular(4), // Bordas arredondadas
          ),
        ],
      );
    }).toList();

    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 10),
      padding: const EdgeInsets.all(8.0),
      width: 325,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Column(
        children: [
          Text(chartTitle),
          SizedBox(
            height: 200,
            width: 300,
            child: BarChart(
              BarChartData(
                maxY:
                    maxY > 0 ? maxY + 1 : 1, // Ajusta o valor máximo no eixo Y
                barGroups: barData,
                gridData: FlGridData(show: true), // Exibe as linhas de grade
                titlesData: FlTitlesData(
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 40,
                      interval: interval,
                      getTitlesWidget: (value, meta) {
                        return Text(
                          "${value.toInt()}",
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
                          final label = habits[value.toInt()][xLabelKey] ?? '';
                          return Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Text(
                              label,
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
                alignment: BarChartAlignment
                    .spaceEvenly, // Espaçamento entre as barras
              ),
            ),
          ),
        ],
      ),
    );
  }
}
