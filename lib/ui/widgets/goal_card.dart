import 'package:flutter/material.dart';
import 'package:health_app/ui/widgets/progress_indicator.dart';

class GoalCard extends StatelessWidget {
  final String title;
  final double progress;
  final String description;
  final VoidCallback onPressed;

  const GoalCard(
      {super.key,
      required this.title,
      required this.progress,
      required this.description,
      required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.only(bottom: 20.0),
      decoration: BoxDecoration(
        color: progress == 1
            ? const Color.fromARGB(255, 141, 224, 144)
            : Colors.white,
        borderRadius: BorderRadius.circular(8.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.4),
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: ListTile(
              title: Text(title),
              subtitle: Text(description),
              trailing: ProgressIndicatorGoal(progress: progress),
            ),
          ),
          IconButton(
            onPressed: onPressed,
            icon: Icon(Icons.add),
          ),
        ],
      ),
    );
  }
}
