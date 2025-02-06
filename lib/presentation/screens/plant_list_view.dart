import 'dart:io';

import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:plant_photo_app/providers/plant_provider.dart';
import 'package:provider/provider.dart';

import 'plant_detail_view.dart';
import 'scan_view.dart';

class PlantListView extends StatelessWidget {
  const PlantListView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Plants'),
      ),
      body: Consumer<PlantProvider>(
        builder: (context, plantProvider, child) {
          final plants = plantProvider.plants;

          return plants.isEmpty
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
                            builder: (context) => PlantDetailView(plant: plant),
                          ),
                        );
                      },
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
              builder: (context) => ScanView(camera: cameras.first),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
