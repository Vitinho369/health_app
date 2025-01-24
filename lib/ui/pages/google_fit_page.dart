import 'package:flutter/material.dart';
import 'package:health_app/services/app/health_service.dart';
import 'package:provider/provider.dart';

class GoogleFitPage extends StatefulWidget {
  const GoogleFitPage({super.key});

  @override
  State<GoogleFitPage> createState() => _GoogleFitPageState();
}

class _GoogleFitPageState extends State<GoogleFitPage> {
  late HealthService healthService;

  bool _isDataFetched = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    healthService = Provider.of<HealthService>(context, listen: true);

    if (healthService.healthConnectionInstall && !_isDataFetched) {
      _isDataFetched = true;
      _fetchHealthData();
    }
  }

  Future<void> _fetchHealthData() async {
    await healthService.fetchData();
    await healthService.fetchStepData();
    setState(() {
      _isDataFetched = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    healthService.installHealthConnect(); // Conecta ao Google Fit
    healthService.authorize();
    return Scaffold(
      appBar: AppBar(
        title: const Text('Google Fit Integration'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            if (!healthService.healthConnectionInstall)
              ElevatedButton(
                onPressed: () {},
                child: const Text('Conectar ao Google Fit'),
              ),
            if (_isDataFetched)
              Expanded(
                child: Text(
                  'Steps: ${healthService.nofSteps}',
                ),
                //   child: ListView.builder(
                //     itemCount: healthService.healthDataList.length,
                //     itemBuilder: (context, index) {
                //       return ListTile(
                //         title: Text(
                //             'Steps: ${healthService.healthDataList[index].value}'),
                //         subtitle: Text(
                //             'Date: ${healthService.healthDataList[index].dateFrom}'),
                //       );
                //     },
                //   ),
              ),
            if (!_isDataFetched && healthService.healthConnectionInstall)
              const CircularProgressIndicator(), // Exibe um carregando se os dados não estiverem carregados
          ],
        ),
      ),
    );
  }
}
