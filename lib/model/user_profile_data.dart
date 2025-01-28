import 'package:health_app/model/habits.dart';

class UserProfileData {
  String email;
  List<Habits> habits;
  double? weigth;
  double? height;
  int? age;
  String? goals;
  double progressPhisycalAtivity;
  double progressWaterIngest;
  double progressSleep;
  double progressAliementation;
  bool? textComplete;

  UserProfileData(
      {required this.email,
      required this.habits,
      required this.weigth,
      required this.height,
      required this.age,
      required this.goals,
      required this.progressPhisycalAtivity,
      required this.progressWaterIngest,
      required this.progressSleep,
      required this.progressAliementation,
      required this.textComplete});

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'habits': habits.map((habit) => habit.toJson()).toList(),
      'weigth': weigth,
      'height': height,
      'age': age,
      'goals': goals,
      'progressPhisycalAtivity': progressPhisycalAtivity,
      'progressWaterIngest': progressWaterIngest,
      'progressSleep': progressSleep,
      'progressAliementation': progressAliementation,
      'textComplete': textComplete,
    };
  }

  factory UserProfileData.fromJson(Map<String, dynamic> json) {
    return UserProfileData(
      email: json['email'],
      habits: (json['habits'] as List<dynamic>)
          .map((habit) => Habits.fromJson(habit))
          .toList(),
      weigth: json['weigth'],
      height: json['height'],
      age: json['age'],
      goals: json['goals'],
      progressPhisycalAtivity: json['progressPhisycalAtivity'],
      progressWaterIngest: json['progressWaterIngest'],
      progressSleep: json['progressSleep'],
      progressAliementation: json['progressAliementation'],
      textComplete: json['textComplete'],
    );
  }
}
