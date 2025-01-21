import 'package:flutter/material.dart';

import 'package:firebase_core/firebase_core.dart';
import 'package:health_app/core/configure_providers.dart';
import 'package:health_app/theme/theme.dart';
import 'package:health_app/theme/util.dart';
import 'package:health_app/ui/pages/login_page.dart';
import 'package:health_app/ui/pages/register_page.dart';
import 'package:health_app/ui/widgets/auth_checker.dart';
import 'package:provider/provider.dart';
import 'firebase_options.dart';
import 'package:fl_chart/fl_chart.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  final data = await ConfigureProviders.createDependencyTree();

  runApp(AppRoot(data: data));
}

class AppRoot extends StatelessWidget {
  const AppRoot({super.key, required this.data});

  final ConfigureProviders data;

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    TextTheme textTheme = createTextTheme(context, "Roboto Flex", "Roboto");

    MaterialTheme theme = MaterialTheme(textTheme);
    return MultiProvider(
      providers: data.providers,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Aula',
        theme: theme.light(),
        darkTheme: theme.dark(),
        routes: {
          '/': (context) => const AuthChecker(),
          '/login': (context) => const LoginPage(),
          '/register': (context) => const RegisterPage(),
        },
      ),
    );
  }
}
