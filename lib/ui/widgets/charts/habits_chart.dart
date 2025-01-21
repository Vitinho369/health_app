// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:fl_chart/fl_chart.dart';
// import 'package:flutter/material.dart';

// class HabitsChart extends StatelessWidget {
//   final List<Map<String, dynamic>> habits;

//   const HabitsChart({Key? key, required this.habits}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     // Calcular o valor máximo de água (ou qualquer outra variável)
//     final maxWaterQtd = habits.fold<int>(
//       0,
//       (prev, habit) => (habit['water'] ?? 0) > prev ? habit['water'] : prev,
//     );

//     // Mapeia os dados para o gráfico
//     final barData = habits.map((habit) {
//       final timestamp = habit['timestamp'] as Timestamp;
//       final date = timestamp.toDate();
//       final waterQtd =
//           habit['water'] ?? 0; // Exemplo de dados: quantidade de água

//       return BarChartGroupData(
//         x: date.day, // Usa o dia como eixo X
//         barRods: [
//           BarChartRodData(
//             toY: waterQtd.toDouble(), // Valor no eixo Y
//             color: Colors.blue,
//           ),
//         ],
//       );
//     }).toList();

//     return BarChart(
//       BarChartData(
//         alignment: BarChartAlignment.spaceAround,
//         maxY: maxWaterQtd.toDouble(), // Ajuste dinâmico do valor máximo
//         barGroups: barData,
//         titlesData: FlTitlesData(
//           leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: true)),
//           bottomTitles: AxisTitles(
//             sideTitles: SideTitles(
//               showTitles: true,
//               getTitlesWidget: (value, meta) {
//                 final date = DateTime(
//                     2022, 1, value.toInt()); // Exemplo fixo de ano e mês
//                 return Text(
//                   "${date.month}/${date.day}",
//                   style: const TextStyle(
//                     color: Colors.black,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 );
//               },
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
