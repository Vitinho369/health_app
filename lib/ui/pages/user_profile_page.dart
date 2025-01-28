import 'package:flutter/material.dart';
import 'package:health_app/services/firebase/auth_service.dart';
import 'package:health_app/ui/widgets/form_user_profile.dart';

class UserProfile extends StatelessWidget {
  const UserProfile({super.key, required this.authService});

  final AuthService authService;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Icon(Icons.monitor_heart_outlined,
                    size: 90, color: Theme.of(context).colorScheme.primary),
                Text(
                  "Olá ${authService.getCurrentUserEmail()}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            FormUserProfile(),
          ],
        ),
      ),
    );
  }
}
