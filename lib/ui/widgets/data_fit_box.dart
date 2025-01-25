import 'package:flutter/material.dart';

class DataFitBox extends StatelessWidget {
  const DataFitBox(
      {super.key,
      required this.title,
      required this.value,
      required this.icon,
      required this.unit});

  final String title;
  final String value;
  final String unit;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Row(
          children: [
            icon,
            const SizedBox(width: 7),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  "${value} ${unit}",
                  style: const TextStyle(
                    fontSize: 16,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
