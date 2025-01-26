import 'package:flutter/material.dart';

class ProgressIndicatorGoal extends StatelessWidget {
  final double progress;

  const ProgressIndicatorGoal({Key? key, required this.progress})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 50,
      height: 50,
      child: CircularProgressIndicator(
        value: progress,
        backgroundColor: Colors.grey[300],
        valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
      ),
    );
  }
}
