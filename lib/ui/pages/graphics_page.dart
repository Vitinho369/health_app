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
          //alinhar os widgets no meio

          child: Align(
            alignment: Alignment.center,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text("Olá ${authService.getCurrentUserEmail()}"),
                    ElevatedButton(
                      onPressed: () => {authService.signOut()},
                      child: Icon(Icons.logout_rounded),
                    )
                  ],
                ),
                HabitsLineChart(habits: habits),
                HabitsBarChart(habits: habits),
              ],
            ),
          ),
        );
      },
    );
  }
}
