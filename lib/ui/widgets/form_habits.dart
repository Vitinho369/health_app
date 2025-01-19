import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:health_app/services/firebase/firestore_service.dart';
import 'package:health_app/ui/widgets/custom_text_form_field.dart';
import 'package:provider/provider.dart';

class FormHabits extends StatefulWidget {
  const FormHabits({super.key});

  @override
  State<FormHabits> createState() => _FormHabitsState();
}

class _FormHabitsState extends State<FormHabits> {
  TextEditingController _exercicioController = TextEditingController();
  TextEditingController _aguaController = TextEditingController();

  late final firestoreService;

  @override
  void initState() {
    super.initState();
    firestoreService =
        Provider.of<CloudFiretoreService>(context, listen: false);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<DocumentSnapshot>(
        stream: firestoreService.getUserProfile(),
        builder: (context, snapshot) {
          if (snapshot.hasData && snapshot.data!.exists) {
            final userData = snapshot.data!.data() as Map<String, dynamic>;
          }

          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                CustomTextFormField(
                    labelText: "Exercício",
                    controller: _exercicioController,
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
              ],
            ),
          );
        });
  }
}
