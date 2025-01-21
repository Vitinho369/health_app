import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:health_app/ui/widgets/charts/graphics.dart';
import 'package:health_app/ui/widgets/form_habits.dart';

class HabitsPage extends StatelessWidget {
  const HabitsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [const FormHabits()],
        ),
      ),
    );
  }
}
