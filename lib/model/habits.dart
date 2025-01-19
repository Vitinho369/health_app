class Habits {
  final String? exercise;
  final int? timeExercise;

  final int? waterQtd;
  final int? sleepDuration;

  Habits(
      {required this.exercise,
      required this.timeExercise,
      required this.waterQtd,
      required this.sleepDuration});

  Map<String, dynamic> toMap() {
    return {
      'exercise': exercise,
      'timeExercise': timeExercise,
      'water': waterQtd,
      'sleepDuration': sleepDuration
    };
  }
}
