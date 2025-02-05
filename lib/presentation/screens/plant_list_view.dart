import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../data/models/models.dart';
import 'plant_detail_view.dart';
import 'scan_view.dart';

class PlantListView extends StatelessWidget {
  final List<Plant> plants;
  final Function(Plant) onAddPlant;
  final Function(Plant) onUpdatePlant;

  const PlantListView(
      {super.key,
      required this.plants,
      required this.onAddPlant,
      required this.onUpdatePlant});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Plants'),
      ),
      body: plants.isEmpty
          ? const Center(
              child: Text('No plants added yet'),
            )
          : ListView.builder(
              itemCount: plants.length,
              itemBuilder: (context, index) {
                final plant = plants[index];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundImage: FileImage(File(plant.imagePath)),
                  ),
                  title: Text(plant.name),
                  subtitle: Text(
                    'Added on ${plant.dateAdded.toString().split(' ')[0]}',
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlantDetailView(
                            plant: plant, onUpdatePlant: onUpdatePlant),
                      ),
                    );
                  },
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final cameras = await availableCameras();
          if (cameras.isEmpty) return;

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ScanView(
                camera: cameras.first,
                onAddPlant: onAddPlant,
              ),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
