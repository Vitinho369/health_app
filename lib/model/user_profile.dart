import 'package:health_app/model/habits.dart';

class UserProfile {
  final String name;
  final String email;
  final List<Habits> habits;
  final double? weigth;
  final double? height;
  final int? age;
  final String? goals;

  UserProfile(
      {required this.name,
      required this.email,
      required this.habits,
      required this.weigth,
      required this.height,
      required this.age,
      required this.goals});
}
