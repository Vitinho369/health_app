import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_app/model/habits.dart';
import 'package:health_app/services/firebase/firestore_service.dart';
import 'package:health_app/ui/widgets/custom_button.dart';
import 'package:health_app/ui/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class FormHabits extends StatefulWidget {
  const FormHabits({super.key});

  @override
  State<FormHabits> createState() => _FormHabitsState();
}

class _FormHabitsState extends State<FormHabits> {
  TextEditingController _exercicioController = TextEditingController();
  TextEditingController _exercicioTimeController = TextEditingController();
  TextEditingController _aguaController = TextEditingController();
  TextEditingController _sleepDurationController = TextEditingController();

  late final firestoreService;

  @override
  void initState() {
    super.initState();
    firestoreService =
        Provider.of<CloudFiretoreService>(context, listen: false);
  }

  void sendHabit() async {
    print("askamskamsak");
    if (_aguaController.text.isNotEmpty &&
        _exercicioController.text.isNotEmpty &&
        _exercicioTimeController.text.isNotEmpty &&
        _sleepDurationController.text.isNotEmpty) {
      await firestoreService.addHabit(Habits(
          exercise: _exercicioController.text,
          timeExercise: int.parse(_exercicioTimeController.text),
          waterQtd: int.parse(_aguaController.text),
          sleepDuration: int.parse(_sleepDurationController.text)));
    }
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: firestoreService.getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final habitDatas = snapshot.data!.data() as Map<String, dynamic>;
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextFormField(
                    labelText: "Exercício",
                    controller: _exercicioController,
                    keyboardType: TextInputType.text),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                    labelText: "Tempo de exercício",
                    controller: _exercicioTimeController,
                    keyboardType: TextInputType.number),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  labelText: "Ml de água",
                  controller: _aguaController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextFormField(
                  labelText: "Duração do sono",
                  controller: _sleepDurationController,
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomButton(
                  height: 70,
                  text: "Enviar hábito diário",
                  onClick: sendHabit,
                )
              ],
            ),
          );
        });
  }
}
