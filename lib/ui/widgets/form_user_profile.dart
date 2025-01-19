import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_app/model/habits.dart';
import 'package:health_app/model/profile.dart';
import 'package:health_app/services/firebase/firestore_service.dart';
import 'package:health_app/ui/pages/user_profile_page.dart';
import 'package:health_app/ui/widgets/custom_button.dart';
import 'package:health_app/ui/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class FormUserProfile extends StatefulWidget {
  FormUserProfile({super.key});

  @override
  State<FormUserProfile> createState() => _FormUserProfileState();
}

class _FormUserProfileState extends State<FormUserProfile> {
  final TextEditingController _pesoController = TextEditingController();

  final TextEditingController _alturaController = TextEditingController();

  final TextEditingController _idadeController = TextEditingController();

  final TextEditingController _metaController = TextEditingController();

  late final firestoreService;

  @override
  void initState() {
    super.initState();
    firestoreService =
        Provider.of<CloudFiretoreService>(context, listen: false);
  }

  void sendProfile() async {
    print("enviando profile");

    if (_pesoController.text.isNotEmpty &&
        _alturaController.text.isNotEmpty &&
        _idadeController.text.isNotEmpty &&
        _metaController.text.isNotEmpty) {
      UserProfileModel userProfileModel = UserProfileModel(
          weigth: double.parse(_pesoController.text),
          height: double.parse(_alturaController.text),
          age: int.parse(_idadeController.text),
          goals: _metaController.text);

      await firestoreService.addHabit(Habits(
          exercise: "exercise",
          timeExercise: 12,
          waterQtd: 14,
          sleepDuration: 12));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: firestoreService.getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
            _pesoController.text = userData['weigth'].toString();
            _alturaController.text = userData['height'].toString();
            _idadeController.text = userData['age'].toString();
            _metaController.text = userData['goals'];
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
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
                CustomButton(
                    height: 70, text: "Enviar Dados", onClick: sendProfile),
              ],
            ),
          );
        });
  }
}
