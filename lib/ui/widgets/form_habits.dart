import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_app/model/habits.dart';
import 'package:health_app/services/app/shared_preferences_service.dart';
import 'package:health_app/services/firebase/firestore_service.dart';
import 'package:health_app/ui/widgets/custom_button.dart';
import 'package:health_app/ui/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class FormHabits extends StatefulWidget {
  const FormHabits({super.key});

  @override
  State<FormHabits> createState() => _FormHabitsState();
}

class _FormHabitsState extends State<FormHabits> with WidgetsBindingObserver {
  TextEditingController _exercicioController = TextEditingController();
  TextEditingController _exercicioTimeController = TextEditingController();
  TextEditingController _aguaController = TextEditingController();
  TextEditingController _sleepDurationController = TextEditingController();
  TextEditingController _weigthnController = TextEditingController();

  late final firestoreService;
  late final sharedPreferencesServices;

  @override
  void initState() {
    super.initState();
    firestoreService =
        Provider.of<CloudFiretoreService>(context, listen: false);

    sharedPreferencesServices =
        Provider.of<SharedPreferencesService>(context, listen: false);
    WidgetsBinding.instance.addObserver(this);
    _loadTodayHabit();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    if (state == AppLifecycleState.resumed) {
      _loadTodayHabit();
    }
  }

  void sendHabit() async {
    if (_aguaController.text.isNotEmpty &&
        _exercicioController.text.isNotEmpty &&
        _exercicioTimeController.text.isNotEmpty &&
        _sleepDurationController.text.isNotEmpty) {
      final day = DateTime.now().day;
      final month = DateTime.now().month;
      final year = DateTime.now().year;

      Habits habit = Habits(
          exercise: _exercicioController.text,
          timeExercise: int.parse(_exercicioTimeController.text),
          waterQtd: int.parse(_aguaController.text),
          sleepDuration: int.parse(_sleepDurationController.text),
          weigth: double.parse(_weigthnController.text),
          date: DateTime(year, month, day),
          timestamp: Timestamp.now());
      print("Hábito ${habit.toJson()}");
      sharedPreferencesServices.setHabit(habit);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Dados enviados com sucesso!")),
      );
      await firestoreService.addHabit(Habits(
          exercise: _exercicioController.text,
          timeExercise: int.parse(_exercicioTimeController.text),
          waterQtd: int.parse(_aguaController.text),
          sleepDuration: int.parse(_sleepDurationController.text),
          weigth: double.parse(_weigthnController.text),
          date: DateTime(year, month, day),
          timestamp: Timestamp.now()));
    }
  }

  Future<void> _loadTodayHabit() async {
    // Data atual no formato ISO para comparação
    Habits habit = sharedPreferencesServices.getHabit();

    if (habit.exercise!.isNotEmpty &&
        habit.timeExercise! > 0 &&
        habit.waterQtd! > 0 &&
        habit.sleepDuration! > 0 &&
        habit.weigth! > 0) {
      _exercicioController.text = habit.exercise ?? '';
      _exercicioTimeController.text = habit.timeExercise?.toString() ?? '';
      _aguaController.text = habit.waterQtd?.toString() ?? '';
      _sleepDurationController.text = habit.sleepDuration?.toString() ?? '';
      _weigthnController.text = habit.weigth?.toString() ?? '';
    } else {
      _exercicioController.clear();
      _exercicioTimeController.clear();
      _aguaController.clear();
      _sleepDurationController.clear();
      _weigthnController.clear();
      print("limpei");
    }
  }

  @override
  Widget build(BuildContext context) {
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
          CustomTextFormField(
            labelText: "Peso diário",
            controller: _weigthnController,
            keyboardType: TextInputType.number,
          ),
          const SizedBox(
            height: 10,
          ),
          CustomButton(
            height: 70,
            text: "Enviar dados diários",
            onClick: sendHabit,
          )
        ],
      ),
    );
  }
}
