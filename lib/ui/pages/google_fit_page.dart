import 'package:flutter/material.dart';
import 'package:health_app/services/app/health_service.dart';
import 'package:health_app/services/app/shared_preferences_service.dart';
import 'package:provider/provider.dart';

class GoogleFitPage extends StatefulWidget {
  const GoogleFitPage({super.key});

  @override
  State<GoogleFitPage> createState() => _GoogleFitPageState();
}

class _GoogleFitPageState extends State<GoogleFitPage> {
  late HealthService healthService;
  late SharedPreferencesService sharedPreferencesService;
  bool _isDataFetched = false;

  @override
  void initState() {
    super.initState();
    sharedPreferencesService =
        Provider.of<SharedPreferencesService>(context, listen: false);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    healthService = Provider.of<HealthService>(context, listen: true);
    if (sharedPreferencesService.isGoogleHealthInstall() &&
        !healthService.dataFecthed) {
      _fetchHealthData();
    }
  }

  Future<void> _fetchHealthData() async {
    await healthService.fetchData();
    await healthService.fetchStepData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Fit Integration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!sharedPreferencesService.isGoogleHealthInstall())
              ElevatedButton(
                onPressed: () async {
                  await healthService.installHealthConnect();
                  await healthService.authorize();
                  sharedPreferencesService.setGoogleHealthInstall(true);
                },
                child: const Text('Conectar ao Google Fit'),
              ),
            if (sharedPreferencesService.isGoogleHealthInstall() &&
                !healthService.dataFecthed)
              const CircularProgressIndicator(),
            if (healthService.dataFecthed &&
                sharedPreferencesService.isGoogleHealthInstall())
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  'Total de passos diário: ${healthService.nofSteps}',
                  style: const TextStyle(
                      fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
