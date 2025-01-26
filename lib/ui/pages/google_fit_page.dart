import 'package:flutter/material.dart';
import 'package:health_app/services/app/health_service.dart';
import 'package:health_app/services/app/shared_preferences_service.dart';
import 'package:health_app/ui/widgets/data_fit_box.dart';
import 'package:provider/provider.dart';

class GoogleFitPage extends StatefulWidget {
  const GoogleFitPage({super.key});

  @override
  State<GoogleFitPage> createState() => _GoogleFitPageState();
}

class _GoogleFitPageState extends State<GoogleFitPage> {
  late HealthService healthService;
  late SharedPreferencesService sharedPreferencesService;

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
  }

  @override
  Widget build(BuildContext context) {
    return sharedPreferencesService.isGoogleHealthInstall()
        ? healthService.dataFecthed
            ? Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    // Título antes do ListView
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text(
                            'Dados Google Fit',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          IconButton(
                              onPressed: _fetchHealthData,
                              icon: Icon(Icons.refresh)),
                        ],
                      ),
                    ),
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(8.0),
                        itemCount:
                            healthService.dataSensor.data_sensor.entries.length,
                        itemBuilder: (context, index) {
                          final listData = healthService
                              .dataSensor.data_sensor.entries
                              .toList();
                          final data = listData[index].value;

                          if (data["value"] == 0)
                            return const SizedBox.shrink();
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 8.0),
                            child: DataFitBox(
                              title: data["name"],
                              value: data["value"].toString(),
                              icon: Icon(
                                data["icon"],
                                size: 40,
                              ),
                              unit: data["unit"],
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
              )
            : const Center(child: CircularProgressIndicator())
        : Center(
            child: ElevatedButton(
              onPressed: () async {
                await healthService.installHealthConnect();
                await healthService.authorize();
                sharedPreferencesService.setGoogleHealthInstall(true);
              },
              child: const Text('Conectar ao Google Fit'),
            ),
          );
  }
}
