class UserProfileModel {
  // final String? userEmail;
  final double? weigth;
  final double? height;
  final int? age;
  final String? goals;

  UserProfileModel(
      {required this.weigth,
      required this.height,
      required this.age,
      required this.goals});

  Map<String, dynamic> toMap() {
    return {'weigth': weigth, 'height': height, 'age': age, 'goals': goals};
  }
}
