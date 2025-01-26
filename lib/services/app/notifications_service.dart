import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;
import 'package:permission_handler/permission_handler.dart';

class NotificationService {
  final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  final reminders = [
    {
      'hour': 8,
      'minute': 0,
      'title': 'Bom dia!',
      'body': 'Hora de começar o dia com um copo d\'água💧',
    },
    {
      'hour': 10,
      'minute': 0,
      'title': 'Movimente-se!',
      'body': 'Lembre-se de fazer um alongamento🏃',
    },
    {
      'hour': 11,
      'minute': 30,
      'title': 'Alimente-se!',
      'body': 'Lembre-se de fazer uma alimentação saudável',
    },
    {
      'hour': 14,
      'minute': 0,
      'title': 'Hora de se hidratar!',
      'body': 'Não esqueça de beber água💧',
    },
    {
      'hour': 18,
      'minute': 0,
      'title': 'Exercício físico',
      'body': 'Que tal uma caminhada para encerrar o dia?💪',
    },
    {
      'hour': 22,
      'minute': 0,
      'title': 'Sono saudável',
      'body': 'Uma boa noite de sono ajuda na saúde.😴',
    },
  ];

  bool _isFlutterLocalNotificationsInitialized = false;

  NotificationService() {
    initialize();
  }

  Future<void> initialize() async {
    if (_isFlutterLocalNotificationsInitialized) return;

    // Inicializar os dados de fuso horário
    tz.initializeTimeZones();
    tz.setLocalLocation(tz.getLocation('America/Sao_Paulo'));

    await requestNotificationPermission();
    final androidPlugin =
        flutterLocalNotificationsPlugin.resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>();

    const channel = AndroidNotificationChannel(
      'notification_channel_id',
      'Notificações',
      description: 'Canal para notificações do app',
      importance: Importance.high,
    );

    await androidPlugin?.createNotificationChannel(channel);

    const initializationSettingsAndroid =
        AndroidInitializationSettings('@mipmap/ic_launcher');
    const initializationSettings =
        InitializationSettings(android: initializationSettingsAndroid);

    await flutterLocalNotificationsPlugin.initialize(
      initializationSettings,
      onDidReceiveNotificationResponse: (details) {
        print("Notificação clicada: ${details.payload}");
      },
    );

    _isFlutterLocalNotificationsInitialized = true;
  }

  Future<void> requestNotificationPermission() async {
    if (await Permission.notification.isDenied) {
      await Permission.notification.request();
    }
  }

  Future<void> scheduleNotification({
    required String title,
    required String body,
    required DateTime scheduledTime,
  }) async {
    const androidNotificationDetails = AndroidNotificationDetails(
      'notification_channel_id',
      'Notificações',
      channelDescription: 'Canal para notificações do app',
      importance: Importance.max,
      priority: Priority.high,
    );

    const notificationDetails = NotificationDetails(
      android: androidNotificationDetails,
    );

    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      title,
      body,
      _convertToTZDateTime(scheduledTime),
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exact,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  Future<void> scheduleDailyNotifications() async {
    await flutterLocalNotificationsPlugin.cancelAll();

    for (int i = 0; i < reminders.length; i++) {
      final reminder = reminders[i];
      int hour = int.parse(reminder['hour']!.toString());
      int minute = int.parse(reminder['minute']!.toString());

      await flutterLocalNotificationsPlugin.zonedSchedule(
        i,
        reminder['title']!.toString(),
        reminder['body']!.toString(),
        _nextInstanceOfTime(hour, minute),
        const NotificationDetails(
          android: AndroidNotificationDetails(
            'daily_reminders_channel',
            'Daily Reminders',
            channelDescription: 'Reminders throughout the day',
            importance: Importance.high,
            priority: Priority.high,
          ),
        ),
        androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
        uiLocalNotificationDateInterpretation:
            UILocalNotificationDateInterpretation.wallClockTime,
        matchDateTimeComponents: DateTimeComponents.time,
      );
    }
  }

  tz.TZDateTime _nextInstanceOfTime(int hour, int minute) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate =
        tz.TZDateTime(tz.local, now.year, now.month, now.day, hour, minute);

    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }
    return scheduledDate;
  }

  tz.TZDateTime _convertToTZDateTime(DateTime dateTime) {
    final now = tz.TZDateTime.now(tz.local);
    final scheduledDate = tz.TZDateTime(
      tz.local,
      dateTime.year,
      dateTime.month,
      dateTime.day,
      dateTime.hour,
      dateTime.minute,
      dateTime.second,
    );

    return scheduledDate.isBefore(now)
        ? scheduledDate.add(const Duration(days: 1))
        : scheduledDate;
  }
}
