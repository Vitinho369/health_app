import 'package:flutter/material.dart';
import 'package:health_app/model/profile.dart';
import 'package:health_app/services/firebase/auth_service.dart';
import 'package:health_app/services/firebase/firestore_service.dart';
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
  final TextEditingController _pesoController = TextEditingController();

  final TextEditingController _alturaController = TextEditingController();

  final TextEditingController _idadeController = TextEditingController();

  final TextEditingController _metaController = TextEditingController();

  late final firestoreService;

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

      await authService.signInWithEmailAndPassword(
          emailController.value.text, passwordController.value.text);

      UserProfileModel userProfileModel = UserProfileModel(
          weigth: double.parse(_pesoController.text),
          height: double.parse(_alturaController.text),
          age: int.parse(_idadeController.text),
          goals: _metaController.text);

      await firestoreService.addUserProfile(userProfileModel);
      Navigator.pushReplacementNamed(context, '/');
    } on Exception catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(e.toString()),
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    firestoreService =
        Provider.of<CloudFiretoreService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    final AuthService authService =
        Provider.of<AuthService>(context, listen: true);
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 50),
              Text(
                "Cadastro",
                style: TextStyle(
                  fontSize: Theme.of(context).textTheme.bodyLarge!.fontSize,
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                labelText: "Email",
                controller: emailController,
              ),
              const SizedBox(height: 10),
              CustomTextFormField(
                  labelText: "Peso",
                  controller: _pesoController,
                  keyboardType: TextInputType.number),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                labelText: "Altura",
                controller: _alturaController,
                keyboardType: TextInputType.number,
              ),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                  labelText: "Idade",
                  controller: _idadeController,
                  keyboardType: TextInputType.number),
              const SizedBox(
                height: 10,
              ),
              CustomTextFormField(
                  labelText: "Meta", controller: _metaController),
              const SizedBox(
                height: 10,
              ),
              InputPassword(
                labelText: "Senha",
                controller: passwordController,
              ),
              const SizedBox(height: 10),
              InputPassword(
                labelText: "Confirmar Senha",
                controller: rePasswordController,
              ),
              if (!authService.register_sucess)
                Text(
                  "Erro ao cadastrar",
                  style: TextStyle(color: Colors.red),
                ),
              CustomButton(
                text: "Cadastrar",
                height: 100,
                onClick: () => signUp(authService),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
