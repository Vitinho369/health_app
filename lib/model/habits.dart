import 'package:cloud_firestore/cloud_firestore.dart';

class Habits {
  final String? exercise;
  final int? timeExercise;
  final int? waterQtd;
  final int? sleepDuration;
  final double? weigth;
  final DateTime? date;
  Timestamp timestamp;

  Habits(
      {required this.exercise,
      required this.timeExercise,
      required this.waterQtd,
      required this.sleepDuration,
      required this.weigth,
      required this.date,
      required this.timestamp});

  Map<String, dynamic> toJson() {
    print("timestamp: ${timestamp.millisecondsSinceEpoch}");
    return {
      'exercise': exercise,
      'timeExercise': timeExercise,
      'water': waterQtd,
      'sleepDuration': sleepDuration,
      'weigth': weigth,
      'date': date.toString(),
      'timestamp': timestamp.millisecondsSinceEpoch
    };
  }

  factory Habits.fromJson(Map<String, dynamic> json) {
    print("é string: ${json['timestamp'] is String}");
    print(json['timestamp']);
    return Habits(
        exercise: json['exercise'],
        timeExercise: json['timeExercise'],
        waterQtd: json['water'],
        sleepDuration: json['sleepDuration'],
        weigth: json['weigth'],
        date: DateTime.parse(json['date'].toString()),
        timestamp: Timestamp.fromMillisecondsSinceEpoch(json['timestamp']));
  }
}
