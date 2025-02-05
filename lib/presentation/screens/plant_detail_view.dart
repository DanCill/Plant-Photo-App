import 'dart:io';

import 'package:flutter/material.dart';

import '../../data/models/models.dart';

class PlantDetailView extends StatefulWidget {
  final Plant plant;
  final Function(Plant) onUpdatePlant;

  const PlantDetailView({
    super.key,
    required this.plant,
    required this.onUpdatePlant,
  });

  @override
  State<PlantDetailView> createState() => _PlantDetailViewState();
}

class _PlantDetailViewState extends State<PlantDetailView> {
  late TextEditingController _nameController;
  late TextEditingController _notesController;
  bool _isEditing = false;
  final _formKey = GlobalKey<FormState>();

  late Plant _currentPlant;

  @override
  void initState() {
    super.initState();
    _currentPlant = widget.plant;
    _nameController = TextEditingController(text: _currentPlant.name);
    _notesController = TextEditingController(text: _currentPlant.notes);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _notesController.dispose();
    super.dispose();
  }

  void _toggleEdit() {
    setState(() {
      _isEditing = !_isEditing;
      if (!_isEditing) {
        _nameController.text = _currentPlant.name;
        _notesController.text = _currentPlant.notes ?? '';
      }
    });
  }

  void _savePlant() {
    if (_formKey.currentState!.validate()) {
      final updatedPlant = Plant(
        id: _currentPlant.id,
        name: _nameController.text,
        imagePath: _currentPlant.imagePath,
        dateAdded: _currentPlant.dateAdded,
        notes: _notesController.text,
      );

      widget.onUpdatePlant(updatedPlant);
      setState(() {
        _currentPlant = updatedPlant;
        _isEditing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(_isEditing ? 'Edit Plant' : _currentPlant.name),
        actions: [
          IconButton(
            icon: Icon(_isEditing ? Icons.close : Icons.edit),
            onPressed: _toggleEdit,
          ),
          if (_isEditing)
            IconButton(
              icon: const Icon(Icons.check),
              onPressed: _savePlant,
            ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Image.file(
                File(_currentPlant.imagePath),
                height: 300,
                fit: BoxFit.cover,
              ),
              const SizedBox(height: 16),
              if (_isEditing) ...[
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
                    labelText: 'Notes',
                    border: OutlineInputBorder(),
                    alignLabelWithHint: true,
                  ),
                  maxLines: 3,
                ),
              ] else ...[
                Text(
                  'Added on ${_currentPlant.dateAdded.toString().split(' ')[0]}',
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                if (_currentPlant.notes != null &&
                    _currentPlant.notes!.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Notes:',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(_currentPlant.notes!),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }
}
