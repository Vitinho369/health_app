import 'package:flutter/material.dart';
import 'package:health_app/services/firebase/auth_service.dart';
import 'package:health_app/ui/widgets/custom_button.dart';
import 'package:health_app/ui/widgets/custom_text_form_field.dart';
import 'package:health_app/ui/widgets/form_user_profile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, required this.authService});

  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Olá ${authService.getCurrentUserEmail()}"),
              ElevatedButton(
                onPressed: () => {authService.signOut()},
                child: Icon(Icons.logout_rounded),
              )
            ],
          ),
          FormUserProfile(),
        ],
      ),
    );
  }
}
