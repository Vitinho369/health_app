import 'package:flutter/material.dart';
import 'package:health_app/ui/widgets/progress_indicator.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final double progress;

  const GoalCard({super.key, required this.title, required this.progress});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        margin: const EdgeInsets.only(bottom: 16.0),
        elevation: 5,
        child: Row(
          children: [
            ListTile(
              title: Text(title),
              subtitle: Text("7 dias consecutivos de exercício"),
              trailing: ProgressIndicatorGoal(progress: progress),
            ),
            ElevatedButton(onPressed: null, child: Icon(Icons.add)),
          ],
        ),
      ),
    );
  }
}
