import 'package:flutter/material.dart';
import 'package:health_app/services/firebase/auth_service.dart';
import 'package:health_app/ui/pages/home_page.dart';
import 'package:health_app/ui/pages/login_page.dart';
import 'package:provider/provider.dart';

class AuthChecker extends StatelessWidget {
  const AuthChecker({super.key});

  @override
  Widget build(BuildContext context) {
    AuthService authService = Provider.of<AuthService>(context, listen: true);
    return Scaffold(
      body: authService.permissionLogin ? const HomePage() : const LoginPage(),
    );
  }
}
