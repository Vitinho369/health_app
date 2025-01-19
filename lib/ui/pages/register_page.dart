import 'package:flutter/material.dart';
import 'package:health_app/services/firebase/auth_service.dart';
import 'package:health_app/ui/widgets/input_password.dart';
import 'package:health_app/ui/widgets/custom_text_form_field.dart';

import 'package:provider/provider.dart';

import '../widgets/custom_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key, this.onTap});

  final void Function()? onTap;

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final rePasswordController = TextEditingController();

  void signUp(AuthService authService) async {
    if (passwordController.value.text != rePasswordController.value.text) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("As senhas não coincidem."),
        ),
      );
      return;
    }

    try {
      await authService.signUpWithEmailAndPassword(
          emailController.value.text, passwordController.value.text);
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService =
        Provider.of<AuthService>(context, listen: true);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.chat_outlined,
              size: 150,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),
            Text(
              "Vamos criar uma nova conta!",
              style: TextStyle(
                fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                color: Theme.of(context).colorScheme.primary,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextFormField(
              labelText: "Usuário",
              controller: emailController,
            ),
            const SizedBox(height: 10),
            InputPassword(
              labelText: "Senha",
              controller: passwordController,
            ),
            const SizedBox(height: 10),
            InputPassword(
              labelText: "Confirmar Senha",
              controller: rePasswordController,
            ),
            CustomButton(
              text: "Cadastrar",
              height: 100,
              onClick: () => signUp(authService),
            ),
            if (!authService.register_sucess)
              Text(
                "Erro ao cadastrar",
                style: TextStyle(color: Colors.red),
              ),
          ],
        ),
      ),
    );
  }
}
