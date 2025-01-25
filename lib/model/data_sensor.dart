import 'package:health/health.dart';
import 'package:flutter/material.dart';

class DataSensor {
  final Map<String, Map<String, dynamic>> data_sensor = {
    "HealthDataType.STEPS": {
      'name': 'Passos',
      'icon': Icons.directions_walk,
      'description': 'Número total de passos dados.',
      'value': 0,
      'unit': 'passos'
    },
    "HealthDataType.HEART_RATE": {
      'name': 'Batimento Cardíaco',
      'icon': Icons.favorite,
      'description': 'Batimento cardíaco em tempo real.',
      'value': 0,
      'unit': 'bpm'
    },
    "HealthDataType.SLEEP_ASLEEP": {
      'name': 'Sono',
      'icon': Icons.bed,
      'description': 'Dados sobre o tempo de sono.',
      'value': 0,
      'unit': 'minutos'
    },
    "HealthDataType.WEIGHT": {
      'name': 'Peso',
      'icon': Icons.fitness_center,
      'description': 'Peso registrado.',
      'value': 0,
      'unit': 'kg'
    },
    "HealthDataType.HEIGHT": {
      'name': 'Altura',
      'icon': Icons.height,
      'description': 'Altura registrada.',
      'value': 0,
      'unit': 'cm'
    },
    "HealthDataType.BLOOD_PRESSURE_DIASTOLIC": {
      'name': 'Pressão Diastólica',
      'icon': Icons.local_hospital,
      'description': 'Medição da pressão arterial.',
      'value': 0,
      'unit': 'mmHg'
    },
    "HealthDataType.BLOOD_PRESSURE_SYSTOLIC": {
      'name': 'Pressão Sistólica',
      'icon': Icons.local_hospital,
      'description': 'Medição da pressão arterial.',
      'value': 0,
      'unit': 'mmHg'
    },
    "HealthDataType.BLOOD_GLUCOSE": {
      'name': 'Glicose no Sangue',
      'icon': Icons.local_pharmacy,
      'description': 'Nível de glicose no sangue.',
      'value': 0,
      'unit': 'mg/dL'
    },
    "HealthDataType.DISTANCE_DELTA": {
      'name': 'Distância Caminhada/Corrida',
      'icon': Icons.directions_run,
      'description': 'Distância percorrida em caminhada ou corrida.',
      'value': 0,
      'unit': 'km'
    },
    "HealthDataType.TOTAL_CALORIES_BURNED": {
      'name': 'Calorias Queimadas',
      'icon': Icons.local_fire_department,
      'description': 'Total de calorias queimadas durante as atividades.',
      'value': 0,
      'unit': 'kcal'
    },
  };

  Map<String, dynamic> getSensorInfo(String sensorType) {
    return data_sensor[sensorType] ??
        {
          'name': 'Desconhecido',
          'icon': Icons.help,
          'description': 'Sem descrição disponível.',
          'value': 0,
          'unit': ''
        };
  }
}
