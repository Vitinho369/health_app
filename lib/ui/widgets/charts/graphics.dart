import 'package:flutter/material.dart';
import 'package:health_app/services/firebase/firestore_service.dart';
import 'package:health_app/ui/widgets/charts/habits_chart.dart';
import 'package:provider/provider.dart';

class Graphics extends StatefulWidget {
  const Graphics({super.key});

  @override
  State<Graphics> createState() => _GraphicsState();
}

class _GraphicsState extends State<Graphics> {
  late final firestoreService;

  @override
  void initState() {
    super.initState();
    firestoreService =
        Provider.of<CloudFiretoreService>(context, listen: false);
  }

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

        return Padding(
          padding: const EdgeInsets.all(16.0),
          child: HabitsChart(habits: habits),
        );
      },
    );
  }
}
