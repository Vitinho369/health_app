import 'package:health_app/services/app/health_service.dart';
import 'package:health_app/services/firebase/auth_service.dart';
import 'package:health_app/services/app/navigation_bar_service.dart';
import 'package:health_app/services/firebase/firestore_service.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

class ConfigureProviders {
  final List<SingleChildWidget> providers;

  ConfigureProviders({required this.providers});

  static Future<ConfigureProviders> createDependencyTree() async {
    final authService = AuthService();
    final navigationService = NavigationBarService();
    final cloudFiretoreService = CloudFiretoreService();
    final healthService = HealthService();

    return ConfigureProviders(providers: [
      ChangeNotifierProvider<AuthService>.value(value: authService),
      ChangeNotifierProvider<NavigationBarService>.value(
          value: navigationService),
      Provider<CloudFiretoreService>.value(value: cloudFiretoreService),
      ChangeNotifierProvider<HealthService>.value(value: healthService),
    ]);
  }
}
