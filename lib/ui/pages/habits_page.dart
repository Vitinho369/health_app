import 'package:flutter/material.dart';
import 'package:health_app/ui/widgets/form_habits.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            SizedBox(height: 60),
            FormHabits(),
            SizedBox(height: 20), // Espaçamento entre os widgets
            // Graphics(),
          ],
        ),
      ),
    );
  }
}
