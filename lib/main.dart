import 'package:flutter/material.dart';
import 'package:plant_photo_app/providers/plant_provider.dart';
import 'package:plant_photo_app/theme/theme.dart';
import 'package:provider/provider.dart';

import 'presentation/screens/plant_list_view.dart';
import 'presentation/screens/profile_view.dart';
import 'presentation/screens/settings_view.dart';

void main() {
  runApp(const PlantApp());
}

class PlantApp extends StatelessWidget {
  const PlantApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (_) => PlantProvider(),
        child: MaterialApp(
          title: 'Plant Photo App',
          theme: lightMode,
          darkTheme: darkMode,
          home: const MainScreen(),
        ));
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      const PlantListView(),
      const SettingsView(),
      const ProfileView(),
    ];

    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: NavigationBar(
        backgroundColor: Theme.of(context).colorScheme.background,
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.local_florist),
            label: 'Plants',
          ),
          NavigationDestination(
            icon: Icon(Icons.settings),
            label: 'Settings',
          ),
          NavigationDestination(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
