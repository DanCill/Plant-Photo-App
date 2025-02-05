import 'package:camera/camera.dart';
import 'package:flutter/material.dart';

import '../../data/models/models.dart';

class ScanView extends StatefulWidget {
  final CameraDescription camera;
  final Function(Plant) onAddPlant;

  const ScanView({
    super.key,
    required this.camera,
    required this.onAddPlant,
  });

  @override
  State<ScanView> createState() => _ScanViewState();
}

class _ScanViewState extends State<ScanView> {
  late CameraController _controller;
  late Future<void> _initializeControllerFuture;
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _notesController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _controller = CameraController(
      widget.camera,
      ResolutionPreset.medium,
    );
    _initializeControllerFuture = _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Add New Plant')),
      resizeToAvoidBottomInset: true,
      body: FutureBuilder<void>(
        future: _initializeControllerFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.4,
                        child: CameraPreview(_controller),
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                            left: 16.0,
                            right: 16.0,
                            top: 16.0,
                            bottom:
                                MediaQuery.of(context).viewInsets.bottom + 16.0,
                          ),
                          child: Form(
                            key: _formKey,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.stretch,
                              children: [
                                TextFormField(
                                  controller: _nameController,
                                  decoration: const InputDecoration(
                                    labelText: 'Plant Name',
                                    border: OutlineInputBorder(),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return 'Please enter a name';
                                    }
                                    return null;
                                  },
                                ),
                                const SizedBox(height: 16),
                                TextFormField(
                                  controller: _notesController,
                                  decoration: const InputDecoration(
                                    labelText: 'Notes (optional)',
                                    border: OutlineInputBorder(),
                                    alignLabelWithHint: true,
                                  ),
                                  maxLines: 3,
                                ),
                                const SizedBox(height: 80),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          try {
            await _initializeControllerFuture;
            final image = await _controller.takePicture();

            if (!_formKey.currentState!.validate()) return;

            final plant = Plant(
              id: DateTime.now().toString(),
              name: _nameController.text,
              imagePath: image.path,
              dateAdded: DateTime.now(),
              notes: _notesController.text,
            );

            widget.onAddPlant(plant);
            Navigator.pop(context);
          } catch (e) {
            print(e);
          }
        },
        child: const Icon(Icons.camera),
      ),
    );
  }
}
