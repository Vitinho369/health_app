import 'package:flutter/material.dart';
import 'package:health_app/services/firebase/auth_service.dart';
import 'package:health_app/services/app/navigation_bar_service.dart';
import 'package:health_app/ui/pages/goals_page.dart';
import 'package:health_app/ui/pages/habits_page.dart';
import 'package:health_app/ui/pages/user_profile_page.dart';
import 'package:provider/provider.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final navigationService = Provider.of<NavigationBarService>(context);
    return Scaffold(
      bottomNavigationBar: NavigationBar(
        onDestinationSelected: (value) => navigationService.updateIndex(value),
        selectedIndex: navigationService.selectedIndex,
        destinations: const <Widget>[
          NavigationDestination(
            icon: Icon(Icons.videogame_asset_rounded),
            label: 'Metas',
          ),
          NavigationDestination(
            icon: Icon(Icons.health_and_safety),
            label: 'Hábitos',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
      ),
      backgroundColor: Theme.of(context).colorScheme.primaryContainer,
      body: <Widget>[
        const GoalsPage(),
        const HabitsPage(),
        UserProfile(authService: authService),
      ][navigationService.selectedIndex],
    );
  }
}
