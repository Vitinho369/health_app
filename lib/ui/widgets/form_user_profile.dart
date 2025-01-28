import 'package:flutter/material.dart';
import 'package:health_app/model/profile.dart';
import 'package:health_app/model/user_profile_data.dart';
import 'package:health_app/services/app/shared_preferences_service.dart';
import 'package:health_app/services/firebase/firestore_service.dart';
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

  late final SharedPreferencesService _sharedPreferenceService;
  late final CloudFiretoreService firestoreService;

  @override
  void initState() {
    super.initState();
    _sharedPreferenceService =
        Provider.of<SharedPreferencesService>(context, listen: false);

    firestoreService =
        Provider.of<CloudFiretoreService>(context, listen: false);
    _loadUserData();
  }

  void _loadUserData() {
    final user = _sharedPreferenceService.getUser();
    _pesoController.text = user.weigth.toString();
    _alturaController.text = user.height.toString();
    _idadeController.text = user.age.toString();
    _metaController.text = user.goals!;
  }

  void _saveUserData() {
    if (_pesoController.text.isNotEmpty &&
        _alturaController.text.isNotEmpty &&
        _idadeController.text.isNotEmpty &&
        _metaController.text.isNotEmpty) {
      final user = _sharedPreferenceService.getUser();
      final updatedUser = UserProfileData(
        email: user.email,
        habits: user.habits,
        weigth: double.parse(_pesoController.text),
        height: double.parse(_alturaController.text),
        age: int.parse(_idadeController.text),
        goals: _metaController.text,
        progressPhisycalAtivity: user.progressPhisycalAtivity,
        progressWaterIngest: user.progressWaterIngest,
        progressSleep: user.progressSleep,
        progressAliementation: user.progressAliementation,
        textComplete: user.textComplete,
      );
      print("updateuser ${updatedUser.toJson()}");
      _sharedPreferenceService.setUser(updatedUser);

      UserProfileModel userProfileModel = UserProfileModel(
        weigth: updatedUser.weigth,
        height: updatedUser.height,
        age: updatedUser.age,
        goals: updatedUser.goals,
      );
      firestoreService.addUserProfile(userProfileModel);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dados atualizados com sucesso!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
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
          CustomTextFormField(labelText: "Meta", controller: _metaController),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
              height: 70, text: "Editar Dados", onClick: _saveUserData),
        ],
      ),
    );
  }
}
