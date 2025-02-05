import 'package:flutter/material.dart';
import 'package:plant_photo_app/theme/theme.dart';

import 'data/models/models.dart';
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
    return MaterialApp(
      title: 'Plant Photo App',
      theme: lightMode,
      darkTheme: darkMode,
      home: const MainScreen(),
    );
  }
}

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _selectedIndex = 0;
  final List<Plant> _plants = [];

  @override
  Widget build(BuildContext context) {
    final List<Widget> pages = [
      PlantListView(
          plants: _plants, onAddPlant: _addPlant, onUpdatePlant: _updatePlant),
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

  void _addPlant(Plant plant) {
    setState(() {
      _plants.add(plant);
    });
  }

  void _updatePlant(Plant updatedPlant) {
    setState(() {
      final index = _plants.indexWhere((p) => p.id == updatedPlant.id);
      if (index != -1) {
        _plants[index] = updatedPlant;
      }
    });
  }
}
